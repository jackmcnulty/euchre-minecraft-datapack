# Walk euchre:tmp gl; clear #ok if any card isn't held exactly once.
execute unless data storage euchre:tmp gl[0] run return 0
data modify storage euchre:tmp gk.id set from storage euchre:tmp gl[0]
execute store result score #c euchre.tmp run function euchre:gen/count_card with storage euchre:tmp gk
execute unless score #c euchre.tmp matches 1 run return run scoreboard players set #ok euchre.tmp 0
data remove storage euchre:tmp gl[0]
function euchre:card/check_next
