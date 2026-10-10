# Singleplayer validation

A full game needs four players, so dealing, bidding, trick play, scoring,
leavers and real wagers can't be tested alone; those are covered by the
automated tests and the multiplayer checklist in [testing.md](testing.md).
Everything below **can** be checked in single player. Each step says exactly
what to do and what you should see. Tick the boxes as you go.

Note: in single player with cheats on, you're an operator, so admin commands work.

---

## 0. Set up a test world

1. Get the two zips: either build them from the repo (`python tools/build.py --version local`
   → `dist/euchre-datapack-local.zip` and `dist/euchre-resourcepack-local.zip`), or
   download the latest release's zips. Below they're called *the datapack zip* and
   *the resource pack zip*.
2. Put the resource pack zip in `%APPDATA%\.minecraft\resourcepacks\`.
   In the game: **Options → Resource Packs**, move *Euchre — card art* to the
   right (Selected) side, then click Done.
3. **Singleplayer → Create New World**:
   - Name: `euchre-test`
   - Game Mode **Creative**, Allow Commands **ON**
   - More → World Type **Superflat**
   - **Data Packs → Open Pack Folder**: copy the datapack zip in (don't
     unzip it), move it to **Selected**, then click Done.
   - Create.
4. Optional: `/gamerule doDaylightCycle false` and `/time set day`.

## 1. Installation and health

- [ ] **1.1** Run `/datapack list enabled`. The list includes `file/euchre-datapack-<version>.zip`.
- [ ] **1.2** Run `/execute if function euchre:selftest run say SELFTEST OK`. Chat shows `[<you>] SELFTEST OK`.
- [ ] **1.3** Run `/scoreboard objectives list`. The list has many `euchre.*` objectives (`euchre.g`, `euchre.phase`, `euchre.act`, …).
- [ ] **1.4** Run `/reload`, then repeat 1.2. It still says SELFTEST OK, and there are no red errors. (Reloading must never reset anything.)
- [ ] **1.5** Run `/trigger euchre.act set 30`. You get an error that you can't trigger this objective yet, because triggers are only enabled for the current bidder.

## 2. Card art and anti-peek

- [ ] **2.1** Run `/give @s minecraft:debug_stick[item_model="euchre:card_23",custom_name={text:"A♥",italic:false}]` and select it. Your hotbar and hand show the **ace of hearts face**.
- [ ] **2.2** Repeat with `card_14` (J♦), `card_0` (9♣) and `card_10` (K♠). Each shows the right card, with red suits red and black suits dark.
- [ ] **2.3** Hold a card and press **F5** twice (third person, front). Your hand shows the **blue back**.
- [ ] **2.4** Press **Q** to drop one. On the ground it shows the **back**.
- [ ] **2.5** Place an item frame and put a card in it. It shows the **back**, and looking at it shows **no name**. (Real cards are named with `item_name`, which item frames don't display. A test card from step 2.1 uses `custom_name`, so it does show its name; that's expected.)
- [ ] **2.6** Run `/summon minecraft:item_display ~ ~1 ~ {item:{id:"minecraft:debug_stick",count:1,components:{"minecraft:item_model":"euchre:card_face_23"}}}`. It shows the **face**. In your hand the two models look the same; they differ only where others look. `card_23` (held cards) shows the back in third person, on the ground and in frames, while `card_face_23` (cards on the table) always shows the face. Try the same command with `card_23`: it shows the **back**.
- [ ] **2.7** Disable the resource pack (Options → Resource Packs), look at a card, then re-enable it. Without the pack, the card looks like a missing texture but its name still shows when you hover over it.
- [ ] **2.8** Clean up: `/kill @e[type=minecraft:item_display]` (floating cards from 2.6), `/kill @e[type=minecraft:item_frame]` (the frame from 2.5), `/kill @e[type=minecraft:item]` (anything still on the ground; *"No entity was found"* is fine) and `/clear @s`.

## 3. Building a table, and setup validation

Build at least 10 blocks from where you spawned.

- [ ] **3.1** Build a 1×1 table: place one block, e.g. oak planks.
- [ ] **3.2** **Validation, no cushions yet.** Stand on top of the table block and run `/function euchre:setup`. You get a red message: *"Setup needs exactly 4 cushions within 3 blocks of you…"*, a small N/E/S/W diagram, and *"Found (seat 0=N 1=E 2=S 3=W): []"*.
- [ ] **3.3** Get cushions with `/give @s minecraft:white_cushion 8`. Place **3** cushions on the ground, one against each of the north, east and south faces of the table. Run setup again: same refusal, now listing 3 cushions found.
- [ ] **3.4** Place the 4th cushion on the west side. Before setting up, check the config validation (each should be refused with this message, and no table created):
  - `/function euchre:setup_custom {wager:-1,target:5}` → *"Wager must be 0 (free play) to 256 diamonds."*
  - `/function euchre:setup_custom {wager:300,target:5}` → the same wager message
  - `/function euchre:setup_custom {wager:0,target:0}` → *"Target must be 1 to 25 points."*
  - `/function euchre:setup_advanced {wager:0,target:5,stick_dealer:2,grace_s:120}` → *"stick_dealer must be 0 or 1."*
  - `/function euchre:setup_advanced {wager:0,target:5,stick_dealer:1,grace_s:5}` → *"grace_s must be 30 to 600 seconds."*
  - `/function euchre:setup_custom {wager:10}` → a red command error about the missing `target`
  - `/function euchre:setup_custom {wager:"ten",target:5}` → a red error about an invalid integer
- [ ] **3.5** **Create the table.** Stand on the centre of the tabletop and run `/function euchre:setup`. Chat: *"Table #1 is ready. Right-click a cushion to sit."*
- [ ] **3.6** **Board** above the table reads:
  - `♠ ♥  EUCHRE  ♣ ♦` (gold)
  - `Table #1`
  - `Free play · first to 5`
  - `Players 0/4 · Waiting for players`
- [ ] **3.7** **Seat labels:** four small labels on the tabletop: `North · Team A`, `East · Team B`, `South · Team A`, `West · Team B`, each over `(empty)`. **North must be the label nearest the north cushion** (press F3: north is the direction that shows "Facing: north").
- [ ] **3.8** **Duplicate setup:** run `/function euchre:setup` again. *"A Euchre table already exists. Remove it with euchre:remove_table first."*
- [ ] **3.9** **Card spots:** run `/execute as @e[type=minecraft:interaction,tag=euchre.spot] run say spot`. Four "spot" lines appear.

## 4. Seating

- [ ] **4.1** Right-click the **north** cushion. You sit down, chat says *"<you> sat down."*, the North label shows your name in white, and the board shows `Players 1/4 · Waiting for players`.
- [ ] **4.2** **Sneak** (Shift). You stand up, chat says *"<you> left the table."*, the label is back to `(empty)` and the board shows `Players 0/4`.
- [ ] **4.3** **Hopping seats:** sit on north, then (still seated) right-click the **east** cushion. You end up on east. The North label is `(empty)`, the East label has your name, and the board still says 1/4 (not 2/4).
- [ ] **4.4** **Hotbar rule:** stand up. Fill 5+ hotbar slots, e.g. `/give @s minecraft:stone 64` repeated, or any items, leaving 4 or fewer slots empty. Right-click a cushion. You're immediately stood up with *"You need 5 empty hotbar slots to play…"*. **Check your items are all still there and unmoved.**
- [ ] **4.5** Empty the hotbar (`/clear @s`) and sit down again (north). You're seated.

## 5. Card clean-up while seated

- [ ] **5.1** While seated, run `/give @s minecraft:debug_stick[custom_data={euchre:{card:5,tid:1,nonce:999}},item_model="euchre:card_5"]`. You get a card item (the ace of clubs).
- [ ] **5.2** Select it and press **Q** to drop it. The item on the floor **disappears within about 1 second**: card items aren't allowed outside a seated player's inventory.
- [ ] **5.3** (Expected behaviour, not a bug: a stray card *in your own inventory* while seated with no game running isn't removed. Hands are only checked during a game.) Clear it: `/clear @s minecraft:debug_stick`.

## 6. Reload, quit and rejoin while seated

- [ ] **6.1** While seated, run `/reload`. You stay seated, with no errors, and the board still says `Players 1/4`.
- [ ] **6.2** While seated, **Save and Quit to Title**, then reopen the world. You're back on the cushion and seated. The label shows your name, and **the board says `Players 1/4`, not 2/4**. This checks a fix made after v0.9.0, so v0.9.0's zip shows 2/4.
- [ ] **6.3** Sneak to stand. The board says `Players 0/4`.
- [ ] **6.4** Sit again, then close the game with **Alt+F4** (simulating a crash), relaunch and reopen the world. Same result as 6.2: seated, `Players 1/4`.

## 7. Cushions are yours

- [ ] **7.1** Stand up. Run `/data get entity @n[type=minecraft:cushion] Tags`. It shows `["euchre.seat"]` (tagged, not owned).
- [ ] **7.2** Run `/gamemode survival`, then punch the **east** cushion. It breaks and drops a cushion item (vanilla). Run `/gamemode creative`.
- [ ] **7.3** Place a new cushion on the east side. Stand on the tabletop and run `/function euchre:rebind`. Chat: *"Cushions adopted: 1. Seats still missing a cushion: 0"*.
- [ ] **7.4** Sit on the new east cushion. It works.
- [ ] **7.5** Optional, but it helps the project: **this answers the one open question in
  [verification.md](verification.md).** Stand next to a cushion you placed by
  hand and run `/data get entity @n[type=minecraft:cushion]`, then copy the
  whole output into chat for me. Summoned cushions break after 5 seconds and
  placed ones don't; this shows why.

## 8. Wager table (solo checks)

- [ ] **8.1** Stand on the tabletop and run `/function euchre:remove_table`. Chat: *"Table removed."* All four labels and the board disappear, **the cushions stay**, and `/data get entity @n[type=minecraft:cushion] Tags` no longer lists `euchre.seat` (or errors with "no elements"). Your inventory is untouched.
- [ ] **8.2** Run `/give @s minecraft:diamond 20`. Stand on the tabletop and run `/function euchre:setup_custom {wager:10,target:5}`. The board's third line reads `Stake: 10 diamonds each · first to 5`.
- [ ] **8.3** Sit down. **Nothing is taken**: run `/clear @s minecraft:diamond 0` and you still have 20. (Stakes are only requested once four players sit.)
- [ ] **8.4** Run `/function euchre:admin/inspect`:
  - Line 1: `Ledger: collected 0 = delivered 0 + held 0 + owed 0 · frozen: 0`.
  - Then: `Table #2 config: {wager:10, target:5, …}`, the seats (your name in seat 0) and `Escrow: {entries:[]}`.
- [ ] **8.5** Run `/function euchre:admin/pending_list`. Shows `Pending payouts: []`.
- [ ] **8.6** Run `/function euchre:admin/release_pending`. Shows *"Nothing is pending."*
- [ ] **8.7** Run `/function euchre:admin/notify_on`. Shows *"You'll see escrow audit messages…"*. Then run `/function euchre:admin/unfreeze`. Shows *"Wagered games are enabled again."*, plus a teal `[Euchre audit] unfreeze 0 diamonds, <you>` line, because you're now subscribed.
- [ ] **8.8** Run `/function euchre:admin/audit_log`. It shows the unfreeze entry with your name and a game time `t`.
- [ ] **8.9** Run `/function euchre:admin/notify_off`.
- [ ] **8.10** Run `/function euchre:abort` near the table. Shows *"An operator cancelled the game. Any stakes were refunded."* Nothing was staked, so your diamonds are still 20. You remain seated.

## 9. A table far from spawn

This checks the score-overflow fix.

- [ ] **9.1** Remove the current table: `/function euchre:remove_table`.
- [ ] **9.2** Run `/tp @s 25000000 -60 25000000`. On superflat this is ground level; adjust y if needed. Build a 1×1 table with 4 cushions around it, as in step 3.
- [ ] **9.3** Stand on the tabletop and run `/function euchre:setup`. You get *"Table #… is ready"*, and North is the north cushion (check the labels as in 3.7).
- [ ] **9.4** Sit on each cushion in turn. Each one seats you in the matching direction.
- [ ] **9.5** `/function euchre:remove_table`, then `/tp @s 0 -60 0`.

## 10. Uninstall

- [ ] **10.1** Build or keep any table (or none) and sit on it. Run `/function euchre:uninstall`. Chat: *"Uninstalled. Now run /datapack disable…"*. You're stood up, the displays are gone, and the cushions remain.
- [ ] **10.2** Run `/scoreboard objectives list`. There are no `euchre.*` objectives left.
- [ ] **10.3** Run `/datapack disable "file/euchre-datapack-<version>.zip"` (the exact name is in `/datapack list`). Then `/datapack list enabled` no longer shows it.
- [ ] **10.4** Optional: reinstall with `/datapack enable "file/euchre-datapack-<version>.zip"`, then repeat 1.2. SELFTEST OK.

---

## Can't be done alone (need 4 players)

These are covered by the automated tests. Run them for real with friends, using the multiplayer checklist in [testing.md](testing.md):

- shuffling, dealing, the up card, and the dealer's 6th slot
- bidding buttons (both rounds), stick the dealer, redeal, going alone
- playing cards to the table, follow-suit refusals, trick winners, scoring, game over
- the turn marker `▶`, sounds and particles
- leaving mid-game (pause, resume, forfeit, cancel)
- real wagers: ante, collection, payout, refunds, pending payouts, full-inventory drop

## Reporting back

For anything that doesn't match, note the step number, what you saw (a
screenshot helps), and any red error text exactly.
