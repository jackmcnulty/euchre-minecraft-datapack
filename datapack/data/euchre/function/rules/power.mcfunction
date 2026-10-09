# Trick-taking strength of a card. Pure: scoreboard registers in euchre.tmp only.
#   in:  #card, #trump, #led (effective suit of the card that was led)
#   out: #power. The highest power in a trick wins; 0 can never win.
#     right bower 20 > left bower 19 > other trump A..9 = 17,16,15,13,12
#     > led suit A..9 = 6..1 > anything else 0
# Ranks are 0=9 1=10 2=J 3=Q 4=K 5=A, so trump is 12+rank and led is rank+1.
function euchre:rules/eff_suit
scoreboard players set #power euchre.tmp 0
execute if score #eff euchre.tmp = #led euchre.tmp run scoreboard players operation #power euchre.tmp = #rank euchre.tmp
execute if score #eff euchre.tmp = #led euchre.tmp run scoreboard players add #power euchre.tmp 1
# Trump beats the led suit; when trump was led, this overrides the line above.
execute if score #eff euchre.tmp = #trump euchre.tmp run scoreboard players operation #power euchre.tmp = #rank euchre.tmp
execute if score #eff euchre.tmp = #trump euchre.tmp run scoreboard players add #power euchre.tmp 12
execute if score #eff euchre.tmp = #trump euchre.tmp if score #rank euchre.tmp matches 2 run scoreboard players set #power euchre.tmp 19
execute if score #eff euchre.tmp = #trump euchre.tmp if score #rank euchre.tmp matches 2 if score #suit euchre.tmp = #trump euchre.tmp run scoreboard players set #power euchre.tmp 20
