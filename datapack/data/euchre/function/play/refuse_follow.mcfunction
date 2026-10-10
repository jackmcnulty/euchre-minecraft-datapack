# The player tried an off-suit card while holding the led suit (#led).
execute store result storage euchre:tmp f.led int 1 run scoreboard players get #led euchre.tmp
return run function euchre:play/refuse_follow_suit with storage euchre:tmp f
