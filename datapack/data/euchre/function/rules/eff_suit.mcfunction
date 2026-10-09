# Effective suit of a card. Pure: scoreboard registers in euchre.tmp only.
#   in:  #card (0-23), #trump (0-3)
#   out: #eff, plus #suit and #rank of the card
# The left bower (the jack of the suit with trump's colour) belongs to trump for
# every purpose, including following suit. Suits pair by colour as 0/1 (black)
# and 2/3 (red), so trump's colour-mate is trump XOR 1 = trump + 1 - 2*(trump % 2).
scoreboard players operation #suit euchre.tmp = #card euchre.tmp
scoreboard players operation #suit euchre.tmp /= #6 euchre.g
scoreboard players operation #rank euchre.tmp = #card euchre.tmp
scoreboard players operation #rank euchre.tmp %= #6 euchre.g
scoreboard players operation #eff euchre.tmp = #suit euchre.tmp

scoreboard players operation #mate euchre.tmp = #trump euchre.tmp
scoreboard players operation #mate euchre.tmp %= #2 euchre.g
scoreboard players operation #mate euchre.tmp *= #-2 euchre.g
scoreboard players operation #mate euchre.tmp += #trump euchre.tmp
scoreboard players add #mate euchre.tmp 1

execute if score #rank euchre.tmp matches 2 if score #suit euchre.tmp = #mate euchre.tmp run scoreboard players operation #eff euchre.tmp = #trump euchre.tmp
