// obj_conveyor_belt.create //
event_inherited();

mover = new ibMoveControllerPlatformer({
	input_enabled:				 false,
	gravity_enabled:			 false,
	velocity_x_enabled:			 false,
	velocity_y_enabled:			 false,
	velocity_x:					 move_speed * dir,
	friction:					 0,
	slope_rotate_sprite_enabled: false,
});
mover.create();

on_cleanup(function() {
	mover.cleanup();
});