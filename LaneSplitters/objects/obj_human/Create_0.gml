
	depth		 = -y;
	sprite_index =  choose(
		spr_human_1,
		spr_human_2,
		spr_human_3,
		spr_human_4,
		spr_human_5,
	);
	
	move_activity = irandom_range(50, 200);
	move_speed	  = random_range(0.1, 0.4);
	x_amount	  = 0;
	y_amount	  = 0;
	x_target	  = x;
	y_target	  = y;
	
	image_angle	  = irandom(360);
	turn_activity = irandom_range(100, 300);
	turn_speed	  = random_range(0.1, 0.4);
	turn_target	  = image_angle;
	
	explode = function(_car) {
		
		// core blood stain
		var _core = instance_create_depth(x, y, depth - 1, obj_blood);	
			_core.image_xscale = 1.5;
			_core.image_yscale = 1.5;
			_core.velocity_x   = 0;
			_core.velocity_y   = 0;
			
		// blood splatter
		repeat(irandom_range(10, 75)) {
			var _r = 4;
			var _x = x + random_range(-_r, _r);
			var _y = y + random_range(-_r, _r);
			instance_create_depth(_x, _y, depth - 1, obj_blood);	
		}
		
		// sfx
		var _sfx_death = choose(sfx_death_1, sfx_death_2, sfx_death_3);
		_car.audio_play(_sfx_death);
		_car.audio_play(sfx_impact_human, false, 0);
		
		instance_destroy();	
	};
		
	