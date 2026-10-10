execute unless data storage euchre:tmp sl[0] run return 0
execute store result score #a euchre.tmp run data get storage euchre:tmp sl[0].amount
scoreboard players operation #pot euchre.tmp += #a euchre.tmp
data remove storage euchre:tmp sl[0]
function euchre:escrow/sum_next
