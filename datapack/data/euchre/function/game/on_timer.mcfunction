# As/at a table marker whose phase timer just reached 0. Disarm it first; a
# handler that needs another wait re-arms it.
# Each line returns: a handler changes the phase, and the next line must not
# then react to the new phase in the same tick (that once skipped the game-over
# pause entirely: phase 7 -> end of game -> phase 9 -> immediately reset).
scoreboard players set @s euchre.timer -1
execute if score @s euchre.phase matches 2 run return run function euchre:game/deal
execute if score @s euchre.phase matches 7 run return run function euchre:play/end_trick
execute if score @s euchre.phase matches 9 run return run function euchre:game/after_over
