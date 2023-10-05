
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   ______   ______    // 
	// /\  ___\ /\  __ \ /\  == \   // 
	// \ \ \____\ \  __ \\ \  __<   // 
	//  \ \_____\\ \_\ \_\\ \_\ \_\ // 
	//   \/_____/ \/_/\/_/ \/_/ /_/ // 
	//                              //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	// obj_car.create //
	event_inherited();	
	var _self = self;
	var _data = self[$ "data"] ?? self;

	#region owner/player

		// public
		player_get	  = function() {
			return __.player.instance;	
		};
		player_set	  = function(_player) {
			
			__.player.instance = _player;
			__.input.enabled   = __.input.start_enabled();
			
			var _port_index = _player != undefined ? _player.input_get_port_index() : -1;
			__.log("set player: " + string(_port_index), IB_LOG_FLAG.CHARACTER);
			
			return self;
		};
		player_exists = function() {
			return __.player.instance != undefined;	
		};
		player_remove = function() {
			player_set(undefined);
			return self;
		};

		// private
		__[$ "player"] ??= {};
		with (__.player) {
			instance = _self[$ "player"] ?? undefined;
		};
			
		// events
		on_initialize(function() {
			objc_game.player_get(0).character_assign(self);
			instance_create_depth(x, y, depth - 1, obj_camera_focus);
			objc_camera.focus_set_target(obj_camera_focus);
		});
		
	#endregion
	#region input

		// input:general
		input_activate					    = function(_active = true) {
			if (_active) {
				__.input.enabled = true;	
				__.log("activated input", IB_LOG_FLAG.CHARACTER);
			}
			else input_deactivate();
			return self;
		};
		input_check						    = function() {
			return (input_is_enabled()
				&&	input_lock_is_unlocked()
			);
		};
		input_deactivate				    = function() {
			__.input.enabled = false;
			__.log("deactivated input", IB_LOG_FLAG.CHARACTER);
			return self;
		};
		input_get_enabled				    = function() {
			return __.input.enabled;	
		};
		input_is_enabled				    = function() {
			return __.input.enabled;	
		};
	
		// input:vector general
		input_vector_get				    = function() {
			return __.input.vector;	
		};
		input_vector_get_direction		    = function() {
			var _vector = input_vector_get();
			if (_vector.has_magnitude()) {
				return _vector.get_direction();
			}
			return __.input.dir_last;
		};
		input_vector_get_direction_inverted	= function() {
			return input_vector_get_direction() + 180;
		};
		input_vector_get_magnitude			= function() {
			return __.input.vector.get_direction();	
		};
		input_vector_set_direction			= function(_direction) {
			__.input.vector.set_direction(_direction);
			return self;
		};
		input_vector_set_magnitude			= function(_magnitude) {
			__.input.vector.set_magnitude(_magnitude);
			return self;
		};
								
		// input:lock
		input_lock_set					    = function(_lock_name, _lock_time = -1) {
			__.input.lock.set_lock(_lock_name, _lock_time);
			__.log("input lock set: " + _lock_name, IB_LOG_FLAG.CHARACTER);
			return self;
		};
		input_lock_remove				    = function(_lock_name) {
			__.input.lock.remove_lock(_lock_name);
			__.log("input lock remove: " + _lock_name, IB_LOG_FLAG.CHARACTER);
			return self;
		};
		input_lock_is_locked			    = function() {
			return __.input.lock.is_locked();
		};
		input_lock_is_unlocked			    = function() {
			return __.input.lock.is_unlocked();
		};
		input_lock_vector_set			    = function(_lock_name, _lock_time = -1) {
			__.input.vector_lock.set_lock(_lock_name, _lock_time);
			__.log("vector_input lock set: " + _lock_name, IB_LOG_FLAG.CHARACTER);
			return self;
		};
		input_lock_vector_remove		    = function(_lock_name) {
			__.input.vector_lock.remove_lock(_lock_name);
			__.log("vector_input lock remove: " + _lock_name, IB_LOG_FLAG.CHARACTER);
			return self;
		};
		input_lock_vector_is_locked		    = function() {
			return __.input.vector_lock.is_locked();
		};
		input_lock_vector_is_unlocked	    = function() {
			return __.input.vector_lock.is_unlocked();
		};
			
		// input:check
		input_left_pressed				    = function() {
			return (__.player.instance != undefined
				&&	__.player.instance.input_left_pressed(input_check())
			);
		};
		input_left_down					    = function() {
			return (__.player.instance != undefined
				&&	__.player.instance.input_left_down(input_check())
			);
		};
		input_left_released				    = function() {
			return (__.player.instance != undefined
				&&	__.player.instance.input_left_released(input_check())
			);
		};
		input_right_pressed				    = function() {
			return (__.player.instance != undefined
				&&	__.player.instance.input_right_pressed(input_check())
			);
		};
		input_right_down				    = function() {
			return (__.player.instance != undefined
				&&	__.player.instance.input_right_down(input_check())
			);
		};
		input_right_released			    = function() {
			return (__.player.instance != undefined
				&&	__.player.instance.input_right_released(input_check())
			);
		};
		input_up_pressed				    = function() {
			return (__.player.instance != undefined
				&&	__.player.instance.input_up_pressed(input_check())
			);
		};
		input_up_down					    = function() {
			return (__.player.instance != undefined
				&&	__.player.instance.input_up_down(input_check())
			);
		};
		input_up_released				    = function() {
			return (__.player.instance != undefined
				&&	__.player.instance.input_up_released(input_check())
			);
		};
		input_down_pressed				    = function() {
			return (__.player.instance != undefined
				&&	__.player.instance.input_down_pressed(input_check())
			);
		};
		input_down_down					    = function() {
			return (__.player.instance != undefined
				&&	__.player.instance.input_down_down(input_check())
			);
		};
		input_down_released				    = function() {
			return (__.player.instance != undefined
				&&	__.player.instance.input_down_released(input_check())
			);
		};
		input_select_pressed			    = function() {
			return (__.player.instance != undefined
				&&	__.player.instance.input_select_pressed(input_check())
			);
		};
		input_select_down				    = function() {
			return (__.player.instance != undefined
				&&	__.player.instance.input_select_down(input_check())
			);
		};
		input_select_released			    = function() {
			return (__.player.instance != undefined
				&&	__.player.instance.input_select_released(input_check())
			);
		};
		input_back_pressed				    = function() {
			return (__.player.instance != undefined
				&&	__.player.instance.input_back_pressed(input_check())
			);
		};
		input_back_down					    = function() {
			return (__.player.instance != undefined
				&&	__.player.instance.input_back_down(input_check())
			);
		};
		input_back_released				    = function() {
			return (__.player.instance != undefined
				&&	__.player.instance.input_back_released(input_check())
			);
		};
		input_start_pressed				    = function() {
			return (__.player.instance != undefined
				&&	__.player.instance.input_start_pressed(input_check())
			);
		};
		input_start_down				    = function() {
			return (__.player.instance != undefined
				&&	__.player.instance.input_start_down(input_check())
			);
		};
		input_start_released			    = function() {
			return (__.player.instance != undefined
				&&	__.player.instance.input_start_released(input_check())
			);
		};
		input_options_pressed			    = function() {
			return (__.player.instance != undefined
				&&	__.player.instance.input_options_pressed(input_check())
			);
		};
		input_options_down				    = function() {
			return (__.player.instance != undefined
				&&	__.player.instance.input_options_down(input_check())
			);
		};
		input_options_released			    = function() {
			return (__.player.instance != undefined
				&&	__.player.instance.input_options_released(input_check())
			);
		};
		input_next_pressed				    = function() {
			return (__.player.instance != undefined
				&&	__.player.instance.input_next_pressed(input_check())
			);
		};
		input_next_down					    = function() {
			return (__.player.instance != undefined
				&&	__.player.instance.input_next_down(input_check())
			);
		};
		input_next_released				    = function() {
			return (__.player.instance != undefined
				&&	__.player.instance.input_next_released(input_check())
			);
		};
		input_previous_pressed			    = function() {
			return (__.player.instance != undefined
				&&	__.player.instance.input_previous_pressed(input_check())
			);
		};
		input_previous_down				    = function() {
			return (__.player.instance != undefined
				&&	__.player.instance.input_previous_down(input_check())
			);
		};
		input_previous_released			    = function() {
			return (__.player.instance != undefined
				&&	__.player.instance.input_previous_released(input_check())
			);
		};
			
		input_gas_pressed					= function() {
			return (__.player.instance != undefined
				&&	__.player.instance.input_gas_pressed(input_check())
			);
		};
		input_gas_down						= function() {
			return (__.player.instance != undefined
				&&	__.player.instance.input_gas_down(input_check())
			);
		};
		input_gas_released					= function() {
			return (__.player.instance != undefined
				&&	__.player.instance.input_gas_released(input_check())
			);
		};
		input_hand_brake_pressed			= function() {
			return (__.player.instance != undefined
				&&	__.player.instance.input_hand_brake_pressed(input_check())
			);
		};
		input_hand_brake_down				= function() {
			return (__.player.instance != undefined
				&&	__.player.instance.input_hand_brake_down(input_check())
			);
		};
		input_hand_brake_released			= function() {
			return (__.player.instance != undefined
				&&	__.player.instance.input_hand_brake_released(input_check())
			);
		};
			
		// private
		__[$ "input"] ??= {};
		with (__.input) {
			start_enabled		= method(_self, function() {
				return (player_get() != undefined
					&&  player_get().input_has_devices()
				);
			});
			check_vector_update	= method(_self, function() {
				return (input_check() // check superset
					&&	input_lock_vector_is_unlocked()
				);
			});
			update_vector		= method(_self, function() {
				if (__.input.check_vector_update()) {
					__.input.vector.x = input_right_down() - input_left_down();
					__.input.vector.y = input_down_down () - input_up_down();
				}
			});
				
			enabled		= start_enabled();
			lock		= new IB_LockStack();
			vector_lock	= new IB_LockStack();
			vector		= new XD_Vector2();
			dir_last	= 90;
		};
		
		// events
		on_initialize(function() {
			__.input.lock.initialize();
			__.input.vector_lock.initialize();
		});
		on_update	 (function() {
			__.input.lock.update(); 
			__.input.vector_lock.update();
			if (__.input.vector.has_magnitude()) {
				__.input.dir_last = input_vector_get_direction();
			}
		});
		on_cleanup	 (function() {
			__.input.lock.cleanup();
			__.input.vector_lock.cleanup();
		});

	#endregion
	#region state
	
		// public
		state_get		   = function() {
			return __.state.fsm.get_current_state();	
		};
		state_get_current  = function() {
			return __.state.fsm.get_current_state();	
		};
		state_get_previous = function() {
			return __.state.fsm.get_previous_state();
		};
		state_is		   = function(_state) {
			return __.state.fsm.state_is(_state);	
		};
			
		// private
		__[$ "state"] ??= {};
		with (__.state) {
			fsm	= new SnowState("drive", false, { 
				owner: _self,
			});
			fsm.history_enable();
			fsm.history_set_max_size(1);
			
			// states
			fsm.add("__", car_state_base());
				fsm.add_child("__", "drive", car_state_drive());
				fsm.add_child("__", "drift", car_state_drift());
					
			// triggers
			fsm.add_transition("t_drift", "drive", "drift",	method(_self, car_state_trigger_drift));
			fsm.add_transition("t_drive", "drift", "drive",	method(_self, car_state_trigger_drive));
					
			// hooks
			fsm.on("state changed", method(_self, function(_data) {
				var _state_to_name = _data;
				// ...
			}));
		};
		
		// events
		on_initialize(function() {
			__.state.fsm.change("drive");
		});
		on_update	 (function() {
			__.state.fsm.step();
		});
		on_render	 (function() {
			__.state.fsm.draw();
		});

	#endregion
	#region audio
	
		// public 
		audio_play = function(_sfx_id, _loops = false, _priority = 1, _mod = true) {
			var _pitch = _mod ? random_range(0.9, 1.1) : 1.0;
			audio_emitter_pitch(__.audio.emitter, _pitch);
			var _audio = audio_play_sound_on(__.audio.emitter, _sfx_id, _loops, _priority);
			return _audio;
		};
	
		// private
		__[$ "audio"] ??= {};
		with (__.audio) {
			engine_play_sfx	   = method(_self, function() {
				var _velocity = __.movement.velocity_vector.get_magnitude();
				var _pitch	  = iceberg.math.remap(0, __.movement.max_speed, 1.0, 5.0, _velocity);
				var _gain	  = is_drifting() ? 0.4 : 0.8;
				var _scalar   = (objc_time.get_state() == "round" || objc_time.get_state() == "countdown") ? 1 : 0.4;
				audio_emitter_pitch(__.audio.emitter_engine, _pitch);
				audio_emitter_gain (__.audio.emitter_engine, _gain * _scalar);	
			});
			drifting_play_sfx  = method(_self, function() {
				if (is_drifting()) {
					var _pitch = random_range(0.8, 1.5);
					audio_emitter_pitch(__.audio.emitter_tires, _pitch);
					audio_play_sound_on(__.audio.emitter_tires, sfx_tires, false, -1);
				}	
			});
			emitter_update_pos = method(_self, function() {
				audio_emitter_position(__.audio.emitter,		phy_position_x, phy_position_y, 0);
				audio_emitter_position(__.audio.emitter_engine, phy_position_x, phy_position_y, 0);
				audio_emitter_position(__.audio.emitter_tires,  phy_position_x, phy_position_y, 0);
			});
			emitter_engine	   = audio_emitter_create();
			emitter_tires	   = audio_emitter_create();
			emitter			   = audio_emitter_create();	
		};
		
		// events
		on_initialize(function() {
			audio_play_sound_on(__.audio.emitter_engine, sfx_engine_loop, true, 0);
		});
		on_update	 (function() {
			__.audio.emitter_update_pos();
			__.audio.engine_play_sfx();
			__.audio.drifting_play_sfx();
		});
		on_cleanup	 (function() {
			audio_emitter_free(__.audio.emitter);
			audio_emitter_free(__.audio.emitter_engine);
			audio_emitter_free(__.audio.emitter_tires);
		});
	
	#endregion
	#region particles
	
		// public
		particles_create_exhaust = function() {
			
			static _time_min = 10;
			static _time_max = 1;
			var	   _interval = iceberg.math.remap(0, __.movement.max_speed, _time_min, _time_max, __.movement.velocity_vector.get_magnitude());
			
			if (iceberg.time.do_every_frame(_interval)) {
				var _tail_x = x - (__.movement.facing_vector.x * ((__.movement.wheel_base + 6) * 0.5));
				var _tail_y = y - (__.movement.facing_vector.y * ((__.movement.wheel_base + 6) * 0.5));
				var _rand_x = random_range(-2, 2);
				var _rand_y = random_range(-2, 2);
				instance_create_depth(_tail_x + _rand_x, _tail_y + _rand_y, depth + 1, obj_exhaust);
			}	
			
			return self;
		};
		particles_create_smoke	 = function() {
			if (__.movement.velocity_vector.has_magnitude()) {
				if (iceberg.time.do_every_frame(3)) {
					var _tail_x = x - (__.movement.facing_vector.x * ((__.movement.wheel_base + 6) * 0.5));
					var _tail_y = y - (__.movement.facing_vector.y * ((__.movement.wheel_base + 6) * 0.5));
					var _rand_x = random_range(-2, 2);
					var _rand_y = random_range(-2, 2);
					instance_create_depth(_tail_x + _rand_x, _tail_y + _rand_y, depth + 1, obj_smoke);
				}	
			}
			return self;
		};
		particles_create_tracks  = function() {
			
			static _axel_length = 4;
			static _track_alpha = 0.6;
			static _track_color = #511e43;
			static _track_size  = 2;
			
			if (__.movement.velocity_vector.has_magnitude()) {
				draw_set_alpha(_track_alpha);
				surface_set_target(objc_world.__.surface_tracks);
			
				// left tire (i think?)
				var _tire_left_x = movement_get_rear_left_wheel_x();
				var _tire_left_y = movement_get_rear_left_wheel_y();
				draw_circle_color(_tire_left_x, _tire_left_y, _track_size, _track_color, _track_color, false);
			
				// right tire
				var _tire_right_x = movement_get_rear_right_wheel_x();
				var _tire_right_y = movement_get_rear_right_wheel_y();
				draw_circle_color(_tire_right_x, _tire_right_y, _track_size, _track_color, _track_color, false);
			
				surface_reset_target();
				draw_set_alpha(1);
			}
				
			return self;
		};
		particles_create_impact  = function() {
			repeat (irandom(2)) { 
				instance_create_depth(x, y, depth - 1, obj_impact); 
			}
			return self;
		};
	
	#endregion
	#region physics
		
		phy_fixed_rotation = true;
		phy_rotation	   = image_angle;
		
	#endregion
	#region movement
	
		movement_get_front_axel_x		 = function() {
			return phy_position_x + __.movement.front_axel.x;
		};
		movement_get_front_axel_y		 = function() {
			return phy_position_y + __.movement.front_axel.y;
		};
		movement_get_rear_axel_x		 = function() {
			return phy_position_x + __.movement.rear_axel.x;	
		};
		movement_get_rear_axel_y		 = function() {
			return phy_position_y + __.movement.rear_axel.y;	
		};
		movement_get_front_left_wheel_x  = function() {
			var _axel_len	= __.movement.axel_length * 0.5;
			var _facing_dir = movement_get_facing_dir() + 90;
			return movement_get_front_axel_x() + lengthdir_x(_axel_len, _facing_dir);
		};
		movement_get_front_left_wheel_y  = function() {
			var _axel_len	= __.movement.axel_length * 0.5;
			var _facing_dir = movement_get_facing_dir() + 90;
			return movement_get_front_axel_y() + lengthdir_y(_axel_len, _facing_dir);
		};
		movement_get_front_right_wheel_x = function() {
			var _axel_len	= __.movement.axel_length * 0.5;
			var _facing_dir = movement_get_facing_dir() - 90;
			return movement_get_front_axel_x() + lengthdir_x(_axel_len, _facing_dir);
		};
		movement_get_front_right_wheel_y = function() {
			var _axel_len	= __.movement.axel_length * 0.5;
			var _facing_dir = movement_get_facing_dir() - 90;
			return movement_get_front_axel_y() + lengthdir_y(_axel_len, _facing_dir);
		};
		movement_get_rear_left_wheel_x	 = function() {
			var _axel_len	= __.movement.axel_length * 0.5;
			var _facing_dir = movement_get_facing_dir() + 90;
			return movement_get_rear_axel_x() + lengthdir_x(_axel_len, _facing_dir);
		};
		movement_get_rear_left_wheel_y	 = function() {
			var _axel_len	= __.movement.axel_length * 0.5;
			var _facing_dir = movement_get_facing_dir() + 90;
			return movement_get_rear_axel_y() + lengthdir_y(_axel_len, _facing_dir);
		};
		movement_get_rear_right_wheel_x  = function() {
			var _axel_len	= __.movement.axel_length * 0.5;
			var _facing_dir = movement_get_facing_dir() - 90;
			return movement_get_rear_axel_x() + lengthdir_x(_axel_len, _facing_dir);
		};
		movement_get_rear_right_wheel_y  = function() {
			var _axel_len	= __.movement.axel_length * 0.5;
			var _facing_dir = movement_get_facing_dir() - 90;
			return movement_get_rear_axel_y() + lengthdir_y(_axel_len, _facing_dir);
		};
		movement_get_facing_dir			 = function(_drift_angle = true) {
			if (_drift_angle) {
				return phy_rotation - __.drift.image_angle;
			}
			return phy_rotation;	
		};
	
		// private
		__[$ "movement"] ??= {};
		with (__.movement) {
			wheel_base					= 16;
			axel_length					= 10;
			steer_angle					= 5;
			scale						= 0.8;
			max_speed					= 2.500 * scale;
			engine_power				= 0.150 * scale;
			friction					= 0.030 * scale;
			friction_compound_threshold = max_speed * 0.2;
			friction_compound_scalar	= 3;
			velocity_cutoff				= 0.095 * scale;
			traction_fast				= 0.600 * scale;
			traction_slow				= 0.100 * scale;
			traction_correction			= 0.120 * scale;
			traction_threshold			= max_speed * 0.75;
			drag						= 0.0015 * scale;
			hand_brake_friction_scalar	= 1.5000 * scale;
			hand_brake_traction_scalar	= 0.8000 * scale;
			hand_brake_max_speed_scalar = 0.9000 * scale;
			
			position_vector		=  new XD_Vector2();
			facing_vector		=  new XD_Vector2(1);
			steer_vector		=  new XD_Vector2();
			heading_vector		=  new XD_Vector2();
			velocity_vector		=  new XD_Vector2();
			acceleration_vector =  new XD_Vector2();
			friction_vector		=  new XD_Vector2();
			drag_vector			=  new XD_Vector2();
			front_axel			=  new XD_Vector2();
			rear_axel			=  new XD_Vector2();
			rotation_last		= _self.phy_rotation;
			traction_current	=  traction_slow;
			traction_target		=  traction_current;
			
		// ***
			brake_power			= 2.5;
			max_speed_reverse	= 250;
		};
		
	#endregion
	#region collisions
			
		// private
		__[$ "collision"] ??= {};
		with (__.collision) {
			with_crate = method(_self, function() {
				if (input_lock_is_unlocked()
				&&	is_drifting()
				) {
					__.drift.failed();
					__.drift.penalty_timer = 30;
					__.collision.spring.fire(0.5);
					particles_create_impact();
					audio_play(sfx_impact_crate, false, 0);
				}
			});
			with_cone  = method(_self, function() {
				if (input_lock_is_unlocked()) {
					objc_points.penalty_cone_hit();
				}
			});
			with_human = method(_self, function() {
				if (input_lock_is_unlocked()) {
					objc_points.penalty_human_hit();
					__.collision.spring.fire(0.2);
				}
			});
			spring	   = new IB_Spring({
				tension:	0.15,
				dampening:	0.15,
				cutoff:		0.001,
			});
		};
		
		// events
		on_initialize(function() {
			__.collision.spring.initialize();
		});
		on_update	 (function() {
			__.collision.spring.update();
		});
	
	#endregion
	#region menu
	
		// events
		on_update(function() {
			// need this since we are restricting
			// player input on end of run, have 
			// to override and check for input.
			if (player_get().input_options_pressed()
			&& !objc_menu.is_open()
			) {
				objc_menu.open();
			}
		});
	
	#endregion
	#region drift
	
		// public
		is_drifting	= function() {
			return __.drift.drifting;
		};
	
		// private
		__[$ "drift"] ??= {};
		with (__.drift) {
			success				   = method(_self, function() {
				var _points = ceil(__.drift.points_current * __.drift.multiplier);
				objc_points.score_drift(_points);
				__.drift.points_scored = _points;
			});
			failed				   = method(_self, function() {
				__.drift.points_scored = 0;
				__.drift.points_alpha  = 0;
			});
			check_success		   = method(_self, function() {
				return (__.drift.points_current > 0
					&&	__.drift.penalty_timer == 0
				);
			});
			check_score_zone	   = method(_self, function() {
				if (place_meeting(x, y, obj_drift_zone)) {
					__.drift.points_current += 1;
				}
			});
			check_score_bonus_zone = method(_self, function() {
				if (place_meeting(x, y, obj_bonus_zone)) {
					
					__.drift.points_current += 3;
					
					if (iceberg.time.do_every_frame(10)) {
						floating_text_create(x, y, depth, "x3", #5ae150);
						audio_play_sound(sfx_bonus_zone_points, 0, 0);
					}
				}
			});
			check_donuts		   = method(_self, function() {
				if (__.drift.hold_time mod __.drift.donut_check_rate == 0) {
					
					// assume no donuts currently
					__.drift.donuts_active = false;
					
					// gather donut trigger objects
					var _old = __.drift.donut_trigger;
					var _new = __.drift.create_donut_trigger();
					
					// check for collision between old and new donut triggers
					var _donuts = false;
					if (_old != undefined
					&&	_old.car == _new.car
					) {
						with (_new) {
							if (place_meeting(x, y, _old)) {
								_donuts = true;
							}
						};
					}
					
					// trigger donuts
					__.drift.donuts_active = _donuts;
					if (__.drift.donuts_active) {
						__.drift.multiplier = 0.5;
						floating_text_create(x, y, depth, "DONUT", #ffa9a9);
					}
					
					// wipe & assign new references
					__.drift.clear_donut_trigger();
					__.drift.donut_trigger = _new;
				}
			});
			check_near_miss		   = method(_self, function() {
				
			//	// check for mask collision
			//	var _crate = undefined;
			//	with (__.drift.near_miss_mask) {
			//		_crate = instance_place(x, y, obj_crate);
			//	};
			//	
			//	// collision
			//	if (_crate != noone) {
			//		// if new collision, trigger near miss
			//		if (_crate != __.drift.near_miss_object) {
			//			__.drift.near_miss_object = _crate;
			//		}
			//	}
			//	// no collision
			//	else if (__.drift.near_miss_object != noone) {
			//		
			//		var _crate	= __.drift.near_miss_object;
			//		var _dist	=  point_distance(x, y, _crate.x, _crate.y);
			//		var _meters = _dist * 0.18;
			//		var _text	= "near miss!\n" + string(_meters);
			//		
			//		// score points
			//		floating_text_create(_crate.x, _crate.y, depth - 1, _text, #ffa9a9, 0.4, true);
			//		
			//		// reset
			//		__.drift.near_miss_object = noone;
			//	}
			//	else {
			//		__.drift.near_miss_object = noone;
			//	}	
				
			});
			create_donut_trigger   = method(_self, function() {
				var _donut = instance_create_depth(
					phy_position_x,
					phy_position_y,
					depth,
					obj_car_donut_check,
				);
				_donut.car = self;
				return _donut;
			});
			create_near_miss_mask  = method(_self, function() {
				var _mask = instance_create_depth(
					phy_position_x,
					phy_position_y,
					depth + 1,
					obj_car_near_miss_mask,
				);
				_mask.car = self;
				return _mask;
			});
			clear_donut_trigger	   = method(_self, function() {
				if (__.drift.donut_trigger != undefined) {
					instance_destroy(__.drift.donut_trigger);	
					__.drift.donut_trigger = undefined;
				}
			});
			update_multiplier	   = method(_self, function() {
				
				// cant trigger multiplier if just doing donuts
				if (__.drift.donuts_active) exit;
				
				// cant trigger multiplier if not in drift zone
				if (!place_meeting(x, y, obj_drift_zone)) exit;
				
				__.drift.multiplier_time++;
				
				if (__.drift.multiplier_time mod (SECOND * 3) == 0) {
					__.drift.multiplier++;
					
					// upgrade sfx
					audio_sound_pitch(sfx_drift_multiplier, random_range(0.9, 1.1));
					audio_play_sound(sfx_drift_multiplier, 2, false);
				}
			});
			update_penalty_timer   = method(_self, function() {
				if (__.drift.penalty_timer > 0) {
					__.drift.penalty_timer--;	
				}
			});
			update_render_angle	   = method(_self, function() {
				if (is_drifting()) {
					var _diff = angle_difference(__.movement.velocity_vector.get_direction(), __.movement.heading_vector.get_direction())
					__.drift.image_angle_target = __.drift.image_angle_amount * sign(_diff);
				}
				else {
					__.drift.image_angle_target = 0;		
				}
				__.drift.image_angle = iceberg.tween.lerp_angle(__.drift.image_angle, __.drift.image_angle_target, 0.3);
			});
			render_score		   = method(_self, function() {
				
				static _scale = 0.3;
				static _text  = undefined;
				
				__.drift.points_alpha -= 0.01;
				
				if (__.drift.points_current > 0) {
					var _text = "+" + string(__.drift.points_current);
					__.drift.points_alpha = 1;
				}
				else if (__.drift.points_scored > 0) {
					var _text = "+" + string(__.drift.points_scored);
				}
				
				if (_text != undefined && __.drift.points_alpha > 0) {
					// score
					draw_text_transformed_color(x + 1, y + 1, _text, _scale, _scale, 0, c_black, c_black, c_black, c_black, __.drift.points_alpha);
					draw_text_transformed_color(x,	   y,	  _text, _scale, _scale, 0, c_white, c_white, c_white, c_white, __.drift.points_alpha);
					
					// multiplier
					if (__.drift.multiplier != 0 && __.drift.multiplier != 1) {
						var _color = __.drift.multiplier > 1 ? #5ae150 : #e93841;
						draw_text_transformed_color(x + 15, y - 6, "x" + string(__.drift.multiplier), _scale * 0.6, _scale * 0.6, 0, c_black, c_black, c_black, c_black, __.drift.points_alpha);
						draw_text_transformed_color(x + 14,	y - 7, "x" + string(__.drift.multiplier), _scale * 0.6, _scale * 0.6, 0, _color,  _color,  _color,  _color,  __.drift.points_alpha);
					} 
				}	
			});
			render_near_miss	   = method(_self, function() {
				if (__.drift.near_miss_object != noone) {
					surface_set_target(objc_world.__.surface_info);
					draw_line(x, y, __.drift.near_miss_object.x, __.drift.near_miss_object.y);
					surface_reset_target();
				}
			});
			
			drifting		   = false;
			hold_time		   = 0;
			penalty_timer	   = 0;
			points_current	   = 0;
			points_scored	   = 0;
			points_alpha	   = 1;
			multiplier_time	   = 0;
			multiplier		   = 1;
			donuts_active	   = false;
			donut_check_rate   = 1 * SECOND;
			donut_trigger	   = undefined;
			near_miss_mask	   = undefined;
			near_miss_object   = noone;
			image_angle_amount = 30;
			image_angle_target = 0;
			image_angle		   = image_angle_target;	
		};
		
		// events
		on_initialize(function() {
			__.drift.near_miss_mask = __.drift.create_near_miss_mask();
		});
		on_update	 (function() {
			__.drift.update_penalty_timer();
			__.drift.update_render_angle();
		});
		on_room_start(function() {
			__.drift.points_alpha = 0;
		});
		on_cleanup	 (function() {
			if (__.drift.donut_trigger  != undefined) {
				instance_destroy(__.drift.donut_trigger);	
			}
			if (__.drift.near_miss_mask != undefined) {
				instance_destroy(__.drift.near_miss_mask);	
			}
		});
	
	#endregion
	#region radio
	
		// private
		__[$ "radio"] ??= {};
		with (__.radio) {
			track_started_event			= method(_self, function(_data) {
				input_lock_set("__waiting");
			});
			countdown_started_event		= method(_self, function(_data) {
				input_lock_remove("__waiting");
				input_lock_set("__countdown_started");
			});
			countdown_finished_event	= method(_self, function(_data) {
				input_lock_remove("__countdown_started");
			});
			round_started_event			= method(_self, function(_data) {
				input_lock_remove("__round_finished");
			});
			round_finished_event		= method(_self, function(_data) {
				if (__.drift.points_current > 0) {
					__.drift.success();
				}
				input_lock_set("__round_finished");
			});
				
			track_started_listener		= undefined;
			countdown_started_listener	= undefined;
			countdown_finished_listener = undefined;
			round_started_listener		= undefined;
			round_finished_listener		= undefined;
		};
		
		// events
		on_initialize(function() {
			__.radio.track_started_listener		 = SUBSCRIBE("track_started",	   __.radio.track_started_event	);
			__.radio.countdown_started_listener	 = SUBSCRIBE("countdown_started",  __.radio.countdown_started_event );
			__.radio.countdown_finished_listener = SUBSCRIBE("countdown_finished", __.radio.countdown_finished_event);
			__.radio.round_started_listener		 = SUBSCRIBE("round_started",	   __.radio.round_started_event	);
			__.radio.round_finished_listener	 = SUBSCRIBE("round_finished",	   __.radio.round_finished_event	);
		});
		on_cleanup	 (function() {
			UNSUBSCRIBE(__.radio.track_started_listener	);
			UNSUBSCRIBE(__.radio.countdown_started_listener );
			UNSUBSCRIBE(__.radio.countdown_finished_listener);
			UNSUBSCRIBE(__.radio.round_started_listener	);
			UNSUBSCRIBE(__.radio.round_finished_listener	);
		});
	
	#endregion
		
	// events
	on_render(function() {
		var _s = __.collision.spring.get();
		draw_sprite_stacked(phy_position_x, phy_position_y, 1 + _s, -1, __.drift.image_angle);
		__.drift.render_score();
	});
	
	////////////////
		
	initialize();
	
	