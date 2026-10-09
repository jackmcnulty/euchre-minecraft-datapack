# Runs on world load and on every /reload (via #minecraft:load).
# Must be idempotent: it only creates what is missing and NEVER resets game
# state, escrow, or pending payouts. `scoreboard objectives add` simply fails
# (harmlessly) when the objective already exists.

# --- Global registers and ledger (fake players like #active live here) ---
scoreboard objectives add euchre.g dummy
scoreboard objectives add euchre.tmp dummy

# --- Per-player ---
scoreboard objectives add euchre.pid dummy
scoreboard objectives add euchre.tid dummy
scoreboard objectives add euchre.seat dummy
scoreboard objectives add euchre.act trigger
scoreboard objectives add euchre.left minecraft.custom:minecraft.leave_game

# --- Per-table (stored on the table's marker entity) ---
scoreboard objectives add euchre.phase dummy
scoreboard objectives add euchre.resume dummy
scoreboard objectives add euchre.dealer dummy
scoreboard objectives add euchre.turn dummy
scoreboard objectives add euchre.leader dummy
scoreboard objectives add euchre.trump dummy
scoreboard objectives add euchre.upcard dummy
scoreboard objectives add euchre.maker dummy
scoreboard objectives add euchre.alone dummy
scoreboard objectives add euchre.trickno dummy
scoreboard objectives add euchre.tricks0 dummy
scoreboard objectives add euchre.tricks1 dummy
scoreboard objectives add euchre.pts0 dummy
scoreboard objectives add euchre.pts1 dummy
scoreboard objectives add euchre.timer dummy
scoreboard objectives add euchre.nonce dummy

# --- First install only: counters and the diamond ledger start at zero ---
execute unless data storage euchre:meta schema run function euchre:install/first

# --- Static data, safe to refresh every load ---
function euchre:gen/card_table
data modify storage euchre:defaults setup set value {wager:0,target:5,stick_dealer:1b,grace_s:120}
