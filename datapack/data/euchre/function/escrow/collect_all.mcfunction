# As/at a wagered table marker whose 4 players all confirmed. ATOMIC: every
# player is checked first, and if anyone can't pay, nothing is taken from anyone.
# Commands run one at a time, so nothing can change between check and take.
scoreboard players operation #tid euchre.tmp = @s euchre.tid
execute store result score #w euchre.tmp run function euchre:table/get_wager
execute if score #frozen euchre.g matches 1 run return run tellraw @a[distance=..16] [{text:"[Euchre] ",color:"gold"},{text:"Wagered games are paused until an operator reviews the escrow ledger.",color:"red"}]

# 1. Can everyone pay?
scoreboard players set #short euchre.tmp 0
execute as @a[tag=euchre.seated] if score @s euchre.tid = #tid euchre.tmp run function euchre:escrow/check_funds
execute if score #short euchre.tmp matches 1 run return run function euchre:escrow/ante_short

# 2. Take exactly the stake from each player, recording what was actually taken.
scoreboard players set #mismatch euchre.tmp 0
execute as @a[tag=euchre.seated] if score @s euchre.tid = #tid euchre.tmp run function euchre:escrow/take_stake
function euchre:escrow/assert

# 3. Should never happen (we just counted): refund whatever was taken.
execute if score #mismatch euchre.tmp matches 1 run data modify storage euchre:tmp reason set value "Collecting the stakes went wrong, so everything taken was refunded. Please confirm again."
execute if score #mismatch euchre.tmp matches 1 run function euchre:escrow/refund_all
execute if score #mismatch euchre.tmp matches 1 run return run function euchre:escrow/ante_begin

tellraw @a[distance=..16] [{text:"[Euchre] ",color:"gold"},{text:"Stakes collected. Pot: ",color:"green"},{score:{name:"@s",objective:"euchre.pot"},color:"white",bold:true},{text:" diamonds. Good luck!",color:"green"}]
function euchre:game/start
