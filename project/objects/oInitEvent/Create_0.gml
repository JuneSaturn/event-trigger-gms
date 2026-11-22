/*=============================================================================================

	Event Trigger System (For GameMaker) v 1.0
	
	EVENT STATUS INITIALIZATION OBJECT
	by June Saturn
	
	Used in: Born 2.0 & Loyal Wonder

=============================================================================================*/

global.event_status = {

	owner: pointer_null,
	current_command: "none",
		
};

global.potential = 0;

global.money = 0;

global.event_switches[1028] = [false];

global.entity_freeze = false;