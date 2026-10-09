# Tell the executor why something was refused, then fail. The reason is also kept
# in euchre:tmp last_error so tests (and curious admins) can read it.
# Usage: return run function euchre:util/fail {msg:"..."}
$data modify storage euchre:tmp last_error set value "$(msg)"
$tellraw @s [{text:"[Euchre] ",color:"gold"},{text:"$(msg)",color:"red"}]
return fail
