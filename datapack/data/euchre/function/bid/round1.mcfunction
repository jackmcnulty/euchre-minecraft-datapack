# As the bidder in round 1: pass, or order up the up card's suit.
execute if score #act euchre.tmp matches 1 run return run function euchre:bid/pass
execute if score #act euchre.tmp matches 2 run return run function euchre:bid/order_up
execute if score #act euchre.tmp matches 3 run scoreboard players set #alone_bid euchre.tmp 1
execute if score #act euchre.tmp matches 3 run return run function euchre:bid/order_up
return run function euchre:util/fail {msg:"In the first round you can order up (alone or not) or pass."}
