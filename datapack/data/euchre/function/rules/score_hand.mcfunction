# Points for a finished hand. Pure: scoreboard registers in euchre.tmp only.
#   in:  #mteam (makers' team), #mtricks (tricks they took), #alone (1 if lone hand)
#   out: #pteam (team that scores), #pts
#     makers 3-4 tricks: 1 · all 5: 2, or 4 alone · under 3 (euchred): defenders 2
scoreboard players operation #pteam euchre.tmp = #mteam euchre.tmp
scoreboard players set #pts euchre.tmp 1
execute if score #mtricks euchre.tmp matches 5 run scoreboard players set #pts euchre.tmp 2
execute if score #mtricks euchre.tmp matches 5 if score #alone euchre.tmp matches 1 run scoreboard players set #pts euchre.tmp 4
execute if score #mtricks euchre.tmp matches ..2 run scoreboard players set #pts euchre.tmp 2
execute if score #mtricks euchre.tmp matches ..2 run scoreboard players operation #pteam euchre.tmp *= #-1 euchre.g
execute if score #mtricks euchre.tmp matches ..2 run scoreboard players add #pteam euchre.tmp 1
