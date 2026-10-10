# Testing

## Automated (CI)

`.github/workflows/ci.yml` runs on every push and pull request:

| Job | What it does |
|---|---|
| **Lint & generated files** | `tools/gen.py --check` (generated files are up to date), `tools/lint.py`, and `tools/build.py` (release zips, uploaded as an artifact). |
| **Test suite (PackTest)** | A Fabric 26.3 server with [PackTest](https://github.com/misode/packtest) and Fabric API (versions pinned and hash-checked) runs every test in `tests/packtest/`. The exit code is the number of failed tests; failures are annotated on the PR. |
| **Vanilla load smoke test** | An **unmodded** 26.3 server loads the datapack (and the `spike/` pack) and must run `euchre:selftest` without a single load error. This proves the shipped pack works on vanilla, not only under Fabric. |

### Test suites

| Folder | What it covers |
|---|---|
| `test/golden/` | **Generated** from the reference model in `tools/gen.py`: effective suit (all 24 cards × 4 trumps), power (× 4 led suits), 150 follow-suit decisions, 60 random tricks, every scoring case, and every hand-decided case. |
| `test/rules/` | Hand-written left-bower follow-suit edge cases. |
| `test/deck/` | Shuffling produces a permutation, differs between runs, and rigged decks split predictably. |
| `test/table/` | Setup validation, seating via real cushion clicks, dealing and hand reconciliation, a full scripted hand (with a real spot click and a real chat-button press), bidding (stick the dealer, redeal), going alone, game over, leavers (return, forfeit, both teams). |
| `test/wager/` | A full wagered game and payout, atomic collection with a short player, refunds on removal, and refunds to offline players delivered on return. All check exact diamond counts, ledger changes and the conservation invariant. |

### Conventions

- **Fake players** (`dummy <name> spawn`) act like real ones. They right-click
  cushions and spots (`dummy … use entity`) and run `/trigger`. Their names are
  prefixed per test, so tests never share players.
- **Tables are global state** (one per world), so table and wager tests take
  turns via `euchre_test:lock`. A test that fails while holding the lock makes
  later lock users time out: fix the first failure first.
- **The table fixture** (`build_table` + `place_cushions`) force-loads its area
  and waits until it's loaded. Summoned cushions only last about 100 ticks (see
  verification.md), so table tests skip waits (`euchre.timer 1`) and finish
  their seated part quickly.
- **Test hooks:** `euchre:debug rig` sets the next deck order and
  `euchre:debug dealer` sets the first dealer. Each is used once.
- Refusals record their reason in `euchre:tmp last_error`, so a failing test
  can say *why*.

### Running locally

You need Java 25 and Python 3.10+.

```bash
python tools/gen.py --check && python tools/lint.py && python tools/build.py
```

Then mirror the CI job:
1. Download the Fabric 26.3 server launcher, PackTest and Fabric API (URLs and
   hashes are at the top of `ci.yml`).
2. Copy `datapack/` and `tests/packtest/` into `world/datapacks/`.
3. Run `java -Dpacktest.auto -jar fabric-server.jar nogui`.

## Singleplayer validation

Everything that can be checked alone, step by step: [singleplayer-validation.md](singleplayer-validation.md).

## Manual QA checklist

These need real clients, so they aren't automated. Run through them before a
release.

- [ ] **Anti-peek:** a held card shows its face in your hotbar and first-person view, and the back in third person (F5), when dropped and in an item frame.
- [ ] Played cards and the up card lie flat and face up on the table.
- [ ] Board and seat labels are readable from each seat, and the `▶` turn marker moves.
- [ ] Sounds play for: a card played, a trick won, your turn (to you only), the deal, a game won.
- [ ] Chat buttons work and are only clickable for the current bidder.
- [ ] Sneak to stand mid-game → paused, and sitting back down resumes it with your cards.
- [ ] Disconnect mid-game and rejoin → you're back on your cushion and the game resumes.
- [ ] **Wagered game** with real diamonds: the stake is taken only after all four confirm, the winners each receive 2× the stake, and `admin/inspect` shows a balanced ledger.
- [ ] Payout with a **full inventory:** the overflow drops at your feet, only you can pick it up, and it doesn't despawn.
- [ ] Without the resource pack, cards still show their names.
