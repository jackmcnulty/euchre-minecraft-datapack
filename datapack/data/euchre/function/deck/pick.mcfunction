# Pick a random index 0..$(max) of the remaining deck and move that card.
$execute store result storage euchre:tmp pick.i int 1 run random value 0..$(max)
function euchre:deck/take with storage euchre:tmp pick
