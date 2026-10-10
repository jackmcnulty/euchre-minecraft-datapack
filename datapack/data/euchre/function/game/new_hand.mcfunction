# As/at a table marker: shuffle and deal after a short pause.
scoreboard players set @s euchre.phase 2
# Per-hand state from the previous hand ends here.
scoreboard players set @s euchre.alone -1
scoreboard players set @s euchre.maker -1
scoreboard players set @s euchre.timer 40
function euchre:table/display/update
