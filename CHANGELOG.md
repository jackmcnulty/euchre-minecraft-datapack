# Changelog

All notable changes to this project are documented here. Format: [Keep a Changelog](https://keepachangelog.com/en/1.1.0/); versions follow [SemVer](https://semver.org/).

## [Unreleased]

### Added
- **Tables:** `euchre:setup`, `setup_custom {wager,target}` and `setup_advanced` validate their config and adopt 4 builder-placed cushions as the N/E/S/W seats. They summon card spots, seat labels and a scoreboard display.
- **Seating:** players sit by right-clicking a cushion and need 5 empty hotbar slots. Sneaking or disconnecting frees the seat. Rejoining clears stale state.
- `euchre:remove_table`, `euchre:rebind`, `euchre:uninstall`. Cushions are always released, never killed.
- Setup failures report what was found. Refusal reasons are kept in `euchre:tmp last_error`.
- Lint rules for quote and bracket balance per line, and for position-scale overflow.
- Repository skeleton: datapack and resource pack (`pack.mcmeta` for 26.3, formats 121.0 / 97.1).
- Idempotent `euchre:load`, near-zero-cost `euchre:tick`, `euchre:selftest`.
- `tools/gen.py` (generated card table, hotbar helpers), `tools/lint.py`, `tools/build.py`.
- CI: lint, PackTest suite on Fabric 26.3, vanilla server smoke test. Tag-triggered release workflow.

### Fixed
- Table geometry no longer overflows score limits for tables more than ~21 million blocks from spawn.
- The plain-diamond predicate matched no diamonds: default components are now compared by value.
