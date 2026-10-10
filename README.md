# Euchre for Minecraft

A fully rules-enforcing game of **Euchre** for Minecraft Java Edition **26.3**. It's played at a table you build yourself in a survival world, as a vanilla **datapack** with a companion resource pack for the card art. You can play for free or stake diamonds held in auditable escrow.

> **Status: early development (M3 done: tables, seating, dealing, and playing tricks).** Until bidding lands, trump is the up card's suit, and follow-suit isn't enforced yet. See the [roadmap](#roadmap).

<!-- TODO(M10): demo GIF -->

## Why this exists

Other projects bring cards into Minecraft, such as card-only packs and a physical blackjack table. None of them enforce a trick-taking game's rules. This datapack enforces all of Euchre's: bowers, effective suit, following suit, bidding, going alone, and scoring.

## Install

1. Download `euchre-datapack-<version>.zip` and `euchre-resourcepack-<version>.zip` from Releases.
2. Put the datapack zip in `<world>/datapacks/` and run `/reload`.
3. Serve the resource pack. On a server, use `resource-pack` in `server.properties`. In single player, put it in `resourcepacks/`.

## Setting up a table

1. Build a table from any blocks.
2. Place **4 cushions** around it, one on each side (north, east, south and west), within 3 blocks of the centre. The cushions are yours: the datapack only tags them and never breaks, moves or deletes them.
3. Stand on the **centre of the tabletop** and run one of these:

```mcfunction
/function euchre:setup                               # free play, first to 5
/function euchre:setup_custom {wager:0,target:10}    # free play, first to 10
/function euchre:setup_custom {wager:10,target:5}    # each player stakes 10 diamonds
/function euchre:setup_advanced {wager:10,target:5,stick_dealer:1,grace_s:120}
```

| Option | Range | Meaning |
|---|---|---|
| `wager` | 0–256 | Diamonds each player stakes. 0 means free play. |
| `target` | 1–25 | Points needed to win. |
| `stick_dealer` | 0 or 1 | 1: if everyone passes twice, the dealer must name trump. 0: redeal. |
| `grace_s` | 30–600 | Seconds a player who leaves mid-game has to come back. |

The config is fixed while the table exists. To change it, remove the table and set it up again.

**Sitting:** right-click a cushion. You need **5 empty hotbar slots**, because your cards are dealt there. Your own items are never moved. To get up, sneak.

**Cards:** when all four seats are filled on a free table, the cards are shuffled and each player is dealt 5. The table's state is the source of truth: a card you drop or pass to someone comes back to your hand, and duplicates or leftover cards disappear. **Playing:** on your turn, hold a card and right-click the spot on the table in front of you. The card lies face up there; when everyone has played, the best card takes the trick and its player leads next.

For now, a player leaving mid-game stops the game. A grace period to return arrives with leaver handling.

### Operator commands
| Command | What it does |
|---|---|
| `/function euchre:remove_table` | Removes the nearest table (within 8 blocks). Seated players are stood up and the cushions are released. |
| `/function euchre:rebind` | A cushion was broken: place a new one on the same side and run this. |
| `/function euchre:uninstall` | Removes all Euchre data. It refuses while diamonds are held or owed. Afterwards, run `/datapack disable` on the pack. |

### Good to know
- **One table per world** for now. The data model already supports more.
- **A seated player who logs out takes their cushion with them.** That's vanilla behaviour: a vehicle is saved with its rider, the way a boat or horse is. The cushion comes back when they do. If they never return, place a new cushion and run `euchre:rebind`.

## Development

```bash
python tools/gen.py      # regenerate generated files (commit the result)
python tools/lint.py     # static checks (namespaces, escrow choke points, references)
python tools/build.py    # gen --check + lint + zips into dist/
```

CI runs three jobs:
- lint and the generated-file check;
- the PackTest suite on a Fabric 26.3 server;
- a vanilla 26.3 smoke test that boots an unmodded server and runs `euchre:selftest`.

Design details are in [docs/architecture.md](docs/architecture.md), and the version-specific behaviours being verified are in [docs/verification.md](docs/verification.md).

## Roadmap

| | Milestone |
|---|---|
| M0 | Skeleton, tooling, CI, 26.3 verification spike |
| M1 | Table setup and removal with config, cushion seating |
| M2 | Deck, shuffle, deal into hotbars |
| M3 | Playing cards to the table, trick resolution |
| M4 | Follow-suit enforcement |
| M5 | Bidding (both rounds) and dealer discard |
| M6 | Scoring, target, game end, leaver handling. **Free tables playable here** |
| M7 | Going alone |
| M8 | Wagers: ante, escrow, payout, refunds, pending payouts, audit log |
| M9 | Resource pack card art and anti-peek models |
| M10 | Polish, docs, v1.0.0 release |

## License

MIT. See [LICENSE](LICENSE).
