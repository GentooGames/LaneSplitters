
	function draw_sprite_stacked(_x = x, _y = y, _spread = 1, _sign = 1, _angle_offset = 0, _draw_shadow = true) {
		
		// draw shadow
		if (_draw_shadow) {
			surface_set_target(objc_world.__.surface_shadows);
			for (var _i = 1, _len = image_number; _i < _len; _i++) {
				draw_sprite_ext(
					sprite_index,
					_i,
					_x + lengthdir_x(_i, objc_world.__.shadow_direction) * 2,
					_y + lengthdir_y(_i, objc_world.__.shadow_direction),
					image_xscale,
					image_yscale,
				   (image_angle + _angle_offset) * _sign,
					c_black,
					1,
				);
			};
			surface_reset_target();
		}
		
		// draw stack
		for (var _i = 1, _len = image_number; _i < _len; _i++) {
			draw_sprite_ext(
				sprite_index,
				_i,
				_x,
				_y - (_i * _spread),
				image_xscale,
				image_yscale,
			   (image_angle + _angle_offset) * _sign,
				image_blend,
				image_alpha,
			);
		};
	};
	
	
	