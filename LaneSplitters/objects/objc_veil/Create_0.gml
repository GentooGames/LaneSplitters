
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  __   __ ______   __   __        //
	// /\ \ / //\  ___\ /\ \ /\ \       //
	// \ \ \'/ \ \  __\ \ \ \\ \ \____  //
	//  \ \__|  \ \_____\\ \_\\ \_____\ //
	//   \/_/    \/_____/ \/_/ \/_____/ //
	//                                  //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	// objc_veil.create //
	event_inherited();
	
	var _self = self;
	
	// public
	open    = function() {
		__.radius_target = 1500;
		__.open			 = true;
		__.lerp_speed	 = __.open_speed;
		return self;
	};
	close   = function(_radius = 250) {
		__.radius_target = _radius;
		__.open			 = false;
		__.lerp_speed	 = __.close_speed;
		return self;
	};
	is_open = function() {
		return __.open;	
	};
	
	// private
	with (__) {
		open		  = false;
		open_speed	  = 0.1;
		close_speed	  = 0.2;
		lerp_speed	  = open_speed;
		surface		  = surface_create(SURF_W, SURF_H);
		radius		  = 250;
		radius_target = radius;
		control_type  = "wasd";
	};
	
	// events
	on_update	 (function() {
		depth = objc_menu.depth + 1;
		__.radius = lerp(__.radius, __.radius_target, __.lerp_speed);
		
		// change control type prompt
		if (keyboard_check_pressed(ord("W"))
		||	keyboard_check_pressed(ord("A"))
		||	keyboard_check_pressed(ord("S"))
		||	keyboard_check_pressed(ord("D"))
		||	keyboard_check_pressed(ord("J"))
		) {
			__.control_type = "wasd";
		}
		
		if (keyboard_check_pressed(vk_up)
		||	keyboard_check_pressed(vk_left)
		||	keyboard_check_pressed(vk_down)
		||	keyboard_check_pressed(vk_right)
		||	keyboard_check_pressed(ord("X"))
		) {
			__.control_type = "arrows";
		}
	});
	on_render_gui(function() {
		// black BG
		static _color = c_black;//#511e43//#100820;
		if (!surface_exists(__.surface)) {
			__.surface = surface_create(SURF_W, SURF_H);	
		}
		surface_set_target(__.surface);
		draw_rectangle_color(0, 0, SURF_W, SURF_H, _color, _color, _color, _color, false);
		
		////////////////////////////////
		
		if (objc_world.room_is_track()) {
		
			// draw info text
			draw_set_alpha(0.6);
		
			// track name
			var _scale  = 5;
			var _string = room_get_name(room);
			var _x		= SURF_W - ((string_width(_string) + 10) * _scale);
			var _y		= SURF_H * 0.05;
			draw_text_transformed(_x, _y, _string, _scale, _scale, 0);
			
			// high score
			var _text = string(objc_points.__.points_last) + " pts | best: " + string(objc_points.get_highscore()) + " pts";
			draw_text_transformed(SURF_W * 0.50, 20, _text, 1, 1, 0);
		
			// game name
			draw_text_transformed(20, 20, GAME_NAME, 0.5, 0.5, 0);
		
			// game version
			draw_text_transformed(20, 40, GAME_VERSION, 0.35, 0.35, 0);
		
			// controls
			if (__.control_type == "wasd") {
				var _controls = "Steer= A & D | Gas= W or J | Brake= Space";	
				//var _controls = "Gas= W or J | Brake= Space";	
			}
			else {
				var _controls = "Steer= < & > | Gas= ^ or X | Brake= Space";
				//var _controls = "Gas= ^ or X | Brake= Space";
			}
			draw_text_transformed(20, SURF_H - 40, _controls, 0.5, 0.5, 0);
		
			draw_set_alpha(1.0);
		
			// highlight car
			if (instance_exists(obj_car)) {
				gpu_set_blendmode(bm_subtract);
				draw_circle(
					objc_camera.x_world_to_gui(obj_car.x),
					objc_camera.y_world_to_gui(obj_car.y),
					__.radius,
					false
				);
				gpu_set_blendmode(bm_normal);
			}
		}
		
		////////////////////////////////
		
		surface_reset_target();
		draw_surface(__.surface, 0, 0);
	});
	on_room_start(function() {
		close();
	});
	