"""Static checks for the datapack that Minecraft itself won't catch.

Rules (each one protects an invariant from the design docs):
  json        every .json / .mcmeta file parses
  namespace   datapack files live under data/euchre/, except the two
              minecraft:load / minecraft:tick function tags
  prefix      scoreboard objectives, entity tags and storages are euchre-prefixed
  diamonds    only escrow/collect may remove diamonds and only escrow/deliver may
              give them (the escrow choke points; see docs/escrow.md)
  cushions    cushions are player-owned: nothing may kill them
  refs        every `function euchre:...` reference resolves to a file

Usage: python tools/lint.py   (exit 1 on any violation)
"""

from __future__ import annotations

import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
DP_DATA = ROOT / "datapack" / "data"
FUNC_ROOTS = {
    "euchre": DP_DATA / "euchre" / "function",
    "euchre_test": ROOT / "tests" / "packtest" / "data" / "euchre_test" / "function",
}
ALLOWED_MINECRAFT = {
    DP_DATA / "minecraft" / "tags" / "function" / "load.json",
    DP_DATA / "minecraft" / "tags" / "function" / "tick.json",
}
# The only functions allowed to touch diamonds, relative to data/euchre/function/.
DIAMOND_TAKE = "escrow/collect.mcfunction"
DIAMOND_GIVE = "escrow/deliver.mcfunction"

RE_DIAMOND = re.compile(r"(?<![\w.])(?:minecraft:)?diamond(?![\w])")
RE_OBJECTIVE = re.compile(r"\bscoreboard objectives add (\S+)")
RE_TAG = re.compile(r"\btag \S+ (?:add|remove) (\S+)")
RE_STORAGE = re.compile(r"\bstorage ([a-z0-9_.-]+):")
RE_FUNC_REF = re.compile(r"\bfunction (euchre(?:_test)?):([a-z0-9_/.-]+)")
RE_KILL_CUSHION = re.compile(r"\bkill\b.*cushion")

errors: list[str] = []


def err(path: Path, line: int | None, rule: str, msg: str) -> None:
    where = path.relative_to(ROOT).as_posix() + (f":{line}" if line else "")
    errors.append(f"{where}: [{rule}] {msg}")


def check_json() -> None:
    for p in ROOT.rglob("*"):
        if p.suffix in {".json", ".mcmeta"} and ".git" not in p.parts and "dist" not in p.parts:
            try:
                json.loads(p.read_text(encoding="utf-8"))
            except json.JSONDecodeError as e:
                err(p, e.lineno, "json", e.msg)


def check_namespace() -> None:
    for p in DP_DATA.rglob("*"):
        if p.is_file() and p.parts[len(DP_DATA.parts)] != "euchre" and p not in ALLOWED_MINECRAFT:
            err(p, None, "namespace", "only data/euchre/ (plus minecraft load/tick tags) is allowed")


def function_exists(ns: str, name: str) -> bool:
    root = FUNC_ROOTS.get(ns)
    return root is not None and (root / f"{name}.mcfunction").is_file()


def check_mcfunctions() -> None:
    files = list((DP_DATA / "euchre").rglob("*.mcfunction"))
    files += list((ROOT / "tests" / "packtest").rglob("*.mcfunction"))
    euchre_fn = DP_DATA / "euchre" / "function"
    for p in files:
        in_pack = euchre_fn in p.parents
        relname = p.relative_to(euchre_fn).as_posix() if in_pack else None
        for n, raw in enumerate(p.read_text(encoding="utf-8").splitlines(), 1):
            line = raw.strip()
            if not line or line.startswith("#"):
                continue
            body = line[1:] if line.startswith("$") else line  # macro lines

            for name in RE_OBJECTIVE.findall(body):
                if not name.startswith("euchre."):
                    err(p, n, "prefix", f"objective '{name}' must start with 'euchre.'")
            for name in RE_TAG.findall(body):
                if not name.startswith(("euchre.", "$(")):
                    err(p, n, "prefix", f"entity tag '{name}' must start with 'euchre.'")
            for ns in RE_STORAGE.findall(body):
                if ns not in ("euchre", "euchre_test"):
                    err(p, n, "prefix", f"storage namespace '{ns}' must be euchre")

            if in_pack and RE_DIAMOND.search(body):
                allowed = (
                    relname == DIAMOND_TAKE and re.search(r"\bclear\b", body)
                ) or (relname == DIAMOND_GIVE and re.search(r"\bgive\b", body))
                if not allowed:
                    err(p, n, "diamonds",
                        f"diamonds may only be cleared in {DIAMOND_TAKE} and given in {DIAMOND_GIVE}")

            # Tests may clean up the cushions their own fixtures summoned.
            if in_pack and RE_KILL_CUSHION.search(body):
                err(p, n, "cushions", "cushions belong to the builder and must never be killed")

            for ns, name in RE_FUNC_REF.findall(body):
                if "$(" not in name and not function_exists(ns, name):
                    err(p, n, "refs", f"function {ns}:{name} does not exist")


def check_json_refs() -> None:
    """Function references inside JSON (function tags, advancement rewards)."""
    refs: list[tuple[Path, str]] = []
    for p in DP_DATA.glob("*/tags/function/*.json"):
        refs += [(p, v) for v in json.loads(p.read_text(encoding="utf-8")).get("values", [])]
    for p in DP_DATA.glob("*/advancement/**/*.json"):
        fn = json.loads(p.read_text(encoding="utf-8")).get("rewards", {}).get("function")
        if fn:
            refs.append((p, fn))
    for p, ref in refs:
        ns, _, name = ref.partition(":")
        if ns.startswith("euchre") and not function_exists(ns, name):
            err(p, None, "refs", f"function {ref} does not exist")


def main() -> int:
    check_json()
    check_namespace()
    check_mcfunctions()
    check_json_refs()
    for e in errors:
        print(e, file=sys.stderr)
    if errors:
        print(f"lint: {len(errors)} problem(s)", file=sys.stderr)
        return 1
    print("lint: ok")
    return 0


if __name__ == "__main__":
    sys.exit(main())
