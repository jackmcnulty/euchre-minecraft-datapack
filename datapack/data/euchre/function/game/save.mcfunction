# Store the working copy euchre:tmp game as table $(tid)'s game state.
$data modify storage euchre:tables list[{id:$(tid)}].game set from storage euchre:tmp game
