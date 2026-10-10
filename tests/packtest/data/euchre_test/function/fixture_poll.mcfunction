# Try to finish the table fixture; retry next tick until it's complete.
execute as @e[type=minecraft:marker,tag=euchre_test.origin,limit=1] at @s if function euchre_test:fixture_try run return run function euchre_test:fixture_done
schedule function euchre_test:fixture_poll 1t
