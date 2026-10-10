# Pay euchre:tmp pay {uuid, name, amount, reason} out of escrow: straight into
# the player's inventory if they're online, otherwise as a pending payout that
# is delivered when they next join. Either way it leaves the escrow (#held).
execute store result score #amt euchre.tmp run data get storage euchre:tmp pay.amount
execute if score #amt euchre.tmp matches ..0 run return 0
scoreboard players operation #held euchre.g -= #amt euchre.tmp
tag @a remove euchre.payee
execute as @a if function euchre:escrow/is_payee run tag @s add euchre.payee
execute if entity @a[tag=euchre.payee] as @a[tag=euchre.payee,limit=1] at @s run return run function euchre:escrow/deliver_now
function euchre:escrow/make_pending
