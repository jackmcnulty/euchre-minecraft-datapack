# As/at the table marker when a trick is complete (euchre:tmp game is current).
scoreboard players operation #trump euchre.tmp = @s euchre.trump
function euchre:rules/trick_winner
scoreboard players operation #team euchre.tmp = #winner euchre.tmp
scoreboard players operation #team euchre.tmp %= #2 euchre.g
execute if score #team euchre.tmp matches 0 run scoreboard players add @s euchre.tricks0 1
execute if score #team euchre.tmp matches 1 run scoreboard players add @s euchre.tricks1 1
scoreboard players operation @s euchre.leader = #winner euchre.tmp
scoreboard players operation @s euchre.turn = #winner euchre.tmp

execute store result storage euchre:tmp q.seat int 1 run scoreboard players get #winner euchre.tmp
function euchre:play/seat_name with storage euchre:tmp q
tellraw @a[distance=..16] [{text:"[Euchre] ",color:"gold"},{storage:"euchre:tmp",nbt:"name",color:"white"},{text:" takes the trick.",color:"green"}]

playsound minecraft:entity.experience_orb.pickup block @a[distance=..16] ~ ~ ~ 0.6 1
execute as @e[type=minecraft:interaction,tag=euchre.spot] if score @s euchre.tid = #tid euchre.tmp if score @s euchre.seat = #winner euchre.tmp at @s run particle minecraft:happy_villager ~ ~0.3 ~ 0.2 0.1 0.2 0 8

# Leave the trick on the table for a moment before clearing it.
scoreboard players set @s euchre.phase 7
scoreboard players set @s euchre.timer 30
function euchre:table/display/update
