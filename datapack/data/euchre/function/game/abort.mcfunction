# As/at a table marker: stop the current game and clean up. No points, no payout.
# (When leaver handling lands, a player leaving pauses the game instead.)
scoreboard players operation #tid euchre.tmp = @s euchre.tid
execute as @a[tag=euchre.seated] if score @s euchre.tid = #tid euchre.tmp run function euchre:gen/clear_cards
execute as @e[type=minecraft:item_display,tag=euchre.card_shown] if score @s euchre.tid = #tid euchre.tmp run kill @s
execute store result storage euchre:tmp q.tid int 1 run scoreboard players get #tid euchre.tmp
function euchre:game/clear_record with storage euchre:tmp q
scoreboard players set @s euchre.phase 0
scoreboard players set @s euchre.alone -1
scoreboard players set @s euchre.timer -1
tellraw @a[distance=..16] [{text:"[Euchre] ",color:"gold"},{text:"The game was stopped because a player left.",color:"yellow"}]
