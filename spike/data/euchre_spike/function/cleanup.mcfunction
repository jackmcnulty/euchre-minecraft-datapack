scoreboard objectives remove euchre_spike
scoreboard objectives remove euchre_spike_left
data remove storage euchre_spike:tmp head
tellraw @s {text:"[spike] cleaned up",color:"green"}
