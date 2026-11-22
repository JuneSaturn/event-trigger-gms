var _trigger = string_split(info.trigger, "^");
var _target = (array_length(_trigger) >= 2) ? asset_get_index(_trigger[1]) : player;
var _m = 5; // This must be greater than the player's move_speed
var _touching = collision_rectangle(bbox_left - _m, bbox_top - _m, bbox_right + _m, bbox_bottom + _m, _target, false, true) != noone;

// Prevents the event from retriggering endlessly if the target is still touching this object after the event ends.
if (_trigger[0] == "touched" and current_command_is(NONE) and _touching) {
	trigger_event();
}
// Allow the event to trigger again once the target is no longer touching this object.
else if (current_command_is(ENDED) and !_touching) {
	// Reset the current command to NONE.
	current_command = "none";
}