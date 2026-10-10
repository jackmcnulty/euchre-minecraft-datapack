execute unless data storage euchre:tmp tbl[0] run return 0
data modify storage euchre:tmp el set value []
data modify storage euchre:tmp el set from storage euchre:tmp tbl[0].escrow.entries
function euchre:escrow/sum_entries
data remove storage euchre:tmp tbl[0]
function euchre:escrow/sum_tables
