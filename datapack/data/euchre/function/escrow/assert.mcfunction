# The conservation invariant. Every diamond collected is delivered, held in a
# table's escrow, or owed to an offline player:
#   #collected = #delivered + #held + #owed
# and #held / #owed must match what storage actually records. If not, freeze
# wagering (refunds and payouts still work) and alert operators.
scoreboard players operation #lhs euchre.tmp = #collected euchre.g
scoreboard players operation #rhs euchre.tmp = #delivered euchre.g
scoreboard players operation #rhs euchre.tmp += #held euchre.g
scoreboard players operation #rhs euchre.tmp += #owed euchre.g
scoreboard players set #bad euchre.tmp 0
execute unless score #lhs euchre.tmp = #rhs euchre.tmp run scoreboard players set #bad euchre.tmp 1

# Σ escrow entries over all tables == #held
scoreboard players set #pot euchre.tmp 0
data modify storage euchre:tmp tbl set from storage euchre:tables list
function euchre:escrow/sum_tables
execute unless score #pot euchre.tmp = #held euchre.g run scoreboard players set #bad euchre.tmp 1
# Σ pending == #owed
scoreboard players set #pot euchre.tmp 0
data modify storage euchre:tmp el set from storage euchre:pending list
function euchre:escrow/sum_entries
execute unless score #pot euchre.tmp = #owed euchre.g run scoreboard players set #bad euchre.tmp 1

execute if score #bad euchre.tmp matches 1 run function euchre:escrow/invariant_failed
execute if score #bad euchre.tmp matches 0 run return 1
return fail
