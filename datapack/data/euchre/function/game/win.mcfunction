# As/at the table marker: team $(team) has won the game.
$tellraw @a[distance=..16] [{text:"[Euchre] ",color:"gold"},{storage:"euchre:const",nbt:"team_names[$(team)]",color:"white",bold:true},{text:" wins the game!",color:"green",bold:true}]
# Wagered tables: the winning team splits the pot.
$function euchre:escrow/payout {team:$(team)}
function euchre:game/finish
