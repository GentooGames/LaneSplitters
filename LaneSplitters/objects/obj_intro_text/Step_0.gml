
	time--;
	
	if (alpha < 1) {
		alpha += 0.1;	
	}
	
	if (time <= 0) {
		room_goto_next();	
	}