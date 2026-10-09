# Empty seat $(seat) of table $(tid), keeping the occupant's name in euchre:tmp name.
data modify storage euchre:tmp name set value "?"
$data modify storage euchre:tmp name set from storage euchre:tables list[{id:$(tid)}].seats[$(seat)].name
$data modify storage euchre:tables list[{id:$(tid)}].seats[$(seat)] set value {}
