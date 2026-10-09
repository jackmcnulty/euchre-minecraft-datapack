# As/at a table marker whose 4 seats are all taken: start a game.
execute store result score #w euchre.tmp run function euchre:table/get_wager
# Wagered tables need the ante/escrow flow, which arrives in a later milestone.
# Until then they never start, so no stake can be taken by half-built code.
execute if score #w euchre.tmp matches 1.. run return run tellraw @a[distance=..16] [{text:"[Euchre] ",color:"gold"},{text:"All four seats are taken, but wagered play isn't available yet.",color:"yellow"}]
tellraw @a[distance=..16] [{text:"[Euchre] ",color:"gold"},{text:"All four seats are taken. Let's play!",color:"green"}]
function euchre:game/start
