# Children of a text list inherit the first element's style, so later parts
# reset bold explicitly.
$execute as @e[type=minecraft:text_display,tag=euchre.board] if score @s euchre.tid = #tid euchre.tmp run data modify entity @s text set value [{text:"♠ ♥  EUCHRE  ♣ ♦\n",color:"gold",bold:true},{text:"Table #$(tid)\n",color:"gray",bold:false},{text:"$(stake) · first to $(target)\n",color:"aqua",bold:false},{text:"Players $(seated)/4 · $(state)",color:"white",bold:false},{text:"$(info)",color:"yellow",bold:false}]
