
	depth = -y;
	
	if (iceberg.time.do_every_frame(move_activity)) {
		x_amount += random_range(-1, 1);
		y_amount += random_range(-1, 1);
		x_target  = xstart + x_amount;
		y_target  = ystart + y_amount;
	}
	if (iceberg.time.do_every_frame(turn_activity)) {
		turn_target = irandom(360);	
	}
	
	phy_position_x = lerp(phy_position_x, x_target, move_speed);
	phy_position_y = lerp(phy_position_y, y_target, move_speed);
	phy_rotation   = iceberg.tween.lerp_angle(
		phy_rotation, 
		turn_target, 
		turn_speed,
	);
	