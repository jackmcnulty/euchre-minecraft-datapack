# Is the hand's result settled, whatever happens in the tricks still to play? Pure.
#   in:  #mtricks, #dtricks (tricks the makers / defenders have taken so far)
#   out: success if decided: the makers made it and can no longer march
#        (3+ tricks to the defenders' 1+), or the defenders euchred them (3+).
execute if score #dtricks euchre.tmp matches 3.. run return 1
execute if score #mtricks euchre.tmp matches 3.. if score #dtricks euchre.tmp matches 1.. run return 1
return fail
