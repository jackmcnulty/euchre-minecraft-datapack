# May card #card be played now? Pure apart from scratch storage.
#   in:  #card, #trump, #led (effective suit led, or -1 when leading),
#        euchre:tmp gh = the player's hand (including #card)
#   out: succeeds if legal. #card is preserved.
# You must follow the led suit if you can. Suits are *effective* suits: the left
# bower counts as trump, so it follows a trump lead and does not follow its own
# printed suit.
execute if score #led euchre.tmp matches -1 run return 1
function euchre:rules/eff_suit
execute if score #eff euchre.tmp = #led euchre.tmp run return 1

# An off-suit card is only legal if nothing in the hand follows suit.
scoreboard players operation #pcard euchre.tmp = #card euchre.tmp
data modify storage euchre:tmp hl set from storage euchre:tmp gh
scoreboard players set #canfollow euchre.tmp 0
function euchre:rules/is_legal_scan
scoreboard players operation #card euchre.tmp = #pcard euchre.tmp
execute if score #canfollow euchre.tmp matches 1 run return fail
return 1
