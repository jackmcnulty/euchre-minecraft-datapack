# Seats held for players who left mid-game are released when the game ends.
$execute if data storage euchre:tables list[{id:$(tid)}].seats[0].away run data modify storage euchre:tables list[{id:$(tid)}].seats[0] set value {}
$execute if data storage euchre:tables list[{id:$(tid)}].seats[1].away run data modify storage euchre:tables list[{id:$(tid)}].seats[1] set value {}
$execute if data storage euchre:tables list[{id:$(tid)}].seats[2].away run data modify storage euchre:tables list[{id:$(tid)}].seats[2] set value {}
$execute if data storage euchre:tables list[{id:$(tid)}].seats[3].away run data modify storage euchre:tables list[{id:$(tid)}].seats[3] set value {}
