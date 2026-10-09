# Euchre for Minecraft

A fully rules-enforcing game of **Euchre** for Minecraft Java Edition **26.3**. It's played at a table you build yourself in a survival world, as a vanilla **datapack** with a companion resource pack for the card art. You can play for free or stake diamonds held in auditable escrow.

> **Status: early development (milestone M0: skeleton, tooling, CI).** It isn't playable yet. See the [roadmap](#roadmap).

<!-- TODO(M10): demo GIF -->

## Why this exists

Other projects bring cards into Minecraft, such as card-only packs and a physical blackjack table. None of them enforce a trick-taking game's rules. This datapack enforces all of Euchre's: bowers, effective suit, following suit, bidding, going alone, and scoring.

## Install

1. Download `euchre-datapack-<version>.zip` and `euchre-resourcepack-<version>.zip` from Releases.
2. Put the datapack zip in `<world>/datapacks/` and run `/reload`.
3. Serve the resource pack. On a server, use `resource-pack` in `server.properties`. In single player, put it in `resourcepacks/`.

## Setting up a table *(planned, M1)*

1. Build a table from any blocks, and place **4 cushions** around it, one on each side.
2. Stand in the centre of the tabletop and run one of:

```mcfunction
/function euchre:setup                               # free play, first to 5
/function euchre:setup_custom {wager:0,target:10}    # free play, first to 10
/function euchre:setup_custom {wager:10,target:5}    # each player stakes 10 diamonds
```

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
