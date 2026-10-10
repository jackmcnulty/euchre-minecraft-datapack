# As/at the table marker right after a deal: first round of bidding, starting
# with the player left of the dealer.
scoreboard players set @s euchre.phase 3
scoreboard players set @s euchre.bids 0
scoreboard players set @s euchre.maker -1
scoreboard players operation @s euchre.turn = @s euchre.dealer
function euchre:play/next_turn
function euchre:table/display/update
function euchre:bid/prompt
