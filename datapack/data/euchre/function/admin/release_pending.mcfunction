# Operator: hand every pending payout to YOU, so you can deliver them by hand
# (e.g. before uninstalling, when the recipients won't be back). Logged, with
# each recipient's name and amount, under your name.
execute unless data storage euchre:pending list[0] run return run function euchre:util/fail {msg:"Nothing is pending."}
tellraw @s [{text:"[Euchre] ",color:"gold"},{text:"Releasing to you (deliver these by hand): ",color:"yellow"},{storage:"euchre:pending",nbt:"list",color:"white"}]
data modify storage euchre:tmp pl set from storage euchre:pending list
data modify storage euchre:pending list set value []
function euchre:admin/release_next
function euchre:escrow/assert
return 1
