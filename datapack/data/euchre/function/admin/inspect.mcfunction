# Operator: show the nearest table's config, state and escrow, plus the global ledger.
tellraw @s [{text:"[Euchre] Ledger: ",color:"gold"},{text:"collected ",color:"gray"},{score:{name:"#collected",objective:"euchre.g"},color:"white"},{text:" = delivered ",color:"gray"},{score:{name:"#delivered",objective:"euchre.g"},color:"white"},{text:" + held ",color:"gray"},{score:{name:"#held",objective:"euchre.g"},color:"white"},{text:" + owed ",color:"gray"},{score:{name:"#owed",objective:"euchre.g"},color:"white"},{text:" · frozen: ",color:"gray"},{score:{name:"#frozen",objective:"euchre.g"},color:"white"}]
tag @s add euchre.inspecting
execute as @e[type=minecraft:marker,tag=euchre.table,distance=..8,sort=nearest,limit=1] run function euchre:admin/inspect_table
tag @s remove euchre.inspecting
