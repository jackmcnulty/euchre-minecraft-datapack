# As/at the table marker: team $(team) has won the game.
$tellraw @a[distance=..16] [{text:"[Euchre] ",color:"gold"},{storage:"euchre:const",nbt:"team_names[$(team)]",color:"white",bold:true},{text:" wins the game!",color:"green",bold:true}]
# (Wagered tables pay the pot out here, in a later milestone.)
function euchre:game/finish
