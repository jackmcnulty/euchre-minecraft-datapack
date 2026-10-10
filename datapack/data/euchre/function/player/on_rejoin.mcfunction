# As a player who has left the game at least once and is now online again
# (the leave_game statistic counts Save & Quit and crashes alike; verified on 26.3).
scoreboard players reset @s euchre.left
# Diamonds owed to them from a game that ended while they were away.
execute at @s run function euchre:escrow/deliver_pending
# Their seat was freed when the table noticed they were gone, so any seat state is stale.
execute if entity @s[tag=euchre.seated] run function euchre:player/clear_seat
# Vanilla may put them straight back on the cushion they logged out on.
execute at @s run function euchre:seat/check_sit
