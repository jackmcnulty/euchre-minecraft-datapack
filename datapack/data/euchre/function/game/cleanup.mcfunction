# As/at the table marker: remove everything belonging to the current game: card
# items, cards on the table, the stored game, and seats held for absent players.
scoreboard players operation #tid euchre.tmp = @s euchre.tid
execute as @a[tag=euchre.seated] if score @s euchre.tid = #tid euchre.tmp run function euchre:gen/clear_cards
execute as @e[type=minecraft:item_display,tag=euchre.card_shown] if score @s euchre.tid = #tid euchre.tmp run kill @s
execute store result storage euchre:tmp q.tid int 1 run scoreboard players get #tid euchre.tmp
function euchre:game/clear_record with storage euchre:tmp q
function euchre:game/free_away_seats with storage euchre:tmp q
scoreboard players set @s euchre.alone -1
