# (k) Fires if right-clicking a cushion triggers player_interacted_with_entity.
advancement revoke @s only euchre_spike:cushion_click
tellraw @a {text:"[spike k] cushion click advancement FIRED",color:"green"}
