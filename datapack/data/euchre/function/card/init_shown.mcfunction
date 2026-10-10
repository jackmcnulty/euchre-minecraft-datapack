# As a freshly summoned item_display: a card lying flat on the table, face up.
# left_rotation tilts it +90 degrees about X (as a quaternion). An item sprite's
# front faces -Z, so this turns the front UP; -90 would show its back, which
# renders mirrored. After the tilt the card's top points along the entity's
# facing direction, so callers set the facing (see play/after_play): the
# player's own card then reads upright from their seat.
data merge entity @s {item_display:"none",transformation:{left_rotation:[0.7071068f,0f,0f,0.7071068f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[0.5f,0.5f,0.5f]},Tags:["euchre.entity","euchre.card_shown","euchre.card_new"]}
# Yaw from the execution context (set by the caller); flat, so no pitch.
tp @s ~ ~ ~ ~ 0
scoreboard players operation @s euchre.tid = #tid euchre.tmp
