# As/at the table marker: ask every seated player who hasn't confirmed yet.
scoreboard players operation #tid euchre.tmp = @s euchre.tid
execute store result score #w euchre.tmp run function euchre:table/get_wager
execute as @a[tag=euchre.seated] if score @s euchre.tid = #tid euchre.tmp run function euchre:escrow/ante_prompt_player
