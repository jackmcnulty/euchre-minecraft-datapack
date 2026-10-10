# As the bidder in round 1: pass, or order up the up card's suit.
execute if score #act euchre.tmp matches 1 run return run function euchre:bid/pass
execute if score #act euchre.tmp matches 2 run return run function euchre:bid/order_up
return run function euchre:util/fail {msg:"In the first round you can order up or pass."}
