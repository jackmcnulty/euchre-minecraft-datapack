# As/at the table marker: everyone is back. Continue exactly where the game paused.
# lint: phase-chain-ok (the prompts below never change the phase)
scoreboard players operation @s euchre.phase = @s euchre.resume
function euchre:recount_active
function euchre:table/display/update
tellraw @a[distance=..16] [{text:"[Euchre] ",color:"gold"},{text:"Everyone's back. The game continues.",color:"green"}]
execute if score @s euchre.phase matches 3 run function euchre:bid/prompt
execute if score @s euchre.phase matches 5 run function euchre:bid/prompt
execute if score @s euchre.phase matches 6 run function euchre:play/prompt
