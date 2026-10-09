# One-time initialisation, called by euchre:load when no schema is recorded.
data modify storage euchre:meta schema set value 1

scoreboard players set #active euchre.g 0
scoreboard players set #next_tid euchre.g 1
scoreboard players set #next_pid euchre.g 1

# Diamond ledger. Invariant: #collected = #delivered + #held + #owed.
scoreboard players set #collected euchre.g 0
scoreboard players set #delivered euchre.g 0
scoreboard players set #held euchre.g 0
scoreboard players set #owed euchre.g 0
scoreboard players set #frozen euchre.g 0

data modify storage euchre:tables list set value []
data modify storage euchre:pending list set value []
data modify storage euchre:audit log set value []

tellraw @a[tag=euchre.notify] {text:"[Euchre] Installed (schema 1).",color:"gold"}
