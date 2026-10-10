$data modify storage euchre:tmp gh set from storage euchre:tmp game.hands[$(seat)]
function euchre:rules/sort_hand
$data modify storage euchre:tmp game.hands[$(seat)] set from storage euchre:tmp gh
