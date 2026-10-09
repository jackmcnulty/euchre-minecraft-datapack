# Re-adopt cushions for the nearest table (within 8 blocks), for seats whose
# cushion was broken. Place the replacement on the same side and run this.
execute unless entity @e[type=minecraft:marker,tag=euchre.table,distance=..8] run return run function euchre:util/fail {msg:"No Euchre table within 8 blocks."}
execute as @e[type=minecraft:marker,tag=euchre.table,distance=..8,sort=nearest,limit=1] at @s run function euchre:table/rebind
tellraw @s [{text:"[Euchre] ",color:"gold"},{text:"Cushions adopted: ",color:"green"},{score:{name:"#adopted",objective:"euchre.tmp"},color:"white"},{text:". Seats still missing a cushion: ",color:"green"},{score:{name:"#missing",objective:"euchre.tmp"},color:"white"}]
return 1
