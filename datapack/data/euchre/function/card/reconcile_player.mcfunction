# As a seated player mid-hand (euchre:tmp game is current): their card items must
# be exactly their hand. Storage is the source of truth; items are only a view.
execute store result storage euchre:tmp q.seat int 1 run scoreboard players get @s euchre.seat
function euchre:card/load_hand with storage euchre:tmp q
execute store result score #want euchre.tmp run data get storage euchre:tmp gh
execute store result score #have euchre.tmp run function euchre:gen/count_cards

# Fast path: the right number of cards, and each card of the hand present once.
scoreboard players set #ok euchre.tmp 1
execute unless score #have euchre.tmp = #want euchre.tmp run scoreboard players set #ok euchre.tmp 0
data modify storage euchre:tmp gl set from storage euchre:tmp gh
data modify storage euchre:tmp gk set value {}
data modify storage euchre:tmp gk.nonce set from storage euchre:tmp game.nonce
execute if score #ok euchre.tmp matches 1 run function euchre:card/check_next
execute if score #ok euchre.tmp matches 1 run return 0

# Something is off (a card dropped, duplicated, stale or smuggled in): replace
# all of their card items with a fresh copy of the hand.
function euchre:gen/clear_cards
function euchre:card/give_hand_list
tellraw @s [{text:"[Euchre] ",color:"gold"},{text:"Your hand was restored from the table.",color:"gray"}]
