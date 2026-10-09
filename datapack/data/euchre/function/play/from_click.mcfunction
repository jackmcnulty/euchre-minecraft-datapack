# As a player who clicked card spot #spot of table #spot_tid.
# Clicks by anyone not seated at this table are ignored silently.
execute unless entity @s[tag=euchre.seated] run return 0
execute unless score @s euchre.tid = #spot_tid euchre.tmp run return 0
execute unless score @s euchre.seat = #spot euchre.tmp run return run function euchre:util/fail {msg:"That's not your spot. Play onto the spot in front of you."}
execute unless data entity @s SelectedItem.components."minecraft:custom_data".euchre.card run return run function euchre:util/fail {msg:"Hold the card you want to play, then right-click your spot."}
data modify storage euchre:tmp pc set value {}
execute store result storage euchre:tmp pc.card int 1 run data get entity @s SelectedItem.components."minecraft:custom_data".euchre.card
return run function euchre:play/try with storage euchre:tmp pc
