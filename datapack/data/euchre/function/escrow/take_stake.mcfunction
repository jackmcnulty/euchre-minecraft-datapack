# As a seated player: take the stake (#w) and record what was taken.
scoreboard players set #take euchre.tmp 1
execute store result storage euchre:tmp tk.amount int 1 run scoreboard players get #w euchre.tmp
execute store result score #took euchre.tmp run function euchre:gen/escrow_collect with storage euchre:tmp tk
scoreboard players set #take euchre.tmp 0
execute unless score #took euchre.tmp = #w euchre.tmp run scoreboard players set #mismatch euchre.tmp 1
execute if score #took euchre.tmp matches 1.. run function euchre:escrow/record_stake
