# Create a free-play table, first to 5 points.
# Stand on the centre of the tabletop, with 4 cushions placed around the table.
# For other settings: /function euchre:setup_custom {wager:10,target:5}
execute store result score #w euchre.tmp run data get storage euchre:defaults setup.wager
execute store result score #t euchre.tmp run data get storage euchre:defaults setup.target
execute store result score #sd euchre.tmp run data get storage euchre:defaults setup.stick_dealer
execute store result score #gr euchre.tmp run data get storage euchre:defaults setup.grace_s
return run function euchre:table/setup/begin
