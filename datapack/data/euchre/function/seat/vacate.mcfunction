# As/at the table marker: the player in seat $(seat) has gone (stood up or
# disconnected). Mid-game their seat is held for them; otherwise it's free.
data modify storage euchre:tmp name set value "?"
$data modify storage euchre:tmp name set from storage euchre:tables list[{id:$(tid)}].seats[$(seat)].name
scoreboard players remove @s euchre.seated 1
execute if score @s euchre.seated matches ..-1 run scoreboard players set @s euchre.seated 0
$execute if score @s euchre.phase matches 2..8 run return run function euchre:leave/away {tid:$(tid),seat:$(seat)}
$execute if score @s euchre.phase matches 10 run return run function euchre:leave/away {tid:$(tid),seat:$(seat)}
execute if score @s euchre.phase matches 1 run function euchre:escrow/ante_cancel
$data modify storage euchre:tables list[{id:$(tid)}].seats[$(seat)] set value {}
function euchre:recount_active
function euchre:table/display/update
tellraw @a[distance=..16] [{text:"[Euchre] ",color:"gold"},{storage:"euchre:tmp",nbt:"name",color:"white"},{text:" left the table.",color:"gray"}]
