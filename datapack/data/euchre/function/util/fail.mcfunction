# Tell the executor why something was refused, then fail.
# Usage: return run function euchre:util/fail {msg:"..."}
$tellraw @s [{text:"[Euchre] ",color:"gold"},{text:"$(msg)",color:"red"}]
return fail
