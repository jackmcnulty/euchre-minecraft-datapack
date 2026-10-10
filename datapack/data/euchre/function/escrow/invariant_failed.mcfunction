scoreboard players set #frozen euchre.g 1
data modify storage euchre:tmp log set value {kind:"invariant_fail",name:"-",amount:0}
function euchre:escrow/log
tellraw @a[tag=euchre.notify] [{text:"[Euchre] ",color:"gold"},{text:"ESCROW LEDGER MISMATCH. Wagered games are frozen. See /function euchre:admin/inspect and the audit log (storage euchre:audit).",color:"red",bold:true}]
