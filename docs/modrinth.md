# Modrinth listing (draft)

Publishing is manual for now. Modrinth needs an account, and its token must
never live in this repo.

## Projects

Modrinth lists data packs and resource packs as separate projects. Create two:

| | Datapack project | Resource pack project |
|---|---|---|
| Name | Euchre | Euchre Cards |
| Slug | `euchre` | `euchre-cards` |
| Type | Data pack | Resource pack |
| Files | `euchre-datapack-<ver>.zip` | `euchre-resourcepack-<ver>.zip` |
| Game version | 26.3 | 26.3 |
| Loader | Data pack | Minecraft (resource pack) |
| Dependency | Euchre Cards: *required* | none |
| License | MIT | MIT |
| Source | https://github.com/jackmcnulty/euchre-minecraft-datapack | same |
| Categories | Game mechanics, Minigame, Social | Decoration, Simplistic |

## Summary (one line)

A complete, rules-enforcing Euchre table for survival worlds: bid, play and score at a table you build, optionally for diamond stakes held in escrow.

## Description

Play **Euchre** with three friends at a table you build yourself. Four cushions become seats, cards are dealt into your hotbar, and you play by right-clicking your spot on the table. The datapack enforces every rule: the bowers, following suit, both bidding rounds, going alone, and scoring to a target you choose.

- 🎴 **The full game:** a 24-card deck, partnerships, stick-the-dealer or redeal, going alone, and configurable target
- 🚫 **No cheating:** illegal plays are refused, nobody can see your cards, and stray or duplicated cards are cleaned up
- 💎 **Optional diamond stakes:** all-or-nothing collection, escrow, winner payouts, and refunds whenever a game is cancelled, with an audit log for admins
- 🔌 **Leave and come back:** disconnects and restarts pause the game instead of ruining it
- 🌿 **Survival-safe and pure vanilla:** no mods or plugins, and nothing of value created on free tables

**Requires the Euchre Cards resource pack** for card art. Servers: set it as the server resource pack.

Setup: build a table, place four cushions around it, stand in the middle of the tabletop and run `/function euchre:setup`. Full instructions are in the README on GitHub.

## Gallery

- `docs/images/cards.png`: the card art
- TODO: a screenshot of a table mid-game, and the demo GIF
