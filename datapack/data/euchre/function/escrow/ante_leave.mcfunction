# As a seated player who'd rather not stake: stand them up (the table notices
# and frees the seat; nothing was taken).
ride @s dismount
tellraw @s [{text:"[Euchre] ",color:"gold"},{text:"You left the table. Nothing was taken.",color:"gray"}]
return 1
