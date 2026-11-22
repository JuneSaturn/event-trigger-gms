/*=============================================================================================

	Event Trigger System (For GameMaker) v 1.0
	
	EVENT TRIGGER PARENT
	by June Saturn
	
	Used in: Born 2.0 & Loyal Wonder

=============================================================================================*/

{
/*---------------------------------------------------------------------------------------------

	*** HOW TO USE ***
	
	
	■ Event commands
	□ Write each command as a struct in the commands array.
	___________________________________________________
	
	dialogue OR dialog _ Displays text. Useful for character dialogue.
	{ cmd: "dialog", speaker: "name", effect: "rpg", spd: 1, text: "Text to display" }
	- effect: "rpg" reveals the text character by character. Any other value shows the full text at once.
	- NOTE: speaker and spd are not used yet. As a result, "rpg" text does not appear.
	- NOTE: The "text" and "txt" commands are not implemented yet.
	
	audio _ Plays a sound.
	{ cmd: "audio", sound_id: sound asset, priority: number, loops: "true" or "false" }
	- loops: Use a string, not a Boolean.
	
	sleep _ Waits before running the next command.
	{ cmd: "sleep", duration: number of frames }
	
	goto _ Moves to another room.
	{ cmd: "goto", room_id: room asset }
	- NOTE: Remaining commands do not carry over unless this instance is persistent.
	
	calc _ Performs a calculation.
	{ cmd: "calc", l_value: number, op: "+", r_value: number, assignee: initial value }
	- op: "+", "-", "*" (or "×"), "/" (or "÷"), "%" (or "mod")
	- l_value and r_value are evaluated when the commands array is created.
	- NOTE: The result is stored in the assignee field. The variable passed to it is not changed.
	
	
	
	
	■ Triggers
	□ Set the trigger in info.trigger.
	___________________________________________________
	
	- "npc" : Intended to trigger when the player presses OK while touching this object.
	  NOTE: Not implemented yet.
	- "touched" : Triggers when the player object touches this object.
	- "touched^object_name" : Intended to trigger when the named object touches this object.
	  NOTE: Not working yet. The player is checked instead.
	- "auto" : Triggers when the room starts.
	
	NOTE: The Step event currently runs commands even if the event has not been triggered.
	
	
---------------------------------------------------------------------------------------------*/
}

// Event constants.
#macro NONE        ["none", "ready", "empty", "vacant"]
#macro ENDED       ["end", "ended", "fin", "eventended", "event-ended", "evendend", "event-end"]

#macro DIALOGUE    ["dialogue", "dialog"]
#macro TEXT        ["text", "txt", "plaintext", "plain-text", "plaintxt", "plain-txt"]
#macro AUDIO       ["audio", "sound", "snd"]
#macro SHOWPICTURE ["showpicture", "show-picture", "showpic", "show-pic", "picture", "pic"]
#macro GOTO        ["goto", "go-to", "transfer"]

#macro IF          ["if"]
#macro ELSE        ["else"]
#macro ENDIF       ["endif", "ifend"]
#macro SLEEP       ["sleep", "wait"]
#macro CALC        ["calc", "cal", "calculate"]

#macro MONEY       ["money", "gold", "dollar"]

#macro GAMEOVER    ["gameover", "game-over"]
#macro GAMEEND     ["gameend", "game-end", "endgame", "end-game", "gamequit", "game-quit", "quitgame", "quit-game"]
#macro GAMERESTART ["gamerestart", "game-restart", "restartgame", "restart-game", "restart"]
#macro TOTITLE     ["totitle", "gototitle", "gobacktotitle", "backtotitle"]

// ---------------------------------------------------------------------------

// Common variables for event processing.
command_index = 0; 
opacity = 0;
current_command = NONE[0]; // none: The event has not been triggered.
blocking = false;
frame = 0.1;
start_frame = 0;
end_frame = 0;
asset_id = pointer_null;

// If, Else, End If
if_opened = 0;
if_length = 0;

// Dialogue, Plain Text, System Notification, System Message
speaker_name = "";
displayed_text = "";
text_count = 0;
text_speed = 0;

// Miscellaneous
player = oPlayer;

// ---------------------------------------------------------------------------

// Triggers the event.
function trigger_event() {
	// Set current_command to commands[0] (the first command).
	current_command = commands[0];
	
	// Reset command_index to 0 to start from the first command.
	command_index = 0;
	
	// Freeze entities that check global.entity_freeze, such as characters, NPCs, and enemies.
	global.entity_freeze = true;
}

// Ends the event.
function end_event() {
	// Set current_command to "end".
	current_command = "end";
	
	// Reset command_index to 0 in case the event is triggered again.
	command_index = 0;
	
	// Unfreeze entities that check global.entity_freeze.
	global.entity_freeze = false;
}

// Checks whether the current command matches any of the given names.
function current_command_is(const) {
	return array_contains(const, current_command);
}

// Returns true when the OK key (Space) is pressed.
function pressed_ok() {
	return keyboard_check_pressed(vk_space);
}




/*=============================================================================================

	This is the only section you need to edit.
	Write your commands as structs in the commands array,
	and configure the event in the info struct.
	(One struct per command in the commands array)

=============================================================================================*/

// Event commands, executed from top to bottom (from index 0 to the last index).
commands = [
	{ cmd: "sleep", duration: 30 },
	{ cmd: "dialog", speaker: "Player", effect: "rpg", spd: 1, text: "I'm here, come out!" },
	{ cmd: "audio", sound_id: sndDiscord, priority: 0, loops: true },
	{ cmd: "if", func: function() { return 5+5 == 10 } },
		{ cmd: "calc", l_value: global.potential, op: "+", r_value: 5, assignee: global.potential },
	{ cmd: "else" },
		{ cmd: "calc", l_value: global.potential, op: "-", r_value: 2, assignee: global.potential },
	{ cmd: "endif" },
	{ cmd: "money", op: "+", amount: 500 },
	{ cmd: "dialog", speaker: "Player", effect: "rpg", spd: 1, text: "Hello World." },
];

// Event info
info = {
	
	// Event name
	name: "",

	// Trigger condition
	trigger: "touched"
	
};

local_switch = {
	A: false,
	B: false,
	C: false,
	D: false
};