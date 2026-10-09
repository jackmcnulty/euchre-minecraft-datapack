$data modify storage euchre:tmp disp.dealer_name set from storage euchre:const seat_names[$(dealer)]
$data modify storage euchre:tmp disp.up_name set from storage euchre:cards table[$(up)].name
function euchre:table/display/bid_info_text with storage euchre:tmp disp
