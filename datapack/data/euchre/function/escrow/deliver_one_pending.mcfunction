# As the player owed euchre:tmp pay.
execute store result score #amt euchre.tmp run data get storage euchre:tmp pay.amount
scoreboard players operation #owed euchre.g -= #amt euchre.tmp
tag @s add euchre.payee
data modify storage euchre:tmp gv set value {}
data modify storage euchre:tmp gv.amount set from storage euchre:tmp pay.amount
function euchre:gen/escrow_give with storage euchre:tmp gv
tag @s remove euchre.payee
scoreboard players operation #delivered euchre.g += #amt euchre.tmp
data modify storage euchre:tmp log set value {kind:"deliver"}
data modify storage euchre:tmp log.uuid set from storage euchre:tmp pay.uuid
data modify storage euchre:tmp log.name set from storage euchre:tmp pay.name
data modify storage euchre:tmp log.amount set from storage euchre:tmp pay.amount
function euchre:escrow/log
execute if data storage euchre:tmp pay{reason:"winnings"} run tellraw @s [{text:"[Euchre] ",color:"gold"},{text:"While you were away, your team won a Euchre game. Here are your winnings: ",color:"green"},{score:{name:"#amt",objective:"euchre.tmp"},color:"white",bold:true},{text:" diamonds.",color:"green"}]
execute unless data storage euchre:tmp pay{reason:"winnings"} run tellraw @s [{text:"[Euchre] ",color:"gold"},{text:"A Euchre game you staked in was cancelled while you were away. Your stake was returned: ",color:"yellow"},{score:{name:"#amt",objective:"euchre.tmp"},color:"white",bold:true},{text:" diamonds.",color:"yellow"}]
function euchre:escrow/assert
