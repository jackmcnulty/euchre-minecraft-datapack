# Walk euchre:tmp hl; set #canfollow if any card's effective suit is #led.
execute unless data storage euchre:tmp hl[0] run return 0
execute store result score #card euchre.tmp run data get storage euchre:tmp hl[0]
function euchre:rules/eff_suit
execute if score #eff euchre.tmp = #led euchre.tmp run return run scoreboard players set #canfollow euchre.tmp 1
data remove storage euchre:tmp hl[0]
function euchre:rules/is_legal_scan
