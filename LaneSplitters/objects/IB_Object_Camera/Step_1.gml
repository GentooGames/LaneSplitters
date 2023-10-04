	
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   ______   __    __   ______   ______   ______    //
	// /\  ___\ /\  __ \ /\ "-./  \ /\  ___\ /\  == \ /\  __ \   //
	// \ \ \____\ \  __ \\ \ \-./\ \\ \  __\ \ \  __< \ \  __ \  //
	//  \ \_____\\ \_\ \_\\ \_\ \ \_\\ \_____\\ \_\ \_\\ \_\ \_\ //
	//   \/_____/ \/_/\/_/ \/_/  \/_/ \/_____/ \/_/ /_/ \/_/\/_/ //
	//                                                           //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	// obj_camera.begin_step //
	event_inherited();

	/*
	_update_edges();
	_update_depth();
	audio_listener_position(x, y, 0);

	// Detach Mouse Input From Iota
	if (sys_input.mouse.button(mb_middle))			middle_mouse_down		= true;
	if (sys_input.mouse.button_pressed(mb_middle))	middle_mouse_pressed	= true;
	if (sys_input.mouse.button_released(mb_middle))	middle_mouse_released	= true;
	if (sys_input.mouse.wheel_down())				middle_mouse_wheel_down = true;
	if (sys_input.mouse.wheel_up())					middle_mouse_wheel_up	= true;
	