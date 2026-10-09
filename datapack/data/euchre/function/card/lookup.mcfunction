# Add card $(id)'s name and colour to euchre:tmp gc.
$data modify storage euchre:tmp gc.name set from storage euchre:cards table[$(id)].name
$data modify storage euchre:tmp gc.color set from storage euchre:cards table[$(id)].color
