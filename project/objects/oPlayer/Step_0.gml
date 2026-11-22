if (!global.entity_freeze) {

	if (keyboard_check(vk_up)) {
		y -= move_speed * (!place_meeting(x, y - move_speed, oCollider));
		is_moving = true;
		sprite_index = sChar_Esiankiki_WalkUp;
		direction = UP;
	}
	if (keyboard_check(vk_left)) {
		x -= move_speed * (!place_meeting(x - move_speed, y, oCollider));
		is_moving = true;
		sprite_index = sChar_Esiankiki_WalkLeft;
		direction = LEFT;
	}
	if (keyboard_check(vk_down)) {
		y += move_speed * (!place_meeting(x, y + move_speed, oCollider));
		is_moving = true;
		sprite_index = sChar_Esiankiki_WalkDown;
		direction = DOWN;
	}
	if (keyboard_check(vk_right)) {
		x += move_speed * (!place_meeting(x + move_speed, y, oCollider));
		is_moving = true;
		sprite_index = sChar_Esiankiki_WalkRight;
		direction = RIGHT;
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