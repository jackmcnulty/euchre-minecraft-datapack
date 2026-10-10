# As/at the online recipient (tagged euchre.payee) of euchre:tmp pay.
data modify storage euchre:tmp gv set value {}
data modify storage euchre:tmp gv.amount set from storage euchre:tmp pay.amount
function euchre:gen/escrow_give with storage euchre:tmp gv
tag @s remove euchre.payee
scoreboard players operation #delivered euchre.g += #amt euchre.tmp
data modify storage euchre:tmp log set value {}
data modify storage euchre:tmp log.kind set from storage euchre:tmp pay.reason
data modify storage euchre:tmp log.uuid set from storage euchre:tmp pay.uuid
data modify storage euchre:tmp log.name set from storage euchre:tmp pay.name
data modify storage euchre:tmp log.amount set from storage euchre:tmp pay.amount
function euchre:escrow/log
execute if data storage euchre:tmp pay{reason:"winnings"} run tellraw @s [{text:"[Euchre] ",color:"gold"},{text:"You won ",color:"green"},{score:{name:"#amt",objective:"euchre.tmp"},color:"white",bold:true},{text:" diamonds!",color:"green"}]
execute unless data storage euchre:tmp pay{reason:"winnings"} run tellraw @s [{text:"[Euchre] ",color:"gold"},{text:"Your stake of ",color:"yellow"},{score:{name:"#amt",objective:"euchre.tmp"},color:"white",bold:true},{text:" diamonds was returned.",color:"yellow"}]
return 1
