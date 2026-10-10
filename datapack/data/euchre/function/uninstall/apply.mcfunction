# Everything below is ours alone (euchre-prefixed). Offline players keep their
# old euchre.* tags, which are harmless once nothing reads them.
kill @e[tag=euchre.entity]
execute as @a run function euchre:gen/clear_cards
tag @a remove euchre.seated
tag @a remove euchre.sit_check
tag @a remove euchre.notify
scoreboard players reset @a euchre.act
advancement revoke @a only euchre:seat_click
schedule clear euchre:seat/deferred_check
schedule clear euchre:heartbeat

function euchre:gen/objectives_remove

data remove storage euchre:tables list
data remove storage euchre:pending list
data remove storage euchre:audit log
data remove storage euchre:cards table
data remove storage euchre:defaults setup
data remove storage euchre:const seat_names
data remove storage euchre:const seat_teams
data remove storage euchre:const phase_names
data remove storage euchre:const suit_symbols
data remove storage euchre:const team_names
data remove storage euchre:debug dealer
advancement revoke @a only euchre:spot_click
data remove storage euchre:debug rig
data remove storage euchre:meta schema
data remove storage euchre:tmp disp
data remove storage euchre:tmp lbl
data remove storage euchre:tmp q
data remove storage euchre:tmp spot
data remove storage euchre:tmp name
