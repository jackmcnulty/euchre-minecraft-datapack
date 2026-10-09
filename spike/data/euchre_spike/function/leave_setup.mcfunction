# (g) Track the leave_game statistic for this player.
scoreboard objectives add euchre_spike_left minecraft.custom:minecraft.leave_game
scoreboard objectives setdisplay sidebar euchre_spike_left
tellraw @s {text:"[spike g] leave_game is now on the sidebar. Save & Quit, rejoin, and check it went up by 1.",color:"green"}
