	
	if (destroy) {
		surface_set_target(objc_world.__.surface_tracks);
		draw_self();
		surface_reset_target();
		instance_destroy();
	}
	else {
		draw_self();
	}	
	