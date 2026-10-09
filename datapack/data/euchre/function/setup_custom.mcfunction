# Create a table with a chosen wager and target.
#   /function euchre:setup_custom {wager:10,target:5}
# Both keys are required: a macro call with a missing key fails before any line
# runs. Non-integers fail too, because `scoreboard players set` only accepts
# integers, so nothing below sees a malformed value.
$scoreboard players set #w euchre.tmp $(wager)
$scoreboard players set #t euchre.tmp $(target)
execute store result score #sd euchre.tmp run data get storage euchre:defaults setup.stick_dealer
execute store result score #gr euchre.tmp run data get storage euchre:defaults setup.grace_s
return run function euchre:table/setup/begin
