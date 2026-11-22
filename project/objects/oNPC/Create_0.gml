// Inherit the parent event
event_inherited();

// Default direction
direction = 270;

// Event info
info = {
	
	// Event name
	name: "NPC",

	// Trigger condition
	trigger: "touched",
	
	// If true, the target must be facing this object to trigger the event.
	requires_facing: true
	
};

// Event commands, executed from top to bottom (from index 0 to the last index).
commands = [
	{ cmd: "sleep", duration: 30 },
	{ cmd: "dialog", speaker: "Player", effect: "rpg", spd: 1, text: "I'm here, come out!" },
	{ cmd: "choice", choices: ["Yes", "No"] },
		{ cmd: "case", index: 0 },
			{ cmd: "dialog", effect: "rpg", spd: 1, text: "You selected Yes." },
		{ cmd: "endcase" },
		{ cmd: "case", index: 1 },
			{ cmd: "dialog", effect: "rpg", spd: 1, text: "You selected No." },
		{ cmd: "endcase" },
	{ cmd: "audio", sound_id: sndSodaGum, priority: 0, loops: true },
	{ cmd: "if", func: function() { return 5+5 == 10 } },
		{ cmd: "code", func: function() { global.potential += 5; } },
	{ cmd: "else" },
	{ cmd: "endif" },
	{ cmd: "money", op: "+", amount: 500 },
	{ cmd: "dialog", speaker: "Player", effect: "rpg", spd: 1, text: "Hello World." },
];