# As/at the table marker: team $(team) has won the game.
$tellraw @a[distance=..16] [{text:"[Euchre] ",color:"gold"},{storage:"euchre:const",nbt:"team_names[$(team)]",color:"white",bold:true},{text:" wins the game!",color:"green",bold:true}]
playsound minecraft:ui.toast.challenge_complete master @a[distance=..16] ~ ~ ~ 0.8 1
particle minecraft:totem_of_undying ~ ~1.2 ~ 0.4 0.4 0.4 0.3 60
# Wagered tables: the winning team splits the pot.
$function euchre:escrow/payout {team:$(team)}
function euchre:game/finish
