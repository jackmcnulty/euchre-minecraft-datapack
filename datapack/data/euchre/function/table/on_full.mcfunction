# As/at a table marker whose 4 seats are all taken: start a game (free table)
# or ask for stakes first (wagered table).
execute store result score #w euchre.tmp run function euchre:table/get_wager
execute if score #w euchre.tmp matches 1.. run return run function euchre:escrow/ante_begin
tellraw @a[distance=..16] [{text:"[Euchre] ",color:"gold"},{text:"All four seats are taken. Let's play!",color:"green"}]
function euchre:game/start
