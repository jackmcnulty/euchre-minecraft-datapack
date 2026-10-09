# As the sitting player. Records them in the seat; UUID is the durable identity
# (escrow and pending payouts key on it), pid is the fast in-game one.
$data modify storage euchre:tables list[{id:$(tid)}].seats[$(seat)] set value {pid:$(pid),name:"$(name)"}
$data modify storage euchre:tables list[{id:$(tid)}].seats[$(seat)].uuid set from entity @s UUID
