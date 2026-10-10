# Per-tick work while any table has someone seated.
# A shared tick counter lets slower checks run every N ticks.
scoreboard players add #t euchre.g 1
scoreboard players operation #t10 euchre.g = #t euchre.g
scoreboard players operation #t10 euchre.g %= #10 euchre.g
scoreboard players operation #t20 euchre.g = #t euchre.g
scoreboard players operation #t20 euchre.g %= #20 euchre.g

execute as @e[type=minecraft:marker,tag=euchre.table,scores={euchre.seated=1..}] at @s run function euchre:table/tick

# Bidding buttons (/trigger euchre.act). Only the current bidder has it enabled.
execute as @a[scores={euchre.act=1..}] at @s run function euchre:bid/on_trigger

# Once a second: remove card items that ended up anywhere but a seated player's inventory.
execute if score #t20 euchre.g matches 0 run function euchre:gen/sweep_cards
