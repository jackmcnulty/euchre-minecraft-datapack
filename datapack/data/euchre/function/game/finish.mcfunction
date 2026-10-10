# As/at the table marker: the game is over (won or forfeited). Clear the table
# and show the final score for a few seconds before the table resets.
function euchre:game/cleanup
scoreboard players set @s euchre.phase 9
scoreboard players set @s euchre.timer 100
function euchre:recount_active
function euchre:table/display/update
