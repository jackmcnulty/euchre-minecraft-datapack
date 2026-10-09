# As a player: give every card in euchre:tmp gh (consumes the list).
# The table id comes from the player's seat, the deal id from the working game.
data modify storage euchre:tmp gc set value {}
execute store result storage euchre:tmp gc.tid int 1 run scoreboard players get @s euchre.tid
data modify storage euchre:tmp gc.nonce set from storage euchre:tmp game.nonce
function euchre:card/give_next
