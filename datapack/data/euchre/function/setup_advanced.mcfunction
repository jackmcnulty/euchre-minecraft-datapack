# Create a table with every option spelled out.
#   /function euchre:setup_advanced {wager:10,target:5,stick_dealer:1,grace_s:120}
# stick_dealer: 1 = dealer must name trump if everyone passes twice, 0 = redeal.
# grace_s: seconds a player who leaves mid-game has to come back.
$scoreboard players set #w euchre.tmp $(wager)
$scoreboard players set #t euchre.tmp $(target)
$scoreboard players set #sd euchre.tmp $(stick_dealer)
$scoreboard players set #gr euchre.tmp $(grace_s)
return run function euchre:table/setup/begin
