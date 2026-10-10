# Changelog

All notable changes to this project are documented here. Format: [Keep a Changelog](https://keepachangelog.com/en/1.1.0/); versions follow [SemVer](https://semver.org/).

## [Unreleased]

### Fixed
- A player returning to a seat the table never saw them leave (the server stopped while they were seated, e.g. quitting single player) was counted twice.

### Added
- docs/singleplayer-validation.md: a step-by-step solo validation guide.

## [0.9.0] - 2026-10-09

First public pre-release, for playtesting before 1.0.0. Minecraft Java Edition 26.3 (data pack format 121, resource pack format 97.1). Feature-complete; 1.0.0 follows once the manual QA checklist in docs/testing.md has been run with real players.

### Game
- **Tables:** built from your own blocks and four cushions. Set one up with `euchre:setup`, `setup_custom {wager,target}` or `setup_advanced`, which validate the config and show it on the table's display.
- **Seating:** right-click a cushion; sneak to stand. Five empty hotbar slots are required, and your own items are never moved.
- **Dealing:** a Fisher–Yates shuffle with `/random`. Five cards are dealt into the hotbar and the up card is shown on the table.
- **Bidding:** round 1 (order up or pass, then the dealer picks up and discards) and round 2 (name a suit other than the turned-down one), using clickable chat buttons. Stick-the-dealer or redeal, per table.
- **Going alone:** the partner sits out and tricks have three cards. If the dealer is the partner, they don't pick up.
- **Trick play:** hold a card and right-click your spot. Turn order, card ownership and follow suit (by effective suit, with the left bower as trump) are enforced, and illegal plays are refused with a reason.
- **Scoring:** 1 / 2 / 4 points, and 2 to the defenders for a euchre. The game is played to the table's target, and a new game starts automatically.
- **Leavers:** a player who stands up or disconnects pauses the game and their seat is held. Returning resumes it, cards included. After the grace period their team forfeits, or the game is cancelled if both teams left. Server restarts are handled the same way.
- **Hand integrity:** storage is the source of truth. Dropped, duplicated, stale or smuggled cards are corrected, and strays are removed.
- **Polish:** sounds, particles, and a board showing the score, trump, turn and pot. Seat labels mark whose turn it is and who sits out.

### Wagers
- An ante with chat confirmation, and **atomic** collection: if anyone is short, nothing is taken. Only unmodified diamonds count.
- Per-table escrow. Winners split the recorded pot, and every stake is refunded when a game is cancelled or a table is removed.
- Payouts owed to offline players are delivered when they return. Overflow drops are owner-only and never despawn.
- A conservation ledger (`collected = delivered + held + owed`) is checked after every change and freezes wagering on a mismatch. A 256-entry audit log and admin tools are included. See docs/escrow.md.

### Card art
- A generated pixel-art resource pack: 24 faces and a back. Held cards show their face only to their holder, and cards on the table lie face up. No vanilla item is re-skinned.

### Engineering
- `tools/gen.py` generates the repetitive files (card helpers, chat prompts, objectives, escrow choke points, card art, golden tests). Generated files are committed and checked in CI.
- `tools/lint.py` enforces the project invariants: diamond choke points, namespacing, cushions never killed, no score overflow, valid NBT paths, phase dispatch returns, and resolvable references.
- CI runs lint, a PackTest suite of 26 in-game test files (over 1,200 assertions, about 900 of them generated from a reference model), and a vanilla server smoke test. A tag-triggered release workflow builds the zips.

### Fixed during development (caught by tests)
- Table geometry overflowed score limits for tables more than about 21 million blocks from spawn.
- The plain-diamond predicate matched no diamonds, because default components have to be compared by value.
- The game-over pause was skipped (the phase timer dispatched twice in one tick).
- Delivering one player's pending payout could falsely trip the ledger check while others were still pending.
