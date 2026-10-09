# Runs on world load and on every /reload (via #minecraft:load).
# Must be idempotent: it only creates what is missing and NEVER resets game
# state, escrow, or pending payouts.

# Objectives are listed once, in tools/gen.py.
function euchre:gen/objectives_add

# --- First install only: counters and the diamond ledger start at zero ---
execute unless data storage euchre:meta schema run function euchre:install/first

# --- Constants and static data, safe to refresh every load ---
scoreboard players set #-1 euchre.g -1
scoreboard players set #45 euchre.g 45
scoreboard players set #100 euchre.g 100
function euchre:gen/card_table
data modify storage euchre:defaults setup set value {wager:0,target:5,stick_dealer:1b,grace_s:120}
data modify storage euchre:const seat_names set value ["North","East","South","West"]
# Partners sit opposite each other: N/S are Team A, E/W are Team B.
data modify storage euchre:const seat_teams set value ["Team A","Team B","Team A","Team B"]

# --- Tables may have changed while the pack was unloaded; recount the active ones ---
function euchre:recount_active
