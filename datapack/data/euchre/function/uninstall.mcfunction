# Remove every trace of Euchre from the world: tables, entities, scores, storage.
# Refuses while any diamonds are held or owed, so nobody loses a stake.
# Afterwards, disable the pack: /datapack disable "file/<pack name>"
execute if score #held euchre.g matches 1.. run return run function euchre:util/fail {msg:"Diamonds are held in escrow. Finish or abort those games first."}
execute if data storage euchre:pending list[0] run return run function euchre:util/fail {msg:"Diamonds are still owed to offline players (see euchre:admin/pending_list)."}

execute as @e[type=minecraft:marker,tag=euchre.table] at @s run function euchre:table/remove
execute if data storage euchre:tables list[0] run return run function euchre:util/fail {msg:"A table is in an unloaded area. Go there and run euchre:remove_table, then try again."}

function euchre:uninstall/apply
tellraw @s [{text:"[Euchre] ",color:"gold"},{text:"Uninstalled. Now run /datapack disable on the Euchre pack (see /datapack list) so it doesn't reinstall on the next reload.",color:"green"}]
return 1
