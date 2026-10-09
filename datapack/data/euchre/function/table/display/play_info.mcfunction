$data modify storage euchre:tmp disp.trump_sym set from storage euchre:const suit_symbols[$(trump)]
$data modify storage euchre:tmp disp.turn_name set from storage euchre:const seat_names[$(turn)]
function euchre:table/display/play_info_text with storage euchre:tmp disp
