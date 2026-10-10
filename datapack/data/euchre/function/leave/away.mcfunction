# As/at the table marker: hold seat $(seat) for its player and pause the game.
$data modify storage euchre:tables list[{id:$(tid)}].seats[$(seat)].away set value 1b
execute unless score @s euchre.phase matches 10 run function euchre:leave/pause
function euchre:recount_active
function euchre:table/display/update
execute store result score #gr euchre.tmp run function euchre:table/get_grace
tellraw @a[distance=..16] [{text:"[Euchre] ",color:"gold"},{storage:"euchre:tmp",nbt:"name",color:"white"},{text:" left mid-game. Their seat is held; the game resumes when they sit back down. If they're not back within ",color:"yellow"},{score:{name:"#gr",objective:"euchre.tmp"},color:"white"},{text:" seconds, their team forfeits.",color:"yellow"}]
