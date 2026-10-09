# Positioned at the table centre. $(ox)/$(oz): offset of this seat's spot in blocks.
$execute positioned ~$(ox) ~ ~$(oz) summon minecraft:interaction run function euchre:table/setup/init_spot
$execute positioned ~$(ox) ~0.35 ~$(oz) summon minecraft:text_display run function euchre:table/setup/init_label
