# Build the table. Preconditions (checked by begin): 4 cushions tagged
# euchre.candidate with seats 0-3 assigned, and a new marker tagged euchre.new.

# --- Table id ---
scoreboard players operation #tid euchre.tmp = #next_tid euchre.g
scoreboard players add #next_tid euchre.g 1

# --- Anchor marker: per-table hot state lives in its scores ---
execute as @e[type=minecraft:marker,tag=euchre.new,limit=1] run function euchre:table/setup/init_marker

# --- Claim the builder's cushions (tags and scores only; we never kill them) ---
scoreboard players operation @e[type=minecraft:cushion,tag=euchre.candidate] euchre.tid = #tid euchre.tmp
tag @e[type=minecraft:cushion,tag=euchre.candidate] add euchre.seat
# While they're seats, a stray punch can't break them (see table/protect_cushion).
execute as @e[type=minecraft:cushion,tag=euchre.candidate] run function euchre:table/protect_cushion

# --- Persistent record ---
data modify storage euchre:tables list append value {seats:[{},{},{},{}],config:{},escrow:{entries:[]},ante:[0b,0b,0b,0b]}
execute store result storage euchre:tables list[-1].id int 1 run scoreboard players get #tid euchre.tmp
execute store result storage euchre:tables list[-1].config.wager int 1 run scoreboard players get #w euchre.tmp
execute store result storage euchre:tables list[-1].config.target int 1 run scoreboard players get #t euchre.tmp
execute store result storage euchre:tables list[-1].config.stick_dealer byte 1 run scoreboard players get #sd euchre.tmp
execute store result storage euchre:tables list[-1].config.grace_s int 1 run scoreboard players get #gr euchre.tmp

# --- Card spot and seat label in front of each cushion ---
execute as @e[type=minecraft:cushion,tag=euchre.candidate] run function euchre:table/setup/spot_for_cushion

# --- Main board above the table ---
execute at @e[type=minecraft:marker,tag=euchre.new,limit=1] positioned ~ ~1.6 ~ summon minecraft:text_display run function euchre:table/setup/init_board

tag @e[type=minecraft:cushion,tag=euchre.candidate] remove euchre.candidate
execute as @e[type=minecraft:marker,tag=euchre.new,limit=1] run function euchre:table/display/update
tag @e[type=minecraft:marker,tag=euchre.new] remove euchre.new

tellraw @s [{text:"[Euchre] ",color:"gold"},{text:"Table #",color:"green"},{score:{name:"#tid",objective:"euchre.tmp"},color:"green"},{text:" is ready. Right-click a cushion to sit.",color:"green"}]
