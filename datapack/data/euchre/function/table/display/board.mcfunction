# $(tid): fetch this table's config into the display scratch space.
$data modify storage euchre:tmp disp.wager set from storage euchre:tables list[{id:$(tid)}].config.wager
$data modify storage euchre:tmp disp.target set from storage euchre:tables list[{id:$(tid)}].config.target
data modify storage euchre:tmp disp.stake set value "Free play"
execute unless data storage euchre:tmp disp{wager:0} run function euchre:table/display/stake_text with storage euchre:tmp disp
function euchre:table/display/board_text with storage euchre:tmp disp
