# As the dealer: receive the up card, then discard.
function euchre:card/give_hand_list
tellraw @s [{text:"[Euchre] ",color:"gold"},{text:"You picked up the up card. Discard one: hold it and right-click your spot.",color:"aqua"}]
