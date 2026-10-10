# Append euchre:tmp log {kind, uuid, name, amount} to the audit log with the game
# time, keep the last 256 entries, and tell operators who opted in.
execute store result storage euchre:tmp log.t int 1 run time query gametime
data modify storage euchre:audit log append from storage euchre:tmp log
execute store result score #n euchre.tmp run data get storage euchre:audit log
execute if score #n euchre.tmp matches 257.. run data remove storage euchre:audit log[0]
tellraw @a[tag=euchre.notify] [{text:"[Euchre audit] ",color:"dark_aqua"},{storage:"euchre:tmp",nbt:"log.kind",color:"white"},{text:" ",color:"gray"},{storage:"euchre:tmp",nbt:"log.amount",color:"white"},{text:" diamonds, ",color:"gray"},{storage:"euchre:tmp",nbt:"log.name",color:"white"}]
