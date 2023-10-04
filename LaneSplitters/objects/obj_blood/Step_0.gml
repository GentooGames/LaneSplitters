
	if (destroy) exit;

	velocity_y += grav;
	y += velocity_y;
	x += velocity_x;
	
	if (y >= ystart) {
		destroy = true;	
	}
	
	depth = -y;