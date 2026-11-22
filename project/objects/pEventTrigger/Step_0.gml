if (current_command_is(NONE) or current_command_is(ENDED)) {
	exit;
}

// End the event if command_index is out of range.
if (command_index >= array_length(commands)) {
	end_event();
}
else {
	current_command = commands[command_index].cmd;
}




/*=============================================================================================

	This is the core of the scene event object.
	Most of the event control system is implemented here.

=============================================================================================*/
if (!current_command_is(NONE)) {
	
	// DIALOGUE
	// ---------------------------------------------------------------------------
	if (current_command_is(DIALOGUE)) {
		// The DIALOGUE command blocks until OK is pressed.
		blocking = true;
		
		// Display the text according to the effect.
		if (commands[command_index].effect == "rpg") {
			opacity = 1;
			if (text_count < string_length(commands[command_index].text)) {
			    text_count += commands[command_index].spd;
			    displayed_text = string_copy(commands[command_index].text, 1, floor(text_count));
			}
		}
		else {
			// Set the full text in advance.
			displayed_text = commands[command_index].text;
		
			// Increase opacity to make the text appear.
			if (opacity < 1) {
				var _frame = 10;
				if (_frame =! -1) opacity += _frame;
				else opacity += 0.1;
			}
		}
	
		// When OK is pressed
		if (pressed_ok()) {
			speaker_name = "";
			displayed_text = "";
			text_count = 0;
			text_speed = 0;
			
			// End the event if this is the last command.
			if (command_index >= array_length(commands)-1) {
				command_index++;
				end_event();
			}
			else {
				// Go on to the next command.
				command_index++;
				
				// Reset opacity so that the next appearance effect can play.
				opacity = 0;
			}
		}
	}
	
	
	// AUDIO
	// ---------------------------------------------------------------------------
	else if (current_command_is(AUDIO)) {
		// The AUDIO command must not block.
		blocking = false;
		
		// Get the sound's ID, priority, and loop option.
		var _sound_id = commands[command_index].sound_id;
		var _sound_priority = commands[command_index].priority;
		var _sound_loops = commands[command_index].loops;
		
		// Convert _sound_priority to a number, and _sound_loops to a Boolean (string "true" means loop).
		// real() throws an error if the string is not a valid number.
		_sound_priority = real(_sound_priority);
		_sound_loops = (_sound_loops == "true");
		
		// Error handling: Show a message if the sound ID or priority is -1.
		if (_sound_id != -1) {
			if (_sound_priority != -1) {
				if (_sound_loops == -1) {
					// Fallback to no looping. NOTE: Never reached, as _sound_loops is already a Boolean here.
					_sound_loops = false;
				}
				audio_play_sound(_sound_id, _sound_priority, _sound_loops);
			}
			else show_message("Invalid sound priority: "+string(_sound_priority));
		}
		else show_message("Cannot find sound: "+string(_sound_id));
	
		// Go on to the next command.
		command_index++;
	}
	
	
	// SHOWPICTURE
	// ---------------------------------------------------------------------------
	else if (current_command_is(SHOWPICTURE)) {
		blocking = commands[command_index].blocking;
	}
	
	
	// GOTO
	// ---------------------------------------------------------------------------
	else if (current_command_is(GOTO)) {
		// The GOTO command works the same whether blocking is true or false.
		blocking = false;
		
		// Get the room ID.
		var _room_id = commands[command_index].room_id;
		
		// Error handling: Show a message if the room ID is -1.
		if (_room_id != -1) {
		
			// Advance to the next command before moving. NOTE: It only carries over if this instance is persistent.
			command_index++;
			
			room_goto(_room_id);
		}
		else show_message("Cannot find room	: "+string(_room_id));
	}
	
	
	// IF
	// ---------------------------------------------------------------------------
	else if (current_command_is(IF)) {
		if_opened++;
		
		for(var _i = 0; _i <= (array_length(commands)-command_index-1); _i++) {
			if (commands[command_index + _i].cmd == ENDIF) {
				if_length = _i;
				break;
			}
		}
		
		// Go on to the next command.
		command_index++;
	}
	
	// ELSE
	// ---------------------------------------------------------------------------
	else if (current_command_is(ELSE)) {
		if (if_opened >= 1) {
			if_opened--;
		}
		
		// Go on to the next command.
		command_index++;
	}
	
	
	// ENDIF
	// ---------------------------------------------------------------------------
	else if (current_command_is(ENDIF)) {
		if (if_opened >= 1) {
			if_opened--;
		}
		
		// Go on to the next command.
		command_index++;
	}
	
	
	// SLEEP
	// ---------------------------------------------------------------------------
	else if (current_command_is(SLEEP)) {
		// The SLEEP command blocks until the duration has passed.
		blocking = true;
		
		end_frame = commands[command_index].duration;
		
		if (start_frame >= end_frame) {
			// Go on to the next command.
			command_index++;
			
			// Reset start_frame and end_frame.
			start_frame = 0;
			end_frame = 0;
		}
		else {
			start_frame++;
		}
	}
	
	
	// CODE
	// ---------------------------------------------------------------------------
	else if (current_command_is(CODE)) {
		// The CODE command works the same whether blocking is true or false.
		blocking = false;
		
		var _func  = commands[command_index].func;
		var _bound_func = method(id, _func);
		_bound_func();
		
		// Go on to the next command.
		command_index++;
	}
	
	
	// CHOICE
	// ---------------------------------------------------------------------------
	else if (current_command_is(CHOICE)) {
		// The CHOICE command blocks until the selection is made.
		blocking = true;
		
		// Move the selection.
		if (pressed_up()) {
			if (choice_index > 0) choice_index--;
		}
		else if (pressed_down()) {
			if (choice_index < array_length(commands[command_index].choices)-1) choice_index++;
		}
		
		// When OK is pressed
		if (pressed_ok()) {
			// Go on to the next command.
			command_index++;
			
			// Reset choice_index.
			choice_index = 0;
		}
	}
	
	
	// MONEY
	// ---------------------------------------------------------------------------
	else if (current_command_is(MONEY)) {
		// The MONEY command works the same whether blocking is true or false.
		blocking = false;
		
		var _amount = commands[command_index].amount;
		
		switch(commands[command_index].op) {
			case "+": case "plus": case "add":
				global.money += _amount;
			break;
			case "-": case "minus": case "subtract":
				global.money -= _amount;
			break;
			case "=": case "equals":
				global.money = _amount;
			break;
		}
		
		// Go on to the next command.
		command_index++;
	}
		
		
	// GAMEEND
	// ---------------------------------------------------------------------------
	else if (current_command_is(GAMEEND)) {
		// The GAMEEND command works the same whether blocking is true or false.
		blocking = false;
		
		game_end();
	}
	
	
	// GAMERESTART
	// ---------------------------------------------------------------------------
	else if (current_command_is(GAMERESTART)) {
		// The GAMERESTART command works the same whether blocking is true or false.
		blocking = false;
		
		game_restart();
	}
	
	
	// TOTITLE
	// ---------------------------------------------------------------------------
	else if (current_command_is(TOTITLE)) {
		// The TOTITLE command works the same whether blocking is true or false.
		blocking = false;
		
		audio_pause_all();
		room_goto(rTitle);
	}
	
	// When no handler matches the current command
	else {
	}

	// Keep current_command in sync with command_index before Draw GUI runs.
	if (!current_command_is(ENDED)) {
		if (command_index >= array_length(commands)) {
			end_event();
		}
		else current_command = commands[command_index].cmd;
	}

}