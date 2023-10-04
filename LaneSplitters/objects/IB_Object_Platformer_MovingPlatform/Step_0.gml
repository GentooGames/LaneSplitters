// obj_moving_platform.step //
event_inherited();
mover.step();

if (keyboard_check_pressed(vk_tab)) {
	horizontal = !horizontal;	
	mover.velocity_x_set(velocity *  horizontal);
	mover.velocity_y_set(velocity * !horizontal);
}