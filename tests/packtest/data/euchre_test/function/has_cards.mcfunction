# Succeeds if player $(name) carries exactly $(n) card items.
$execute store result score #hc euchre.tmp run clear $(name) minecraft:debug_stick[custom_data~{euchre:{}}] 0
$execute if score #hc euchre.tmp matches $(n) run return 1
return fail
