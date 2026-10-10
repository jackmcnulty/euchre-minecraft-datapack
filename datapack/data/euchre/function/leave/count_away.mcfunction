# #away0 / #away1: 1 if team 0 (N/S, seats 0 and 2) / team 1 (E/W, seats 1 and 3) has a seat held.
scoreboard players set #away0 euchre.tmp 0
scoreboard players set #away1 euchre.tmp 0
$execute if data storage euchre:tables list[{id:$(tid)}].seats[0].away run scoreboard players set #away0 euchre.tmp 1
$execute if data storage euchre:tables list[{id:$(tid)}].seats[2].away run scoreboard players set #away0 euchre.tmp 1
$execute if data storage euchre:tables list[{id:$(tid)}].seats[1].away run scoreboard players set #away1 euchre.tmp 1
$execute if data storage euchre:tables list[{id:$(tid)}].seats[3].away run scoreboard players set #away1 euchre.tmp 1
