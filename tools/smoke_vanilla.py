"""Mod-free smoke test: boot a vanilla dedicated server with the datapack and
confirm it loads cleanly and passes euchre:selftest.

PackTest (a Fabric mod) runs the real test suite; this job exists so we always
have a signal from an unmodded server, which is what players actually run.

Usage: python tools/smoke_vanilla.py --server-jar path/to/server.jar [--workdir .ci/vanilla]
Exit code 0 on success, 1 on failure.
"""

from __future__ import annotations

import argparse
import queue
import re
import shutil
import subprocess
import sys
import threading
import time
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
PASS_MARKER = "EUCHRE_SELFTEST_PASS"
# Log lines that indicate our pack failed to load something.
ERROR_PATTERNS = [
    re.compile(r"(ERROR|WARN).*euchre", re.I),
    re.compile(r"Failed to load function euchre:", re.I),
    re.compile(r"Couldn't (load|parse).*euchre", re.I),
]


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--server-jar", required=True, type=Path)
    ap.add_argument("--workdir", default=ROOT / ".ci" / "vanilla", type=Path)
    ap.add_argument("--timeout", default=300, type=int)
    args = ap.parse_args()

    work: Path = args.workdir
    if work.exists():
        shutil.rmtree(work)
    (work / "world" / "datapacks").mkdir(parents=True)
    shutil.copytree(ROOT / "datapack", work / "world" / "datapacks" / "euchre")
    (work / "eula.txt").write_text("eula=true\n")
    (work / "server.properties").write_text(
        "level-name=world\nonline-mode=false\nlevel-type=minecraft\\:flat\n"
        "generate-structures=false\nspawn-protection=0\nmax-players=1\n"
    )

    proc = subprocess.Popen(
        ["java", "-Xmx1G", "-jar", str(args.server_jar.resolve()), "--nogui"],
        cwd=work, stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
        text=True, encoding="utf-8", errors="replace", bufsize=1,
    )
    lines: queue.Queue[str] = queue.Queue()
    threading.Thread(target=lambda: [lines.put(l) for l in proc.stdout], daemon=True).start()

    def send(cmd: str) -> None:
        proc.stdin.write(cmd + "\n")
        proc.stdin.flush()

    log: list[str] = []
    sent = False
    passed = False
    deadline = time.monotonic() + args.timeout
    while time.monotonic() < deadline and proc.poll() is None:
        try:
            line = lines.get(timeout=1)
        except queue.Empty:
            continue
        print(line, end="")
        log.append(line)
        if not sent and "Done (" in line:
            send("datapack list enabled")
            send(f"execute if function euchre:selftest run say {PASS_MARKER}")
            send("stop")
            sent = True
        if PASS_MARKER in line and "[Server]" in line:
            passed = True

    if proc.poll() is None:
        proc.kill()
        print("smoke: timed out", file=sys.stderr)
        return 1

    problems = [l.rstrip() for l in log if any(p.search(l) for p in ERROR_PATTERNS)]
    for p in problems:
        print(f"smoke: load problem: {p}", file=sys.stderr)
    if not passed:
        print("smoke: euchre:selftest did not pass (is the pack enabled?)", file=sys.stderr)
    ok = passed and not problems
    print("smoke: ok" if ok else "smoke: FAILED")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
