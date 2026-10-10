# Every 5 seconds: recount active tables. Markers in chunks that weren't loaded
# when the pack loaded (e.g. right after a server start) are picked up here.
function euchre:recount_active
# Seat cushions stay protected, including ones adopted before protection
# existed or loaded since the last beat.
execute as @e[type=minecraft:cushion,tag=euchre.seat] run function euchre:table/protect_cushion
# Backup for pending payouts (e.g. a recipient whose rejoin wasn't noticed).
execute if score #owed euchre.g matches 1.. as @a at @s run function euchre:escrow/deliver_pending
schedule function euchre:heartbeat 100t
