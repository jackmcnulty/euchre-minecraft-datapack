# As a player riding a cushion whose table no longer exists: un-claim the cushion
# (it's the builder's again) and leave the player sitting on it, as vanilla would.
execute on vehicle run function euchre:table/release_cushion
return fail
