
	time  = 0;
	text  = "";
	scale = 0.5;
	alpha = 0;
	
	if (room == __rm_created_by) {
		text  = "created by\n@gentoogames";
		time  = CREATED_BY_TIME;
		scale = 0.5;
	}
	else if (room == __rm_headphones) {
		text  = "turn on some music!";
		time  = MUSIC_TIME;
		scale = 0.5;
	}
	
	