# As/at the table marker after the fifth trick. Scoring arrives with M6; for now
# report the tricks and deal the next hand (the deal passes clockwise).
tellraw @a[distance=..16] [{text:"[Euchre] ",color:"gold"},{text:"Hand over. Tricks: Team A ",color:"gray"},{score:{name:"@s",objective:"euchre.tricks0"},color:"white"},{text:", Team B ",color:"gray"},{score:{name:"@s",objective:"euchre.tricks1"},color:"white"}]
scoreboard players add @s euchre.dealer 1
scoreboard players operation @s euchre.dealer %= #4 euchre.g
function euchre:game/new_hand
