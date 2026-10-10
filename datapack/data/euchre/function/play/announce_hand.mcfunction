# As/at the table marker: say how the hand was scored (#mteam, #mtricks, #pteam, #pts).
data modify storage euchre:tmp an set value {}
execute store result storage euchre:tmp an.m int 1 run scoreboard players get #mteam euchre.tmp
execute store result storage euchre:tmp an.p int 1 run scoreboard players get #pteam euchre.tmp
function euchre:play/announce_hand_names with storage euchre:tmp an
execute if score #mtricks euchre.tmp matches ..2 run playsound minecraft:entity.villager.no block @a[distance=..16] ~ ~ ~ 0.7 1
execute if score #mtricks euchre.tmp matches ..2 run tellraw @a[distance=..16] [{text:"[Euchre] ",color:"gold"},{storage:"euchre:tmp",nbt:"an.mname",color:"white"},{text:" got euchred! ",color:"red"},{storage:"euchre:tmp",nbt:"an.pname",color:"white"},{text:" score 2.",color:"green"}]
execute if score #mtricks euchre.tmp matches 3..4 run tellraw @a[distance=..16] [{text:"[Euchre] ",color:"gold"},{storage:"euchre:tmp",nbt:"an.mname",color:"white"},{text:" made it with ",color:"green"},{score:{name:"#mtricks",objective:"euchre.tmp"},color:"white"},{text:" tricks: 1 point.",color:"green"}]
execute if score #mtricks euchre.tmp matches 5 run tellraw @a[distance=..16] [{text:"[Euchre] ",color:"gold"},{storage:"euchre:tmp",nbt:"an.mname",color:"white"},{text:" took all five tricks: ",color:"green"},{score:{name:"#pts",objective:"euchre.tmp"},color:"white"},{text:" points!",color:"green"}]
tellraw @a[distance=..16] [{text:"[Euchre] ",color:"gold"},{text:"Score: Team A ",color:"gray"},{score:{name:"@s",objective:"euchre.pts0"},color:"white"},{text:" · Team B ",color:"gray"},{score:{name:"@s",objective:"euchre.pts1"},color:"white"}]
