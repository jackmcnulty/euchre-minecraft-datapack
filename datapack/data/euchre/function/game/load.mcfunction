# Load table $(tid)'s game state into the working copy euchre:tmp game.
$data modify storage euchre:tmp game set from storage euchre:tables list[{id:$(tid)}].game
