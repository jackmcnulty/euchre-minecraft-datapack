$data modify storage euchre:tmp f.sym set from storage euchre:const suit_symbols[$(led)]
return run function euchre:play/refuse_follow_text with storage euchre:tmp f
