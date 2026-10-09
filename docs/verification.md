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
| a | Can we read the held item's `custom_data` from player NBT? | Hold `/give @s stick[custom_data={euchre:{card:5}}]`, then try both `/data get entity @s SelectedItem` and `/data get entity @s equipment.mainhand`. | M3 | TODO. Fallback: generated 24-way `execute if items entity @s weapon.mainhand` |
| b | Does `/give` overflow drop an owner-only item at the player's feet? | Fill the inventory, run `/give @s diamond 3`, then `/data get entity @e[type=item,limit=1,sort=nearest]`. Look for `Owner` / `Thrower` and a pickup delay. Check a second player can't pick it up. | M8 | TODO |
| c | What is the maximum `/give` count? | Try `/give @s diamond 512`, then `6400`, then `6401`. | M8 (wager cap) | TODO |
| d | Does `time query gametime` still exist after the 26.1 clock rework? | Run `/time query gametime`, and `execute store result score #t euchre.tmp run time query gametime`. | M6 (deadlines) | TODO. Fallback: our own tick counter score |
| e | Can we capture a player's name as a string? | Option 1: `loot` a `player_head` with `fill_player_head` into a marker, then read `profile.name`. Option 2: `/fetchprofile entity @s`. | M1 (display only) | TODO |
| f | Do PackTest `dummy` players fire `player_interacted_with_entity`? | Write a PackTest test where `dummy @s use entity` (if it exists) targets an interaction entity, then assert the reward function ran. | Test design only | TODO |
| g | Does `leave_game` count disconnects, kicks and timeouts? | `/scoreboard objectives add t minecraft.custom:minecraft.leave_game`, then disconnect, get kicked, and kill the client, checking the score each time. | M6 / M8 (rejoin) | TODO. The backstop (pid-online check) doesn't depend on it |
| h | Is `debug_stick` inert for non-op survival players? | Survival, non-op: give a card-styled debug_stick. Try every block interaction, crafting grid, smithing table, furnace fuel slot, composter, jukebox, brewing stand, anvil, and placing. | M2 | TODO. Fallback: another candidate from the same checklist |
| i | Does sneaking get a player up from a cushion? | Place a cushion, sit, sneak. | M1 | TODO |
| j | Does `execute on vehicle` from a seated player return the cushion? | While seated: `/execute as @s on vehicle run say hi` (the output should be from "Cushion"). | M1 | TODO |
| k | Does right-clicking a cushion fire `player_interacted_with_entity`? | A temporary advancement with that trigger and `entity: {"minecraft:entity_type":"minecraft:cushion"}`, plus a reward function that runs `say`. | M1 | TODO. The vehicle backstop covers it if not |
| l | Does `ride @s dismount` work on a cushion? | While seated: `/ride @s dismount`. | M1 | TODO |
| m | Does an `Invulnerable` / adventure-mode check stop cushions being punched? (Informational; we don't rely on it.) | `/data merge entity <cushion> {Invulnerable:1b}`, then punch it in survival. | Docs | TODO |
| n | Plain-diamond predicate: is a diamond with any added component excluded? | `/clear @s minecraft:diamond[!custom_data,!custom_name,!item_name,!lore,!enchantments,!item_model,!enchantment_glint_override] 0` against plain, renamed, enchanted and `custom_data` diamonds. | M8 | TODO |
| o | Does a macro with an optional key fail when the key is missing, and does storage `merge` cover it? | `function euchre:setup_custom {wager:10,target:5}` once M1 lands. | M1 | TODO |
| p | Is `world/datapacks` still the datapack folder after the 26.1 save-layout change? | The CI vanilla smoke job checks this automatically. | CI | TODO |
