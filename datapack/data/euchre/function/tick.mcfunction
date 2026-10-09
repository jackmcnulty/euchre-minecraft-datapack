# Runs every tick (via #minecraft:tick). Keep the idle path to a single score
# check: nothing below runs unless at least one table needs per-tick work.
execute if score #active euchre.g matches 1.. run function euchre:tick/active
