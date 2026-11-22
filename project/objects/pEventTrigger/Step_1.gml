var _trigger = string_split(info.trigger, "^");

if (_trigger[0] == "touched" and current_command_is(NONE)) {
	if (array_length(_trigger) > 2) {
		if (place_meeting(x, y, _trigger[1])) {
			trigger_event();
		}
	}
	else if (place_meeting(x, y, player)) {
		trigger_event();
	}
}

// Intended to prevent the event from retriggering endlessly while contact continues after it ends.
if (current_command_is(ENDED)) {
	if (array_length(_trigger) > 2) {
		// When the event is triggered by another object touching this object
		if (!place_meeting(x, y, _trigger[1])) {
			// Reset the current command to NONE.
			// This is needed because contact cannot trigger the event while it is in the ENDED state.
			current_command = "none";
		}
	}
	// When the event is triggered by the player object touching this object
	else if (!place_meeting(x, y, player)) {
		// Reset the current command to NONE for the same reason as above.
		current_command = "none";
	}
}