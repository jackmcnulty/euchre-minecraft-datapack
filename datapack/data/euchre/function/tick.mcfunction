# Runs every tick (via #minecraft:tick). Idle cost: two cheap checks.

# Players coming back online (leave_game statistic went up while they were away).
execute as @a[scores={euchre.left=1..}] run function euchre:player/on_rejoin

# Per-table work only while someone is seated somewhere.
execute if score #active euchre.g matches 1.. run function euchre:tick/active
