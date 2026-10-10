# As/at a player who has just come online: deliver anything owed to them.
execute unless data storage euchre:pending list[0] run return 0
data modify storage euchre:tmp pl set from storage euchre:pending list
data modify storage euchre:pending list set value []
function euchre:escrow/deliver_pending_next
