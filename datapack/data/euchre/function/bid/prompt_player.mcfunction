# As the bidder.
scoreboard players set @s euchre.act 0
scoreboard players enable @s euchre.act
playsound minecraft:block.note_block.pling player @s ~ ~ ~ 0.5 1.5
execute if score #phase euchre.tmp matches 3 run function euchre:gen/bid_prompt1
execute if score #phase euchre.tmp matches 5 run function euchre:gen/bid_prompt2
