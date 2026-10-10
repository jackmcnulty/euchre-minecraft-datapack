# Changelog

All notable changes to this project are documented here. Format: [Keep a Changelog](https://keepachangelog.com/en/1.1.0/); versions follow [SemVer](https://semver.org/).

## [Unreleased]

### Added
- **Tables:** `euchre:setup`, `setup_custom {wager,target}` and `setup_advanced` validate their config and adopt 4 builder-placed cushions as the N/E/S/W seats. They summon card spots, seat labels and a scoreboard display.
- **Seating:** players sit by right-clicking a cushion and need 5 empty hotbar slots. Sneaking or disconnecting frees the seat. Rejoining clears stale state.
- `euchre:remove_table`, `euchre:rebind`, `euchre:uninstall`. Cushions are always released, never killed.
- Setup failures report what was found. Refusal reasons are kept in `euchre:tmp last_error`.
- Lint rules for quote and bracket balance per line, and for position-scale overflow.
- **Dealing:** a full free table starts a game. It shuffles (Fisher-Yates with `/random`), deals 5 cards into each player's empty hotbar slots, and shows the up card on the table.
- **Hand integrity:** card items carry a per-deal id. Every 10 ticks each hand is reconciled against storage, so dropped, duplicated, stale and smuggled cards are fixed. Stray cards anywhere else are swept every second.
- All card-item commands are generated from one item definition in `tools/gen.py`.
- **Trick play:** hold a card and right-click your spot. Turn order, card ownership (per storage) and phase are validated. Played cards lie face up on the table. The best card wins the trick (bowers, trump, led suit) and its player leads next.
- **Rules engine:** pure scoreboard functions `rules/eff_suit`, `rules/power` and `rules/trick_winner`. They are checked by golden tests generated from a Python reference model: every card under every trump and led suit, plus 60 seeded random tricks.
- **Follow suit:** illegal plays are refused, and the left bower counts as trump. Covered by 150 generated follow-suit cases and hand-written left-bower edge cases.
- Repository skeleton: datapack and resource pack (`pack.mcmeta` for 26.3, formats 121.0 / 97.1).
- Idempotent `euchre:load`, near-zero-cost `euchre:tick`, `euchre:selftest`.
- `tools/gen.py` (generated card table, hotbar helpers), `tools/lint.py`, `tools/build.py`.
- CI: lint, PackTest suite on Fabric 26.3, vanilla server smoke test. Tag-triggered release workflow.

### Fixed
- Table geometry no longer overflows score limits for tables more than ~21 million blocks from spawn.
- The plain-diamond predicate matched no diamonds: default components are now compared by value.
