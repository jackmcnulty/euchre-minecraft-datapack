execute unless data storage euchre:tmp gh[0] run return 0
data modify storage euchre:tmp gc.id set from storage euchre:tmp gh[0]
function euchre:card/lookup with storage euchre:tmp gc
execute store result storage euchre:tmp gc.slot int 1 run function euchre:gen/first_empty_hotbar_slot
# No free slot (only possible when restoring a hand): reconcile retries later.
execute if data storage euchre:tmp gc{slot:-1} run tellraw @s [{text:"[Euchre] ",color:"gold"},{text:"Free a hotbar slot so your missing card can be returned.",color:"yellow"}]
execute unless data storage euchre:tmp gc{slot:-1} run function euchre:gen/give_card with storage euchre:tmp gc
data remove storage euchre:tmp gh[0]
function euchre:card/give_next
