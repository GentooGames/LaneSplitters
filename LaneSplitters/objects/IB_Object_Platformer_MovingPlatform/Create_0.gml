// obj_moving_platform.create //
event_inherited();

// variable definitions //
// ~~~~~~~~~~~~~~~~~~~~ //
// horizontal = true;
// velocity   = 1;

name  = "platform";
mover = new ibMoveControllerPlatformer({
	state:						"platform",
	input_enabled:			    false,	
	gravity_enabled:		    false,
	slope_enabled:			    false,
	velocity_x:				    velocity *  horizontal,
	velocity_y:				    velocity * !horizontal,
	friction:					0,
	collision_bounce_x_enabled: true,
	collision_bounce_y_enabled: true,
});
mover.create();

on_cleanup(function() {
	mover.cleanup();
});