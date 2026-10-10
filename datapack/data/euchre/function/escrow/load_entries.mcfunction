data modify storage euchre:tmp el set value []
$data modify storage euchre:tmp el set from storage euchre:tables list[{id:$(tid)}].escrow.entries
