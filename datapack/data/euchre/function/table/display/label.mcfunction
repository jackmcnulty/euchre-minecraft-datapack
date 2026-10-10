# As a seat label: show the seat's direction, team and occupant.
data modify storage euchre:tmp lbl set value {name:"(empty)",color:"gray",mark:"",note:""}
execute if score @s euchre.seat = #lturn euchre.tmp run data modify storage euchre:tmp lbl.mark set value "▶ "
execute if score @s euchre.seat = #lalone euchre.tmp run data modify storage euchre:tmp lbl.note set value " (sitting out)"
execute store result storage euchre:tmp lbl.tid int 1 run scoreboard players get #tid euchre.tmp
execute store result storage euchre:tmp lbl.seat int 1 run scoreboard players get @s euchre.seat
function euchre:table/display/label_fill with storage euchre:tmp lbl
function euchre:table/display/label_text with storage euchre:tmp lbl
