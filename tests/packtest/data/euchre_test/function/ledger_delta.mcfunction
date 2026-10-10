# Succeeds if the ledger moved by exactly c collected, d delivered, h held and
# o owed since ledger_snapshot, AND the conservation invariant holds.
scoreboard players operation #dc euchre.tmp = #collected euchre.g
scoreboard players operation #dc euchre.tmp -= #s_collected euchre.tmp
scoreboard players operation #dd euchre.tmp = #delivered euchre.g
scoreboard players operation #dd euchre.tmp -= #s_delivered euchre.tmp
scoreboard players operation #dh euchre.tmp = #held euchre.g
scoreboard players operation #dh euchre.tmp -= #s_held euchre.tmp
scoreboard players operation #do euchre.tmp = #owed euchre.g
scoreboard players operation #do euchre.tmp -= #s_owed euchre.tmp
$execute unless score #dc euchre.tmp matches $(c) run return fail
$execute unless score #dd euchre.tmp matches $(d) run return fail
$execute unless score #dh euchre.tmp matches $(h) run return fail
$execute unless score #do euchre.tmp matches $(o) run return fail
execute unless function euchre:escrow/assert run return fail
execute if score #frozen euchre.g matches 1 run return fail
return 1
