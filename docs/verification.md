# 26.3 verification log (M0 spike)

The design rests on a few Minecraft 26.3 behaviours that the wiki and changelogs
don't settle. Each one is checked in a real 26.3 world, ideally a throwaway
single-player world with cheats on and the datapack installed. The result is
recorded here before any milestone that depends on it starts.

How to fill this in: run the commands, then replace `TODO` with **✅ confirmed**,
**❌ differs**, or **⚠ partial**, plus a short note. When something differs,
also note what the design falls back to.

| # | Question | How to check | Blocks | Result |
|---|---|---|---|---|
| a | Can we read the held item's `custom_data` from player NBT? | Hold `/give @s stick[custom_data={euchre:{card:5}}]`, then try both `/data get entity @s SelectedItem` and `/data get entity @s equipment.mainhand`. | M3 | ✅ `SelectedItem.components."minecraft:custom_data".euchre.card` → 5. `equipment.mainhand` isn't a player path (→ 0). |
| b | Does `/give` overflow drop an owner-only item at the player's feet? | Fill the inventory, run `/give @s diamond 3`, then `/data get entity @e[type=item,limit=1,sort=nearest]`. Look for `Owner` / `Thrower` and a pickup delay. Check a second player can't pick it up. | M8 | ✅ Overflow drops at the player's feet with `Owner` = the player's UUID (owner-only pickup), `PickupDelay:0s`, and no `Thrower`. `Age:-32768s` can be merged in. (Second-player pickup wasn't tested in singleplayer; vanilla only lets the `Owner` pick it up.) |
| c | What is the maximum `/give` count? | Try `/give @s diamond 512`, then `6400`, then `6401`. | M8 (wager cap) | ✅ The maximum is **6400**. `/give … 6401` → "Can't give more than 6400 of [Diamond]". The wager cap of 256 (payout 512) is well within it. |
| d | Does `time query gametime` still exist after the 26.1 clock rework? | Run `/time query gametime`, and `execute store result score #t euchre.tmp run time query gametime`. | M6 (deadlines) | ✅ Works (15787 → 15908) |
| e | Can we capture a player's name as a string? | Option 1: `loot` a `player_head` with `fill_player_head` into a marker, then read `profile.name`. Option 2: `/fetchprofile entity @s`. | M1 (display only) | ✅ Both work. A loot `player_head` with `fill_player_head` (26.3 `modifier` format) gives `components."minecraft:profile".name`; copy only `.name`, because the profile includes a large signature. `/fetchprofile` also prints the name. Use loot (no network). |
| f | Do PackTest `dummy` players fire `player_interacted_with_entity`? | Write a PackTest test where `dummy @s use entity` (if it exists) targets an interaction entity, then assert the reward function ran. | Test design only | TODO (but PackTest `@dummy` tests work on 26.3: a dummy joins and the test passes) |
| g | Does `leave_game` count disconnects, kicks and timeouts? | `/scoreboard objectives add t minecraft.custom:minecraft.leave_game`, then disconnect, get kicked, and kill the client, checking the score each time. | M6 / M8 (rejoin) | ✅ Goes up by 1 on Save & Quit and on Alt+F4. Kicks and timeouts weren't tested (singleplayer); the online-check backstop covers them. |
| h | Is `debug_stick` inert for non-op survival players? | Survival, non-op: give a card-styled debug_stick. Try every block interaction, crafting grid, smithing table, furnace fuel slot, composter, jukebox, brewing stand, anvil, and placing. | M2 | ✅ Inert in survival: no block interactions, not placeable, no crafting, fuel, composter, jukebox, brewing or smithing use. Only an anvil rename works, which is harmless because `custom_data` survives it. |
| i | Does sneaking get a player up from a cushion? | Place a cushion, sit, sneak. | M1 | ✅ Sneak gets the player up |
| j | Does `execute on vehicle` from a seated player return the cushion? | While seated: `/execute as @s on vehicle run say hi` (the output should be from "Cushion"). | M1 | ✅ `execute on vehicle` returns the cushion |
| k | Does right-clicking a cushion fire `player_interacted_with_entity`? | A temporary advancement with that trigger and `entity: {"minecraft:entity_type":"minecraft:cushion"}`, plus a reward function that runs `say`. | M1 | ✅ Fires, using the typed `entity_properties` condition form (see Findings) |
| l | Does `ride @s dismount` work on a cushion? | While seated: `/ride @s dismount`. | M1 | ✅ `ride @s dismount` stands the player up |
| m | Does an `Invulnerable` / adventure-mode check stop cushions being punched? (Informational; we don't rely on it.) | `/data merge entity <cushion> {Invulnerable:1b}`, then punch it in survival. | Docs | ✅ An `Invulnerable:1b` cushion survives a survival punch, and a normal one breaks and drops. We still don't summon cushions. |
| n | Plain-diamond predicate: is a diamond with any added component excluded? | `/clear @s minecraft:diamond[!custom_data,!custom_name,!item_name,!lore,!enchantments,!item_model,!enchantment_glint_override] 0` against plain, renamed, enchanted and `custom_data` diamonds. | M8 | ❌ The first predicate matched **0** plain diamonds: `!item_model` (and likely `!item_name`, `!lore` and `!enchantments`) fail because every item has those as *default* components. Round 2: `/function euchre_spike:count_candidates` |
| o | Does a macro with an optional key fail when the key is missing, and does storage `merge` cover it? | `function euchre:setup_custom {wager:10,target:5}` once M1 lands. | M1 | TODO |
| p | Is `world/datapacks` still the datapack folder after the 26.1 save-layout change? | The CI vanilla smoke job checks this automatically. | CI | ✅ confirmed (CI run 1): the server log shows `Found new data pack file/euchre, loading it automatically` |

## Findings from CI

- **Advancement `entity` conditions need the 26.3 typed form.** A bare entity predicate such as
  `"entity": {"minecraft:entity_type": "minecraft:cushion"}` fails with `No key type in MapLike[...]`.
  Advancements are registry-loaded now, so this error **blocks the whole world from loading**, not only that file.
  The working form wraps it as a loot condition:
  `"entity": {"type": "minecraft:entity_properties", "entity": "this", "predicate": {"minecraft:entity_type": "minecraft:cushion"}}`.
- **An NBT path can't follow a list index with a compound filter.** `table[17]{suit:2}` is invalid; use `table[{id:17,suit:2}]`.
- The CI vanilla smoke job loads `spike/` too, so a spike that would break world creation is caught before anyone copies it.
