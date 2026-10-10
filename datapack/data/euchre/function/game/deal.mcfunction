# As/at a table marker in the DEAL phase: shuffle, deal 5 cards to each player,
# turn up the top card of the kitty, and move on to bidding.
scoreboard players operation #tid euchre.tmp = @s euchre.tid

# Everyone needs 5 empty hotbar slots. If someone filled theirs since sitting
# down, wait for them (we never move their items) and retry every 2 seconds.
scoreboard players set #short euchre.tmp 0
scoreboard players operation #dealer euchre.tmp = @s euchre.dealer
execute as @a[tag=euchre.seated] if score @s euchre.tid = #tid euchre.tmp run function euchre:game/check_space
execute if score #short euchre.tmp matches 1.. run return run scoreboard players set @s euchre.timer 40

# A fresh deal id: card items from any earlier deal become stale.
scoreboard players add #nonce euchre.g 1
scoreboard players operation @s euchre.nonce = #nonce euchre.g

function euchre:deck/shuffle
function euchre:gen/deal_split
execute store result storage euchre:tmp game.nonce int 1 run scoreboard players get #nonce euchre.g
execute store result score @s euchre.upcard run data get storage euchre:tmp game.kitty[0]
execute store result storage euchre:tmp q.tid int 1 run scoreboard players get #tid euchre.tmp
function euchre:game/save with storage euchre:tmp q

# Cards into hotbars, and the up card face up in the middle of the table.
execute as @a[tag=euchre.seated] if score @s euchre.tid = #tid euchre.tmp run function euchre:game/give_hand
function euchre:game/show_upcard

scoreboard players set @s euchre.alone -1
function euchre:bid/begin
