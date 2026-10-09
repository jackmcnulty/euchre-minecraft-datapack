# Stand the player up and tell them why. Usage: return run function euchre:seat/refuse {msg:"..."}
ride @s dismount
$tellraw @s [{text:"[Euchre] ",color:"gold"},{text:"$(msg)",color:"red"}]
return fail
