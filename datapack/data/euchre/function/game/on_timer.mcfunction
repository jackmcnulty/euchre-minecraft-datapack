# As/at a table marker whose phase timer just reached 0. Disarm it first; a
# handler that needs another wait re-arms it.
scoreboard players set @s euchre.timer -1
execute if score @s euchre.phase matches 2 run function euchre:game/deal
execute if score @s euchre.phase matches 7 run function euchre:play/end_trick
execute if score @s euchre.phase matches 9 run function euchre:game/after_over
