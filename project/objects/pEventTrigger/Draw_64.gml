if (current_command_is(DIALOGUE) or (previous_command_is(DIALOGUE) and current_command_is(CHOICE))) {
	
	draw_set_halign(global.event_drawing.horizontal_align);
	draw_set_valign(global.event_drawing.vertical_align);
	draw_set_font(fCalSans);
	draw_set_alpha(opacity);

	draw_text(
		36,
		window_get_height() - string_height(displayed_text) - 24,
		displayed_text
	);

	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_alpha(1);

}

else if (current_command_is(SHOWPICTURE)) {

	draw_sprite(commands[command_index].sprite, 0, commands[command_index].pos_x, commands[command_index].pos_y);
	
}

if (current_command_is(CHOICE)) {

	draw_set_halign(global.event_drawing.horizontal_align);
	draw_set_valign(global.event_drawing.vertical_align);
	draw_set_font(fCalSans);
	draw_set_alpha(1);

	for(var _i = array_length(commands[command_index].choices)-1; _i >= 0; _i--) {
		if (_i == choice_index) draw_set_color(c_blue);
		draw_text(
			36,
			window_get_height() - string_height(displayed_text) - 124 - (_i * (-32)),
			commands[command_index].choices[_i]
		);
		draw_set_color(c_white);
	}
}

draw_set_font(fArial);
draw_text(20, 20, "command type: " + string(current_command));
draw_text(20, 40, "command index: " + string(command_index));
draw_text(20, 60, "entity freeze: " + string(global.entity_freeze));
draw_text(20, 80, "global potention: " + string(global.potential));
draw_text(20, 100, "choice index: " + string(choice_index));