if (!global.entity_freeze) {

	if (keyboard_check(vk_up)) {
		y -= move_speed * (!place_meeting(x, y - move_speed, oBlock));
		is_moving = true;
		sprite_index = sChar_Esiankiki_WalkUp;
	}
	if (keyboard_check(vk_left)) {
		x -= move_speed * (!place_meeting(x - move_speed, y, oBlock));
		is_moving = true;
		sprite_index = sChar_Esiankiki_WalkLeft;
	}
	if (keyboard_check(vk_down)) {
		y += move_speed * (!place_meeting(x, y + move_speed, oBlock));
		is_moving = true;
		sprite_index = sChar_Esiankiki_WalkDown;
	}
	if (keyboard_check(vk_right)) {
		x += move_speed * (!place_meeting(x + move_speed, y, oBlock));
		is_moving = true;
		sprite_index = sChar_Esiankiki_WalkRight;
	}
	
	if (!keyboard_check(vk_up) and !keyboard_check(vk_left) and !keyboard_check(vk_down) and !keyboard_check(vk_right)) {
		is_moving = false;
	}
	
}
else {
	is_moving = false;
}



if (is_moving) {
	image_speed = 0.5;
}
else {
	image_speed = 0;
	image_index = 0;
}