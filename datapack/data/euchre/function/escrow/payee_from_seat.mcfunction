# Fill euchre:tmp pay.uuid/name from seat $(seat) of table $(tid).
$data modify storage euchre:tmp pay.uuid set from storage euchre:tables list[{id:$(tid)}].seats[$(seat)].uuid
$data modify storage euchre:tmp pay.name set from storage euchre:tables list[{id:$(tid)}].seats[$(seat)].name
