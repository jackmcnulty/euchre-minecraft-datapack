# As a seated player at a wagered table.
scoreboard players set @s euchre.act 0
scoreboard players enable @s euchre.act
tellraw @s [{text:"[Euchre] ",color:"gold"},{text:"This table plays for ",color:"aqua"},{score:{name:"#w",objective:"euchre.tmp"},color:"white",bold:true},{text:" diamonds each. Winners split the pot. ",color:"aqua"},{text:"[Stake my diamonds]",color:"green",bold:true,click_event:{action:"run_command",command:"/trigger euchre.act set 30"},hover_event:{action:"show_text",value:"Nothing is taken until all four players have confirmed and can pay."}},{text:" "},{text:"[Leave the table]",color:"gray",bold:true,click_event:{action:"run_command",command:"/trigger euchre.act set 31"},hover_event:{action:"show_text",value:"Stand up without staking anything."}}]
