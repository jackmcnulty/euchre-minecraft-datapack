# As a seated player: play card $(card) from their hand. Returns 1 if played,
# fails with a message otherwise. This is the internal API behind clicking a
# spot; tests call it directly.
$scoreboard players set #card euchre.tmp $(card)
scoreboard players operation #tid euchre.tmp = @s euchre.tid
scoreboard players operation #seat euchre.tmp = @s euchre.seat
execute unless entity @s[tag=euchre.seated] run return run function euchre:util/fail {msg:"Sit at the table to play."}

# Table state.
scoreboard players set #phase euchre.tmp -1
execute as @e[type=minecraft:marker,tag=euchre.table] if score @s euchre.tid = #tid euchre.tmp run function euchre:play/read_table
execute unless score #phase euchre.tmp matches 6 run return run function euchre:util/fail {msg:"You can't play a card right now."}
execute unless score #turn euchre.tmp = #seat euchre.tmp run return run function euchre:util/fail {msg:"It's not your turn."}

# Storage is the source of truth: the card must be in this player's hand.
execute store result storage euchre:tmp q.tid int 1 run scoreboard players get #tid euchre.tmp
function euchre:game/load with storage euchre:tmp q
execute store result storage euchre:tmp q.seat int 1 run scoreboard players get #seat euchre.tmp
function euchre:card/load_hand with storage euchre:tmp q
function euchre:rules/hand_index
execute if score #idx euchre.tmp matches -1 run return run function euchre:util/fail {msg:"That card isn't in your hand."}

function euchre:play/commit
return 1
