/*=============================================================================================

	Event Trigger System (For GameMaker) v 1.0
	
	EVENT STATUS INITIALIZATION OBJECT
	by June Saturn
	
	Used in: Born 2.0 & Loyal Wonder

=============================================================================================*/

#macro RIGHT 0
#macro UP    90
#macro LEFT  180
#macro DOWN  270

global.event_status = {

	owner: pointer_null,
	current_command: "none",
		
};

global.event_drawing = {
	
	horizontal_align: fa_left,
	vertical_align: fa_top,
	
};

global.potential = 0;
global.money = 0;

global.event_switches[1028] = [false];

global.entity_freeze = false;

global.settings = {
	
	allow_skip_text_effect: true
	
}