# As a seated player: flag #short if they can't cover the stake right now.
scoreboard players set #take euchre.tmp 0
execute store result score #have euchre.tmp run function euchre:gen/escrow_collect {amount:0}
execute if score #have euchre.tmp >= #w euchre.tmp run return 0
scoreboard players set #short euchre.tmp 1
tellraw @s [{text:"[Euchre] ",color:"gold"},{text:"You need ",color:"red"},{score:{name:"#w",objective:"euchre.tmp"},color:"white"},{text:" plain diamonds in your inventory to play at this table (renamed or modified diamonds don't count).",color:"red"}]
