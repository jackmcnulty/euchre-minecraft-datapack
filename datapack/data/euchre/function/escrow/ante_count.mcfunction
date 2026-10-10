scoreboard players set #confirmed euchre.tmp 0
$execute store result score #c euchre.tmp run data get storage euchre:tables list[{id:$(tid)}].ante[0]
scoreboard players operation #confirmed euchre.tmp += #c euchre.tmp
$execute store result score #c euchre.tmp run data get storage euchre:tables list[{id:$(tid)}].ante[1]
scoreboard players operation #confirmed euchre.tmp += #c euchre.tmp
$execute store result score #c euchre.tmp run data get storage euchre:tables list[{id:$(tid)}].ante[2]
scoreboard players operation #confirmed euchre.tmp += #c euchre.tmp
$execute store result score #c euchre.tmp run data get storage euchre:tables list[{id:$(tid)}].ante[3]
scoreboard players operation #confirmed euchre.tmp += #c euchre.tmp
