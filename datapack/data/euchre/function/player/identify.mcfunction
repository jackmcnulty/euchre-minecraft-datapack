# As a player: make sure they have a pid, and put their current name in euchre:tmp name.
execute unless score @s euchre.pid matches 1.. run function euchre:player/new_pid
function euchre:player/capture_name
