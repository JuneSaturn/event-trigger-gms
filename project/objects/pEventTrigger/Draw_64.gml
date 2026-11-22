if (current_command_is(DIALOGUE)) {
	
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
		
	draw_set_halign(fa_center);
	draw_set_font(fSerif);

	draw_set_alpha(opacity);

	draw_text(427, 440, displayed_text);

	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_alpha(1);

}

else if (current_command_is(SHOWPICTURE)) {

	draw_sprite(commands[command_index].sprite, 0, commands[command_index].pos_x, commands[command_index].pos_y);
	
}

draw_text(20, 20, "command type: " + string(current_command));
draw_text(20, 60, "command index: " + string(command_index));
draw_text(20, 100, "entity freeze: " + string(global.entity_freeze));
draw_text(20, 140, "global potention: " + string(global.potential));