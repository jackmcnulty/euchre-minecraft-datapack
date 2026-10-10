# As/at the table marker: team $(team) forfeits; team $(winner) wins.
$tellraw @a[distance=..16] [{text:"[Euchre] ",color:"gold"},{storage:"euchre:const",nbt:"team_names[$(team)]",color:"white"},{text:" didn't return in time and forfeits.",color:"yellow"}]
$function euchre:game/win {team:$(winner)}
