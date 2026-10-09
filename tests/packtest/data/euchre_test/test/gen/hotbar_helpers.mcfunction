# @dummy
# Generated hotbar helpers report empty slots correctly on a real player.
execute store result score #n euchre.tmp run function euchre:gen/count_empty_hotbar_slots
assert score #n euchre.tmp matches 9
execute store result score #n euchre.tmp run function euchre:gen/first_empty_hotbar_slot
assert score #n euchre.tmp matches 0

item replace entity @s hotbar.0 with minecraft:stone
item replace entity @s hotbar.2 with minecraft:stone
execute store result score #n euchre.tmp run function euchre:gen/count_empty_hotbar_slots
assert score #n euchre.tmp matches 7
execute store result score #n euchre.tmp run function euchre:gen/first_empty_hotbar_slot
assert score #n euchre.tmp matches 1
