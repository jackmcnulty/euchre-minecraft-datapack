"""Build release zips: dist/euchre-datapack-<ver>.zip and dist/euchre-resourcepack-<ver>.zip.

Runs the generator check and the linter first, so a release can never contain
stale generated files or lint violations. Zips have pack.mcmeta at their root,
as Minecraft requires.

Usage: python tools/build.py [--version 1.0.0]
"""

from __future__ import annotations

import argparse
import subprocess
import sys
import zipfile
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
DIST = ROOT / "dist"
PACKS = {"datapack": "euchre-datapack", "resourcepack": "euchre-resourcepack"}


def run(script: str, *args: str) -> None:
    r = subprocess.run([sys.executable, str(ROOT / "tools" / script), *args])
    if r.returncode:
        sys.exit(r.returncode)


def zip_dir(src: Path, dest: Path) -> int:
    files = sorted(p for p in src.rglob("*") if p.is_file())
    with zipfile.ZipFile(dest, "w", zipfile.ZIP_DEFLATED) as z:
        for p in files:
            # Fixed timestamp keeps builds reproducible.
            info = zipfile.ZipInfo(p.relative_to(src).as_posix(), date_time=(2026, 1, 1, 0, 0, 0))
            info.compress_type = zipfile.ZIP_DEFLATED
            z.writestr(info, p.read_bytes())
    return len(files)


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--version", default="dev")
    args = ap.parse_args()

    run("gen.py", "--check")
    run("lint.py")

    DIST.mkdir(exist_ok=True)
    for folder, stem in PACKS.items():
        dest = DIST / f"{stem}-{args.version}.zip"
        n = zip_dir(ROOT / folder, dest)
        print(f"built {dest.relative_to(ROOT).as_posix()} ({n} files)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
