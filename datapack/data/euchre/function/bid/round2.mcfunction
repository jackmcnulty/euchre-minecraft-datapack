# As the bidder in round 2: pass (unless stuck), or name any suit except the
# one turned down.
execute if score #act euchre.tmp matches 1 if score #stick euchre.tmp matches 1 if score #seat euchre.tmp = #dealer euchre.tmp run return run function euchre:util/fail {msg:"Stick the dealer: you must name trump."}
execute if score #act euchre.tmp matches 1 run return run function euchre:bid/pass
execute unless score #act euchre.tmp matches 10..13 run return run function euchre:util/fail {msg:"Name a suit, or pass."}
scoreboard players operation #named euchre.tmp = #act euchre.tmp
scoreboard players remove #named euchre.tmp 10
execute if score #named euchre.tmp = #up_suit euchre.tmp run return run function euchre:util/fail {msg:"That suit was turned down; name another."}
return run function euchre:bid/name_suit
