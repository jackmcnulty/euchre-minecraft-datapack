# Succeeds if player $(name) carries exactly $(n) plain diamonds.
$execute store result score #pd euchre.tmp run clear $(name) minecraft:diamond[!custom_data,!custom_name] 0
$execute if score #pd euchre.tmp matches $(n) run return 1
return fail
