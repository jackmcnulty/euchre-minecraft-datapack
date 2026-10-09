# As a candidate cushion: work out which side of the table it is on and store
# it in euchre.seat (0=N, 1=E, 2=S, 3=W). Minecraft's north is -Z and east is +X.
# Uses #mx/#mz (table centre) from load_center.
execute store result score #dx euchre.tmp run data get entity @s Pos[0] 100
execute store result score #dz euchre.tmp run data get entity @s Pos[2] 100
scoreboard players operation #dx euchre.tmp -= #mx euchre.tmp
scoreboard players operation #dz euchre.tmp -= #mz euchre.tmp

# |dx| and |dz|
scoreboard players operation #ax euchre.tmp = #dx euchre.tmp
execute if score #ax euchre.tmp matches ..-1 run scoreboard players operation #ax euchre.tmp *= #-1 euchre.g
scoreboard players operation #az euchre.tmp = #dz euchre.tmp
execute if score #az euchre.tmp matches ..-1 run scoreboard players operation #az euchre.tmp *= #-1 euchre.g

# Mostly along Z means north/south; otherwise east/west. A cushion exactly on a
# diagonal counts as north/south, and the one-cushion-per-side check then rejects
# a layout that is genuinely ambiguous.
execute if score #az euchre.tmp >= #ax euchre.tmp if score #dz euchre.tmp matches ..-1 run scoreboard players set @s euchre.seat 0
execute if score #az euchre.tmp >= #ax euchre.tmp if score #dz euchre.tmp matches 0.. run scoreboard players set @s euchre.seat 2
execute if score #az euchre.tmp < #ax euchre.tmp if score #dx euchre.tmp matches 1.. run scoreboard players set @s euchre.seat 1
execute if score #az euchre.tmp < #ax euchre.tmp if score #dx euchre.tmp matches ..0 run scoreboard players set @s euchre.seat 3
