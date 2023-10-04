
	alpha -= decay;
	
	if (alpha <= 0) {
		instance_destroy();	
	}
	
	y_lerp = lerp(y_lerp, y_start - y_offset, 0.1);
	