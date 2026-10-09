# (d) Does `time query gametime` still exist and return a number?
scoreboard objectives add euchre_spike dummy
execute store result score #t euchre_spike run time query gametime
tellraw @s [{text:"[spike d] gametime = ",color:"green"},{score:{name:"#t",objective:"euchre_spike"}},{text:" (should be > 0 and grow)"}]
