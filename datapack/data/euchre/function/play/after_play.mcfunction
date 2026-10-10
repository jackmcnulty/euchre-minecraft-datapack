# As/at the table marker after card #card was played by seat #seat.
# The first card of a trick sets the led suit (its effective suit).
execute store result score #n euchre.tmp run data get storage euchre:tmp game.trick
execute if score #n euchre.tmp matches 1 run function euchre:rules/eff_suit
execute if score #n euchre.tmp matches 1 run scoreboard players operation @s euchre.led = #eff euchre.tmp

# Show the card face up on the player's spot.
data modify storage euchre:tmp gc set value {}
execute store result storage euchre:tmp gc.id int 1 run scoreboard players get #card euchre.tmp
execute store result storage euchre:tmp gc.tid int 1 run scoreboard players get #tid euchre.tmp
data modify storage euchre:tmp gc.nonce set from storage euchre:tmp game.nonce
function euchre:card/lookup with storage euchre:tmp gc
execute as @e[type=minecraft:interaction,tag=euchre.spot] if score @s euchre.tid = #tid euchre.tmp if score @s euchre.seat = #seat euchre.tmp at @s positioned ~ ~0.02 ~ summon minecraft:item_display run function euchre:card/init_shown
execute as @e[type=minecraft:item_display,tag=euchre.card_new] run function euchre:gen/card_to_contents with storage euchre:tmp gc
tag @e[type=minecraft:item_display,tag=euchre.card_new] add euchre.trick_card
tag @e[type=minecraft:item_display,tag=euchre.card_new] remove euchre.card_new
playsound minecraft:item.book.page_turn block @a[distance=..16] ~ ~ ~ 0.8 1.2
tellraw @a[distance=..16] [{text:"[Euchre] ",color:"gold"},{storage:"euchre:tmp",nbt:"name",color:"white"},{text:" played ",color:"gray"},{storage:"euchre:tmp",nbt:"gc.name",color:"white"}]

# 4 cards complete a trick (3 when someone sits out a lone hand).
scoreboard players set #need euchre.tmp 4
execute if score @s euchre.alone matches 0.. run scoreboard players set #need euchre.tmp 3
execute if score #n euchre.tmp >= #need euchre.tmp run return run function euchre:play/resolve_trick
function euchre:play/next_turn
function euchre:table/display/update
function euchre:play/prompt
