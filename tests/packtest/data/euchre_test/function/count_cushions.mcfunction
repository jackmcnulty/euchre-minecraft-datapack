# Third step of the fixture, a tick after placing: tag and count the cushions.
execute positioned ~0.5 ~ ~0.5 run tag @e[type=minecraft:cushion,distance=..2] add euchre_test.cushion
execute positioned ~0.5 ~ ~0.5 store result score #cushions euchre.tmp if entity @e[type=minecraft:cushion,distance=..2]
