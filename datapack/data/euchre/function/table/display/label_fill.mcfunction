$data modify storage euchre:tmp lbl.dir set from storage euchre:const seat_names[$(seat)]
$data modify storage euchre:tmp lbl.team set from storage euchre:const seat_teams[$(seat)]
$execute if data storage euchre:tables list[{id:$(tid)}].seats[$(seat)].name run data modify storage euchre:tmp lbl.color set value "white"
$data modify storage euchre:tmp lbl.name set from storage euchre:tables list[{id:$(tid)}].seats[$(seat)].name
