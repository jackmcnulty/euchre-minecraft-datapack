# Wagers and escrow: a guide for server admins

This is the only part of the datapack that handles players' real items. It's
built to be conservative and auditable: **diamonds paid out or refunded always
add up to diamonds collected**. No code path can create diamonds beyond what
was staked.

## How a wagered game works

1. **Setup.** `/function euchre:setup_custom {wager:10,target:5}` creates a
   table where each player stakes 10 diamonds.
2. **Ante.** When four players are seated, each gets clickable *Stake my
   diamonds* and *Leave the table* buttons in chat. Nothing is taken yet.
3. **Atomic collection.** When the last player confirms, the datapack first
   checks that **all four** carry at least the stake. If anyone is short,
   **nothing is taken from anyone**, everyone is told, and the table waits for
   fresh confirmations. Otherwise it takes exactly the stake from each player.
4. **Escrow.** The stakes are recorded with the table: who paid and how much.
   The board shows the pot.
5. **Payout.** The winning team's two players split the recorded pot (with 10
   each: 20 each, their own stake back plus one opponent's). Going alone
   doesn't change the payout.

### Only "plain" diamonds count

A diamond counts only if it's unmodified: renamed, enchanted-looking, tagged or
lore-carrying diamonds are never counted or taken. A player's special diamonds
are safe.

### Refunds

Every stake is refunded to the player who paid it when:

- the table is removed (`euchre:remove_table`) or the datapack is uninstalled;
- an operator cancels the game (`/function euchre:abort` near the table);
- players from both teams leave mid-game and don't return within the grace
  period (default 120 s; also covers a server restart where not everyone
  returns).

If only one team has a player who leaves and doesn't return in time, that team
**forfeits** and the other team is paid as winners.

### Players who are offline

Diamonds owed to someone who's offline (a refund, or winnings after a forfeit)
become a **pending payout**, keyed by their UUID. They're delivered
automatically the next time that player is online, with a chat message
explaining what they received.

### Full inventories

Winnings or refunds that don't fit drop at the player's feet as an item **only
they can pick up**, and the drop is marked so it never despawns.

## Safety mechanisms

- **Two choke points.** Exactly one function in the pack can remove diamonds
  from a player (`gen/escrow_collect`) and exactly one can give them
  (`gen/escrow_give`). Both are generated from a single definition of "plain
  diamond", and CI fails if diamonds appear anywhere else.
- **Ledger.** Global counters track diamonds `collected`, `delivered`, `held`
  in escrow and `owed` as pending payouts. After every change the datapack
  checks that `collected = delivered + held + owed`, and that `held` and `owed`
  match what's actually recorded in storage.
- **Freeze on mismatch.** If that check ever fails, new wagered games are
  refused (refunds and payouts still work) and operators who opted in are
  alerted. Review with the tools below, then `euchre:admin/unfreeze`.
- **Audit log.** The last 256 escrow events (collect, winnings, refund, owed,
  deliver, released_to_operator, unfreeze, invariant_fail) with game time,
  player name, UUID and amount are kept in storage `euchre:audit`.

## Operator commands

| Command | What it does |
|---|---|
| `/function euchre:abort` | Cancel the game at the nearest table and refund every stake. |
| `/function euchre:admin/inspect` | The ledger, plus the nearest table's config, seats and escrow. |
| `/function euchre:admin/pending_list` | Diamonds owed to offline players. |
| `/function euchre:admin/audit_log` | The audit log. |
| `/function euchre:admin/notify_on` / `notify_off` | Get escrow events in chat as they happen. |
| `/function euchre:admin/unfreeze` | Re-enable wagered games after reviewing a mismatch (logged). |
| `/function euchre:admin/release_pending` | Hand every pending payout to *you* to deliver by hand, e.g. before uninstalling when players won't return (logged per recipient). |

## Uninstalling

`/function euchre:uninstall` removes every table first, refunding all stakes
(to pending payouts for anyone offline). It then **refuses to finish** while
any diamonds are still owed: wait for those players, or use
`euchre:admin/release_pending` and hand the diamonds out yourself.
