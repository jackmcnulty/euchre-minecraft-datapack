# As a player who may be sitting on a table's cushion: seat them at the table,
# or stand them back up with a reason. Returns 1 if they end up seated.
# Also the internal API that tests call directly.
function euchre:seat/read_vehicle
execute if score #tid euchre.tmp matches 0 run return fail

# Already in exactly this seat (e.g. a repeated click): nothing to do.
execute if entity @s[tag=euchre.seated] if score @s euchre.tid = #tid euchre.tmp if score @s euchre.seat = #seat euchre.tmp run return 1
# Hopped straight from another seat: free that one first, then re-read.
execute if entity @s[tag=euchre.seated] run function euchre:seat/stand
function euchre:seat/read_vehicle

# A cushion can outlive its table: a seated player who logs out takes the cushion
# with them (vanilla saves vehicles with their rider), and the table may be
# removed before they return. Release such an orphan instead of refusing.
execute unless function euchre:seat/table_exists run return run function euchre:seat/release_orphan

# Only while the table is waiting for players. (Returning to a reserved seat
# mid-game is part of leaver handling, in a later milestone.)
scoreboard players set #phase euchre.tmp -1
execute as @e[type=minecraft:marker,tag=euchre.table] if score @s euchre.tid = #tid euchre.tmp run scoreboard players operation #phase euchre.tmp = @s euchre.phase
execute unless score #phase euchre.tmp matches 0 run return run function euchre:seat/refuse {msg:"A game is in progress at this table."}

# Storage is the source of truth for who holds a seat.
execute store result storage euchre:tmp q.tid int 1 run scoreboard players get #tid euchre.tmp
execute store result storage euchre:tmp q.seat int 1 run scoreboard players get #seat euchre.tmp
execute if function euchre:seat/is_taken run return run function euchre:seat/refuse {msg:"That seat is taken."}

# Room for a hand. We never move a player's items to make room.
execute store result score #n euchre.tmp run function euchre:gen/count_empty_hotbar_slots
execute if score #n euchre.tmp matches ..4 run return run function euchre:seat/refuse {msg:"You need 5 empty hotbar slots to play. Your items are never moved, so please clear some space."}

function euchre:seat/sit
return 1
