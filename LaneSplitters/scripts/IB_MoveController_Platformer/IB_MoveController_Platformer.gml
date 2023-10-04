
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______  __       ______   ______  ______  ______   ______   __    __   ______   ______    //
	// /\  == \/\ \     /\  __ \ /\__  _\/\  ___\/\  __ \ /\  == \ /\ "-./  \ /\  ___\ /\  == \   //
	// \ \  _-/\ \ \____\ \  __ \\/_/\ \/\ \  __\\ \ \/\ \\ \  __< \ \ \-./\ \\ \  __\ \ \  __<   //
	//  \ \_\   \ \_____\\ \_\ \_\  \ \_\ \ \_\   \ \_____\\ \_\ \_\\ \_\ \ \_\\ \_____\\ \_\ \_\ //
	//   \/_/    \/_____/ \/_/\/_/   \/_/  \/_/    \/_____/ \/_/ /_/ \/_/  \/_/ \/_____/ \/_/ /_/ //
	//                                                                                            //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function IB_MoveController_Platformer(_config = {}) : IB_Base(_config) constructor {

		var _self = self;
	
		#region hidden ............|
		
		// = PRIVATE ===============
		__[$ "hidden"] = {};
		with (__.hidden) {
			static __hidden_id = "__IB_MoveController_Platformer_HiddenID";
			_self.get_owner()[$ __hidden_id] = other;
		};
		
		#endregion
		#region owner/instance ....|
		
		// = PRIVATE ===============
		static __instance_get_move_controller = function(_instance) {
			if (_instance != noone) {
				return _instance[$ __hidden_id];	
			}
			return undefined;
		};	
		static __owner_adjust_x				  = function(_amount) {
			__owner_set_x(__owner_get_x() + _amount);
		};
		static __owner_adjust_y				  = function(_amount) {
			__owner_set_y(__owner_get_y() + _amount);
		};
		static __owner_get_x				  = function() {
			return __.owner.x;
		};
		static __owner_get_y				  = function() {
			return __.owner.y;
		};
		static __owner_set_x				  = function(_x) {
			 __.owner.x = _x;
			__collision_update();
		};
		static __owner_set_y				  = function(_y) {
			 __.owner.y = _y;
			__collision_update();
		};
		
		#endregion
		#region input .............|
		
		// = PUBLIC ================
		static input_lock_is_locked   = function() {
			return __.input.lock.is_locked();
		};
		static input_lock_is_unlocked = function() {
			return __.input.lock.is_unlocked();
		};
		static input_lock_remove	  = function(_lock_name) {
			__.input.lock.remove_lock(_lock_name);
			return self;
		};
		static input_lock_set		  = function(_lock_name, _lock_time = -1) {
			__.input.lock.set_lock(_lock_name, _lock_time);
			return self;
		};
		
		// = PRIVATE ===============
		__[$ "input"] = {};
		with (__.input) {
			static __input_check			   = function() {
				return (__.input.enabled
					&&  input_lock_is_unlocked()
				);
			};
			static __input_control_ground	   = function() {
				if (__.ground.input_enabled 
				&&	__input_check()
				) {
					return __input_move_right_down() - __input_move_left_down();
				}
				return 0;
			};
			static __input_control_air		   = function() {
				if (__.air.input_enabled 
				&&	__input_check()
				) {
					return __input_move_right_down() - __input_move_left_down();
				}
				return 0;
			};
			static __input_move_left_down	   = function() {
				if (__.input.move_left_down != undefined
				&&	__input_check() 
				) {
					return __.input.move_left_down();	
				}
				return false;
			};
			static __input_move_right_down	   = function() {
				if (__.input.move_right_down != undefined
				&&	__input_check() 
				) {
					return __.input.move_right_down();	
				}
				return false;
			};
			static __input_move_down_down	   = function() {
				if (__.input.move_down_down != undefined
				&&	__input_check() 
				) {
					return __.input.move_down_down();	
				}
				return false;
			};
			static __input_move_check		   = function() {
				
				// each of these methods handle input_check(). 
				// dont need to do an additional input_check.
				
				return (__input_move_left_down() || __input_move_right_down());
			};
			static __input_jump_pressed		   = function() {
				if (__input_check() && __.input.jump_pressed != undefined) {
					return __.input.jump_pressed();	
				}
				return false;
			};
			static __input_jump_down		   = function() {
				if (__input_check() && __.input.jump_down != undefined) {
					return __.input.jump_down();	
				}
				return false;
			};
			static __input_jump_released	   = function() {
				if (__input_check() && __.input.jump_released != undefined) {
					return __.input.jump_released();	
				}
				return false;
			};
			static __input_sprint_down		   = function() {
				if (__input_check() && __.input.sprint_down != undefined) {
					return __.input.sprint_down();
				}
				return false;
			};
			static __input_strafe_pressed	   = function() {
				if (__input_check() && __.input.strafe_pressed != undefined) {
					return __.input.strafe_pressed();	
				}
				return false;
			};
			static __input_strafe_down		   = function() {
				if (__input_check() && __.input.strafe_down != undefined) {
					return __.input.strafe_down();	
				}
				return false;
			};
			static __input_strafe_released	   = function() {
				if (__input_check() && __.input.strafe_released != undefined) {
					return __.input.strafe_released();	
				}
				return false;
			};
			static __input_dropthrough_pressed = function() {
				if (__input_check() && __.input.dropthrough_pressed != undefined) {
					return __.input.dropthrough_pressed();	
				}
				return false;
			};
			static __input_wall_jump_pressed   = function() {
				if (__input_check() && __.input.wall_jump_pressed != undefined) {
					return __.input.wall_jump_pressed();	
				}
				return false;
			};
			static __input_fast_fall_down	   = function() {
				if (__input_check() && __.input.fast_fall_down != undefined) {
					return __.input.fast_fall_down();	
				}
				return false;
			};
				
			enabled				= _config[$ "input_enabled"			   ] ?? false;
			move_left_down		= _config[$ "input_move_left_down"	   ] ?? undefined;
			move_right_down		= _config[$ "input_move_right_down"	   ] ?? undefined;
			move_down_down		= _config[$ "input_move_down_down"	   ] ?? undefined;
			jump_pressed		= _config[$ "input_jump_pressed"	   ] ?? undefined;
			jump_down			= _config[$ "input_jump_down"		   ] ?? undefined;
			jump_released		= _config[$ "input_jump_released"	   ] ?? undefined;
			sprint_down			= _config[$ "input_sprint_down"		   ] ?? undefined;
			strafe_pressed		= _config[$ "input_strafe_pressed"	   ] ?? undefined;
			strafe_down			= _config[$ "input_strafe_down"		   ] ?? undefined;
			strafe_released		= _config[$ "input_strafe_released"	   ] ?? undefined;
			dropthrough_pressed = _config[$ "input_dropthrough_pressed"] ?? undefined;
			wall_jump_pressed	= _config[$ "input_wall_jump_pressed"  ] ?? jump_pressed;
			fast_fall_down		= _config[$ "input_fast_fall_down"	   ] ?? move_down_down;
			lock				=  new IB_LockStack();
		};
		
		// = EVENTS ================
		on_initialize(function() {
			__.input.lock.initialize();
		});
		on_update	 (function() {
			__.input.lock.update();
		});
		on_cleanup   (function() {
			__.input.lock.cleanup();
		});
		
		#endregion
		#region state .............|
		
		// = PUBLIC ================
		static state_change		  = function(_state) {
			__.state.fsm.change(_state);
			return self;
		};
		static state_get		  = function() {
			return __.state.fsm.get_current_state();	
		};
		static state_get_previous = function() {
			return __.state.fsm.get_previous_state();	
		};
		static state_is			  = function(_state_name) {
			return __.state.fsm.state_is(_state_name);	
		};
		static state_on_change	  = function(_callback) {
			return __.state.fsm.on("state changed", _callback);	
		};
		
		// = PRIVATE ===============
		__[$ "state"] = {};
		with (__.state) {
			fsm  = new SnowState("idle", false, {
				owner: _self,
			});
			fsm.history_enable();
			fsm.history_set_max_size(1);
			
			// states // ~~~~~~~~~~~~~~~~~~~~~~~~ //
			fsm.add("__",		{
				enter:		function() {},
				begin_step: function() {
					__velocity_x_base_influences_update();
					__velocity_x_terminal_scalars_update();
					__velocity_y_base_influences_update();
					__facing_apply();
					__collision_update();
				},
				step:		function() {},
				end_step:	function() {
					__velocity_x_apply();
				},
				leave:		function() {},
			});
			fsm.add("ledge",	{
				enter:		function() {},
				begin_step: function() {},
				step:		function() {},
				end_step:	function() {},
				leave:		function() {},
			});
			fsm.add("platform", {
				enter:		function() {},
				begin_step: function() {
					__velocity_x_base_influences_update();
					__velocity_x_terminal_scalars_update();
					__velocity_y_base_influences_update();
					__facing_apply();
				},
				step:		function() {
					__gravity_apply();
				},
				end_step:	function() {
					__velocity_y_apply();
					__velocity_x_apply();
				},
				leave:		function() {},	
			});
	
			// grounded // ~~~~~~~~~~~~~~~~~~~~~~ //
			fsm.add_child("__",		  "grounded", {
				enter:		function() {
					__.state.fsm.inherit();
					__.air.velocity_y = 0;
					__jump_reset();
					__wall_jump_reset();
					__wall_slide_reset();
					__ledge_hang_reset();
					__ground_incline_update();
				},
				begin_step: function() {
					__.state.fsm.inherit();
					__ground_incline_update();
					__sprite_rotate_to_slope_apply();
				},
				step:		function() {
					__.state.fsm.inherit();
					__ground_movement_apply(__input_control_ground());
			
					// apply dropthrough force
					if (__.state.fsm.trigger("t_dropthrough")) {
						__dropthrough_apply();
						exit;
					}
					__.state.fsm.trigger("t_ground_fall");
					__.state.fsm.trigger("t_jump");
					__.state.fsm.trigger("t_jump_buffered");	
					__.state.fsm.trigger("t_pushing");
				},	
				end_step:	function() {
					__.state.fsm.inherit();
				},	
				leave:		function() {
					__.state.fsm.inherit();
				},
			});
			fsm.add_child("grounded", "idle",	  {
				enter:		function() {
					__.state.fsm.inherit();
				},
				begin_step: function() {
					__.state.fsm.inherit();
				},
				step:		function() {
					__.state.fsm.inherit();
					__.state.fsm.trigger("t_walk");
					__.state.fsm.trigger("t_sprint");
					__.state.fsm.trigger("t_strafe");
				},
				end_step:	function() {
					__.state.fsm.inherit();
				},	
				leave:		function() {
					__.state.fsm.inherit();
				},
			});
			fsm.add_child("grounded", "move",	  {
				enter:		function() {
					__.state.fsm.inherit();
				},
				begin_step: function() {
					__.state.fsm.inherit();
					// up slope multiplier
					if ( __slope_up_mult_check()) {
						 __slope_up_mult_apply();
					}
					else __slope_up_mult_reset();
			
					// down slope multiplier
					if ( __slope_down_mult_check()) {
						 __slope_down_mult_apply();
					}
					else __slope_down_mult_reset();
				},
				step:		function() {
					__.state.fsm.inherit();
					
					// apply passive pushing
					if (!__.pushing.uses_state && __pushing_check()) {
						__pushing_apply();
					}
					__.state.fsm.trigger("t_idle");
				},
				end_step:	function() {
					__.state.fsm.inherit();
				},	
				leave:		function() {
					__.state.fsm.inherit();
					__slope_up_mult_reset();
					__slope_down_mult_reset();	
				},
			});
			fsm.add_child("move",	  "walk",	  {
				enter:		function() {
					__.state.fsm.inherit();
				},
				begin_step: function() {
					__.state.fsm.inherit();
				},
				step:		function() {
					__.state.fsm.inherit();
					__.state.fsm.trigger("t_sprint");
					__.state.fsm.trigger("t_strafe");
				},
				end_step:	function() {
					__.state.fsm.inherit();
				},	
				leave:		function() {
					__.state.fsm.inherit();
				},
			});
			fsm.add_child("move",	  "sprint",	  {
				enter:		function() {
					__.state.fsm.inherit();
					__sprint_apply();
				},
				begin_step: function() {
					__.state.fsm.inherit();
				},
				step:		function() {
					__.state.fsm.inherit();
					__.state.fsm.trigger("t_sprint_stop");
				},
				end_step:	function() {
					__.state.fsm.inherit();
				},	
				leave:		function() {
					__.state.fsm.inherit();
					__sprint_reset();
				},
			});
			fsm.add_child("move",	  "strafe",	  {
				enter:		function() {
					__.state.fsm.inherit();
				},
				enter:		function() {
					__.state.fsm.inherit();
					__strafe_apply();
				},
				begin_step: function() {
					__.state.fsm.inherit();
				},
				step:		function() {
					__.state.fsm.inherit();
					__.state.fsm.trigger("t_strafe_stop");
				},
				end_step:	function() {
					__.state.fsm.inherit();
				},	
				leave:		function() {
					__.state.fsm.inherit();
					__strafe_reset();
				},
			});
			fsm.add_child("move",	  "push",	  {
				enter:		function() {
					__.state.fsm.inherit();
					__pushing_enter();
				},
				begin_step: function() {
					__.state.fsm.inherit();
				},
				step:		function() {
					__.state.fsm.inherit();
					__pushing_step();
					__.state.fsm.trigger("t_pushing_stop");
				},
				end_step:	function() {
					__.state.fsm.inherit();
				},	
				leave:		function() {
					__.state.fsm.inherit();
					__pushing_leave();
				},
			});
			fsm.add_child("grounded", "land",	  {
				enter:		function() {
					__.state.fsm.inherit();
					input_lock_remove("__wall_jump");
				},
				begin_step: function() {
					__.state.fsm.inherit();
				},
				step:		function() {
					__.state.fsm.inherit();
					__.state.fsm.trigger("t_idle");
					__.state.fsm.trigger("t_walk");
				},
				end_step:	function() {
					__.state.fsm.inherit();
				},
				leave:		function() {
					__.state.fsm.inherit();
				},
			});
				
			// aerial // ~~~~~~~~~~~~~~~~~~~~~~~~ //
			fsm.add_child("__",		  "aerial",		{
				enter:		function() {
					__.state.fsm.inherit();
					__.slope.ground_incline = 0;
				},
				begin_step: function() {
					__.state.fsm.inherit();
				},
				step:		function() {
					__.state.fsm.inherit();
					__gravity_apply();
					__air_movement_apply(__input_control_air());
					__.state.fsm.trigger("t_jump_multi");
					__.state.fsm.trigger("t_wall_slide");
					if (__strafe_check()) __strafe_apply();	
				},
				end_step:	function() {
					__.state.fsm.inherit();
					__velocity_y_apply();
				},	
				leave:		function() {
					__.state.fsm.inherit();
				},
			});
			fsm.add_child("aerial",   "fall",		{
				enter:		function() {
					__.state.fsm.inherit();
				},
				begin_step: function() {
					__.state.fsm.inherit();
					// tick jump coyote time
					if (__.jump.coyote_time_timer > 0) {
						__.jump.coyote_time_timer--;
					}
					// tick jump input buffer
					if (__.jump.input_buffer_timer > 0) {
						__.jump.input_buffer_timer--;
					}
				},
				step:		function() {
					__.state.fsm.inherit();
					__gravity_apply();	
					// start input buffer timer if not coyote_jump
					if (!__.state.fsm.trigger("t_jump_coyote")) {
						if (__input_jump_pressed()) {
							__.jump.input_buffer_timer = __.jump.input_buffer_time;	
						}
					}
					__.state.fsm.trigger("t_land");
					__.state.fsm.trigger("t_ledge_hang");
				},
				end_step:	function() {
					__.state.fsm.inherit();
				},
				leave:		function() {
					__.state.fsm.inherit();
				},
			});
			fsm.add_child("aerial",   "jump",		{
				enter:		function() {
					jump();
					__.state.fsm.inherit();
				},
				begin_step: function() {
					__.state.fsm.inherit();	
				},
				step:		function() {
					__.state.fsm.inherit();
			
					var _state_was_wall_slide 
						= (__.state.fsm.get_previous_state() == "wall_slide");
			
					// variable jump
					if (__.jump.variable_enabled) {
						if (!_state_was_wall_slide || __.wall_jump.variable_enabled) {	
							if (__input_jump_released()) {
								var _variable_mult = _state_was_wall_slide
									? __.wall_jump.variable_mult
									: __.jump.variable_mult;
								__jump_apply_variable(_variable_mult);	
							}
						}
					}
				
					// apex modifiers?
					if (__.state.fsm.trigger("t_jump_fall")) {
						if (!_state_was_wall_slide || __.apex.on_wall_jumps_enabled) {
							__apex_modifier_fast_fall_apply();
							__apex_modifier_speed_boost_apply();
						}
					}
			
					// jump up edge grace
					if (__ledge_grace_jump_up_check()) {
						__ledge_grace_jump_up_apply();	
					}
				},
				end_step:	function() {
					__.state.fsm.inherit();
				},
				leave:		function() {
					__.state.fsm.inherit();
				},
			});
			fsm.add_child("aerial",	  "wall_slide", {
				enter:		function() {
					__.state.fsm.inherit();
					__.ground.velocity_x = 0;
					__velocity_x_base_influences_reset();
					__velocity_x_terminal_scalars_reset();
					__.wall_slide.time_limit_timer = __.wall_slide.time_limit;
					__wall_slide_on_start();
				},
				begin_step: function() {
					// DO NOT INHERIT // 
					__velocity_y_base_influences_update();
			
					// wall_slide timer tick
					if ( __.wall_slide.time_limit_timer > 0) {
						 __.wall_slide.time_limit_timer--;	
					}
					else __.wall_slide.limit_used_up = true;
				},
				step:		function() {
					// DO NOT INHERIT //
					__wall_slide_gravity_apply();	
					__.state.fsm.trigger("t_land");
					__.state.fsm.trigger("t_wall_release");
					__.state.fsm.trigger("t_wall_jump");
					__.state.fsm.trigger("t_ledge_hang");
				},
				end_step:	function() {
					__.state.fsm.inherit();
				},
				leave:		function() {
					__.state.fsm.inherit();
					__wall_slide_on_stop();
				},
			});
	
			// ledge // ~~~~~~~~~~~~~~~~~~~~~~~~~ //
			fsm.add_child("ledge", "ledge_hang", {
				enter:		function() {
					__.state.fsm.inherit();
					__ledge_hang_apply();
					__.ledge.hang_time_limit_timer = __.ledge.hang_time_limit;
					
					// on_start callbacks
					iceberg.array.for_each(__.ledge.hang_on_start, function(_callback) {
						_callback.callback(_callback.data);
					});
				},
				begin_step: function() {
					__.state.fsm.inherit();
					
					// wall_slide timer tick
					if ( __.ledge.hang_time_limit_timer > 0) {
						 __.ledge.hang_time_limit_timer--;	
					}
					else __.ledge.hang_time_limit_used_up = true;
				},
				step:		function() {
					__.state.fsm.inherit();
					__.state.fsm.trigger("t_ledge_drop");
			
					// jump or wall_jump?
					if (!__.state.fsm.trigger("t_ledge_wall_jump")) {
						 __.state.fsm.trigger("t_ledge_jump");
					}
				},
				end_step:	function() {
					__.state.fsm.inherit();
				},
				leave:		function() {
					__.state.fsm.inherit();
					__.ledge.hang_instance = undefined;	
					
					// on_stop callbacks
					iceberg.array.for_each(__.ledge.hang_on_stop, function(_callback) {
						_callback.callback(_callback.data);
					});
				},
			});
	
			#region transitions
	
			// grounded //
			fsm.add_transition("t_idle",			"grounded",		"idle",			method(_self, function() {
				return !__input_move_check();
			}));
			fsm.add_transition("t_walk",			"grounded",		"walk",			method(_self, function() {
				return __input_move_check();
			}));
			fsm.add_transition("t_sprint",			"grounded",		"sprint",		method(_self, function() {
				return __sprint_check();
			}));
			fsm.add_transition("t_strafe",			"grounded",		"strafe",		method(_self, function() {
				return __strafe_check();
			}));
			fsm.add_transition("t_jump",			"grounded",		"jump",			method(_self, function() {
				return __jump_check();
			}));
			fsm.add_transition("t_jump_buffered",	"grounded",		"jump",			method(_self, function() {
				return __jump_buffer_check();
			}));
			fsm.add_transition("t_sprint_stop",		"sprint",		"walk",			method(_self, function() {
				return !__input_sprint_down();
			}));
			fsm.add_transition("t_strafe_stop",		"strafe",		"walk",			method(_self, function() {
				return __input_strafe_released();
			}));
			fsm.add_transition("t_ground_fall",		"grounded",		"fall",			method(_self, function() {
				return (__.air.gravity_enabled && !__standing_on_ground());
			}));
			fsm.add_transition("t_dropthrough",		"grounded",		"fall",			method(_self, function() {
				return __dropthrough_check();
			}));
			fsm.add_transition("t_pushing",			"grounded",		"push",			method(_self, function() {
				return (__.pushing.uses_state
					&&	__.state.fsm.get_current_state() != "push"
					&&	__pushing_check()
				);
			}));
			fsm.add_transition("t_pushing_stop",	"push",			"idle",			method(_self, function() {
				return __pushing_stop_check();
			}));
	
			// aerial //
			fsm.add_transition("t_jump_fall",		"jump",			"fall",			method(_self, function() {
				return __.air.velocity_y >= 0;
			}));
			fsm.add_transition("t_land",			"aerial",		"land",			method(_self, function() {
				return __standing_on_ground();
			}));
			fsm.add_transition("t_jump_multi",		"aerial",		"jump",			method(_self, function() {
				return __jump_multi_check();
			}));
			fsm.add_transition("t_jump_coyote",		"fall",			"jump",			method(_self, function() {
				return __jump_coyote_check();
			}));
			fsm.add_transition("t_wall_slide",		"aerial",		"wall_slide",	method(_self, function() {
				return __wall_slide_check();
			}));
			fsm.add_transition("t_wall_release",	"wall_slide",	"fall",			method(_self, function() {
				return __wall_slide_release_check();
			}));
			fsm.add_transition("t_wall_jump",		"wall_slide",	"jump",			method(_self, function() {
				return __wall_jump_check();
			}),,
				method(_self, function() {  // override enter
					__.state.fsm.inherit();
					__wall_jump_apply();
				}));
		
			// ledge //
			fsm.add_transition("t_ledge_hang",		"aerial",		"ledge_hang",	method(_self, function() {
				return __ledge_hang_check();
			}));
			fsm.add_transition("t_ledge_drop",		"ledge_hang",	"fall",			method(_self, function() {
				return __ledge_hang_drop_check();
			}));
			fsm.add_transition("t_ledge_jump",		"ledge_hang",	"jump",			method(_self, function() {
				return __ledge_hang_jump_check();
			}));
			fsm.add_transition("t_ledge_wall_jump", "ledge_hang",	"jump",			method(_self, function() {
				return __ledge_hang_wall_jump_check();
			}),,
				method(_self, function() { // override enter
					__.state.fsm.inherit();
					__wall_jump_apply();
				}));
	
			#endregion
		};
			
		// = EVENTS ================
		on_update_begin(function() {
			__.state.fsm.begin_step();
		});
		on_update	   (function() {
			__.state.fsm.step();
		});
		on_update_end  (function() {
			__.state.fsm.end_step();
		});
		
		#endregion
		#region ground control ....|
		
		// = PUBLIC ================
		static velocity_x_add			   = function(_amount) {
			__.ground.velocity_x += _amount;
			return self;
		};
		static velocity_x_add_influence	   = function(_influence_name, _velocity_x, _update = true) {
			__.ground.velocity_x_base_influences.set(_influence_name, _velocity_x);
			if (_update) __velocity_x_base_influences_update();
			return self;
		};
		static velocity_x_add_scalar	   = function(_influence_name, _x_scalar, _update = true) {
			__.ground.velocity_x_terminal_scalars.set(_influence_name, _x_scalar);
			if (_update) __velocity_x_terminal_scalars_update();
			return self;
		};
		static velocity_x_flip			   = function(_scalar = 1) {
			__.ground.velocity_x *= -_scalar;
			return self;
		};
		static velocity_x_get			   = function(_apply_external_influences = false) {
			if (_apply_external_influences) {
				if (__.ground.velocity_x_override != undefined) {
					return velocity_x_get_influence() + __.ground.velocity_x_override;	
				}
				return velocity_x_get_influence() + __.ground.velocity_x;
			}
			return __.ground.velocity_x;
		};
		static velocity_x_get_influence	   = function() {
			return __.ground.velocity_x_base + __.ground.velocity_x_base_influences_sum;
		};	
		static velocity_x_get_scalar	   = function() {
			return __.ground.velocity_x_terminal * __.ground.velocity_x_terminal_scalars_sum;
		};
		static velocity_x_has_scalar	   = function(_influence_name) {
			return __.ground.velocity_x_terminal_scalars.contains(_influence_name);	
		};
		static velocity_x_set			   = function(_velocity_x) {
			__.ground.velocity_x = _velocity_x;
			return self;
		};
		static velocity_x_remove_influence = function(_influence_name, _update = true) {
			__.ground.velocity_x_base_influences.remove(_influence_name);
			if (_update) __velocity_x_base_influences_update();
			return self;
		};
		static velocity_x_remove_scalar	   = function(_influence_name, _update = true) {
			__.ground.velocity_x_terminal_scalars.remove(_influence_name);
			if (_update) __velocity_x_terminal_scalars_update();
			return self;
		};
		
		// = PRIVATE ===============
		__[$ "ground"] = {};
		with (__.ground) {
			static __velocity_x_apply					= function() {
				if (__.ground.velocity_x_enabled) {
				
					// sub-pixel calculation
					var _velocity_x_sub_pixel		= 0;
					__.ground.velocity_x_sub_pixel += velocity_x_get(true);
						_velocity_x_sub_pixel		= round(__.ground.velocity_x_sub_pixel);
					__.ground.velocity_x_sub_pixel -= _velocity_x_sub_pixel;
			
					// apply velocity_x with sub-pixel calculation
					repeat (abs(_velocity_x_sub_pixel)) {
						__slope_adjustment_apply();
					
						// collision with solid
						var _self = self;
						with (get_owner()) {
							var _velocity_x = _velocity_x_sub_pixel;//other.velocity_x_get(true);
							var _instance	= instance_place(x + sign(_velocity_x), y, _self.__.collision.object_solid);
							if (_instance  != noone && !_self.__collision_filter_check(_instance)) {
								_self.__collision_horizontal_apply(_instance);
								break;
							}
							else {
								_self.__owner_adjust_x(sign(_velocity_x));
								_self.__.collision.bounce_horizontal_applied = false;
							}
						};
					};
				}
			};
			static __velocity_x_base_influences_update	= function() {
				var _x_sum = 0;
				for (var _i = 0; _i < __.ground.velocity_x_base_influences.get_size(); _i++) {
					var _key = __.ground.velocity_x_base_influences.get_name(_i);
					_x_sum  += __.ground.velocity_x_base_influences.get(_key);
				};
				__.ground.velocity_x_base_influences_sum = _x_sum;
			};
			static __velocity_x_base_influences_reset	= function() {
				__.ground.velocity_x_base_influences_sum = 0;
			};
			static __velocity_x_terminal_scalars_update = function() {
				var _x_sum = 1;
				for (var _i = 0; _i < __.ground.velocity_x_terminal_scalars.get_size(); _i++) {
					var _key = __.ground.velocity_x_terminal_scalars.get_name(_i);
					_x_sum  *= __.ground.velocity_x_terminal_scalars.get(_key);
				};
				__.ground.velocity_x_terminal_scalars_sum = _x_sum;
			};
			static __velocity_x_terminal_scalars_reset  = function() {
				__.ground.velocity_x_terminal_scalars_sum = 1;
			};
			static __ground_acceleration_apply			= function(_limit) {
				
				// basic approach
				if (__.ground.acceleration_curve_index == undefined) {
					__.ground.acceleration_curve_t = 0;
					__.ground.velocity_x		   = iceberg.tween.approach(__.ground.velocity_x, _limit, __.ground.acceleration);
				}
				// use assigned animation curve
				else {
					__.ground.acceleration_curve_t = iceberg.tween.approach(__.ground.acceleration_curve_t, 1, __.ground.acceleration);
					__.ground.velocity_x		   = __.ground.acceleration_curve.get_value(,__.ground.acceleration_curve_t) * _limit;		
				}
			};
			static __ground_friction_apply				= function() {
			  //__.ground.acceleration_curve_t = iceberg.tween.approach(__.ground.acceleration_curve_t, 0, __.ground.friction);
				__.ground.velocity_x		   = iceberg.tween.approach(__.ground.velocity_x, 0, __.ground.friction);
			};
			static __ground_turn_force_apply			= function() {
				__.ground.velocity_x = iceberg.tween.approach(
					__.ground.velocity_x, 
					   0, 
					__.ground.turn_force
				);
			};
			static __ground_movement_apply				= function(_dir = 0) {
				var _limit  = velocity_x_get_scalar() * _dir;
				if (_limit != 0) {
					if ((_dir ==  1 && __.ground.velocity_x < 0) 
					||	(_dir == -1 && __.ground.velocity_x > 0)
					) {
						__ground_turn_force_apply();
					}
					__ground_acceleration_apply(_limit);
				}
				if (_limit == 0 || __.ground.friction_always_apply) {
					__ground_friction_apply();
				}
			};
			
			velocity_x_enabled				= _config[$ "velocity_x_enabled"			   ] ?? true;
			velocity_x_base					= _config[$ "velocity_x_base"				   ] ?? 0.00;
			velocity_x						= _config[$ "velocity_x"					   ] ?? 0.00;
			velocity_x_terminal				= _config[$ "velocity_x_terminal"			   ] ?? 3.00;
			velocity_x_override				= _config[$ "velocity_x_override"			   ] ?? undefined;
			input_enabled					= _config[$ "ground_input_enabled"			   ] ?? true;
			acceleration					= _config[$ "ground_acceleration"			   ] ?? 0.50;
			acceleration_curve_index		= _config[$ "ground_acceleration_curve_index"  ] ?? undefined;
			acceleration_curve_channel		= _config[$ "ground_acceleration_curve_channel"] ?? 1;
			friction						= _config[$ "ground_friction"				   ] ?? 0.20;
			friction_curve					= _config[$ "ground_friction_curve"			   ] ?? undefined;
			friction_always_apply			= _config[$ "ground_friction_always_apply"	   ] ?? true;
			turn_force						= _config[$ "ground_turn_force"				   ] ?? 0;
			turn_force_curve				= _config[$ "ground_turn_force_curve"		   ] ?? undefined;
			
			velocity_x_base_influences		= new IB_Collection_Struct();
			velocity_x_terminal_scalars		= new IB_Collection_Struct();
			velocity_x_base_influences_sum  = 0;
			velocity_x_terminal_scalars_sum = 1;
			velocity_x_sub_pixel			= 0;
			acceleration_curve				= new IB_AnimationCurve({
				curve:	 acceleration_curve_index,
				channel: acceleration_curve_channel,
			});
			acceleration_curve_t			= 0;
		};
		
		// = EVENTS ================
		on_initialize(function() {
			__.ground.acceleration_curve.initialize();
		});
		on_cleanup   (function() {
			__.ground.velocity_x_base_influences.cleanup();
			__.ground.velocity_x_terminal_scalars.cleanup();
			__.ground.acceleration_curve.cleanup();
		});
		
		#endregion
		#region air control .......|
		
		// = PUBLIC ================
		static velocity_y_add			   = function(_amount) {
			__.air.velocity_y += _amount;
			return self;
		};
		static velocity_y_add_influence	   = function(_influence_name, _velocity_y, _update = true) {
			__.air.velocity_y_base_influences.set(_influence_name, _velocity_y);
			if (_update) __velocity_y_base_influences_update();
			return self;
		};
		static velocity_y_flip			   = function(_scalar = 1) {
			__.ground.velocity_y *= -_scalar;
			return self;
		};
		static velocity_y_get			   = function(_apply_external_influences = false) {
			if (_apply_external_influences) {
				if (__.air.velocity_y_override != undefined) {
					return velocity_y_get_influence() + __.air.velocity_y_override;	
				}
				return velocity_y_get_influence() + __.air.velocity_y;
			}
			return __.air.velocity_y;
		};
		static velocity_y_get_influence	   = function() {
			return __.air.velocity_y_base + __.air.velocity_y_base_influences_sum;
		};
		static velocity_y_set			   = function(_velocity_y) { 
			__.air.velocity_y = _velocity_y;
			return self;
		};
		static velocity_y_remove_influence = function(_influence_name, _update = true) {
			__.air.velocity_y_base_influences.remove(_influence_name);
			if (_update) __velocity_y_base_influences_update();
			return self;
		};
		
		static gravity_lock_is_locked	= function() {
			return __.air.gravity_lock.is_locked();
		};
		static gravity_lock_is_unlocked = function() {
			return __.air.gravity_lock.is_unlocked();
		};
		static gravity_lock_remove		= function(_lock_name) {
			__.air.gravity_lock.remove_lock(_lock_name);
			return self;
		};
		static gravity_lock_set			= function(_lock_name, _lock_time = -1) {
			__.air.gravity_lock.set_lock(_lock_name, _lock_time);
			return self;
		};
		
		// = PRIVATE ===============
		__[$ "air"] = {};
		with (__.air) {
			static __velocity_y_apply				   = function() {
				if (__.air.velocity_y_enabled) {
					if (__.air.velocity_y > -1 && __.air.velocity_y < 1) {
						__platform_check();
					}
					else {
						// sub-pixel calculation
						var _velocity_y_sub	 =  0;
						__.air.velocity_y_sub +=  velocity_y_get(true);
							_velocity_y_sub    =  round(__.air.velocity_y_sub);
						__.air.velocity_y_sub -= _velocity_y_sub;
			
						// apply velocity_y with sub-pixel calculation
						repeat (abs(_velocity_y_sub)) {
							var _platform  = __platform_check();
							if (_platform != noone && !__collision_filter_check(_platform)) {
								__collision_vertical_apply(_platform);
								break;
							}
							else {
								__owner_adjust_y(sign(velocity_y_get(true)));
								__.collision.bounce_vertical_applied = false;
							}
						};
					}
				}
			};
			static __velocity_y_base_influences_update = function() {
				var _y_sum = 0;
				for (var _i = 0; _i < __.air.velocity_y_base_influences.get_size(); _i++) {
					var _key = __.air.velocity_y_base_influences.get_name(_i);
					_y_sum  += __.air.velocity_y_base_influences.get(_key);
				};
				__.air.velocity_y_base_influences_sum = _y_sum;
			};
			static __velocity_y_base_influences_reset  = function() {
				__.air.velocity_y_base_influences_sum = 0;
			};
			static __platform_check 				   = function() {
				/*
				// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~	//
				//	---------------											//
				//	/!\ WARNING /!\											//
				//	---------------											//
				//	this method is critical to vertical movement, and 		//
				//	necessary for features such as drop-through, as it 		//
				//	is used to handle more nuanced collision interactions.	//
				//															//
				//	CHANGE WITH CAUTION										//
				// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~	//
				*/
				if (!__.air.velocity_y_enabled) exit;
			
				var _container = noone;
				var _collision = noone;
			
					 if (sign(__.air.velocity_y) ==  1) _container = __.collision.bottom_collisions;
				else if (sign(__.air.velocity_y) == -1) _container = __.collision.top_collisions;
				
				if (_container != noone) {
					var _collision  = _container.get_instance_colliding(__.collision.object_solid);
					if (_collision !=  noone) {
						if (__.air.velocity_y < 0) {
							if (__ledge_grace_ceiling_left_check()) {
								__ledge_grace_ceiling_left_apply();
								__.collision.bounce_vertical_applied = false;
								return noone; // preserve momentum
							}
							else if (__ledge_grace_ceiling_right_check()) {
								__ledge_grace_ceiling_right_apply();
								__.collision.bounce_vertical_applied = false;
								return noone; // preserve momentum
							}
							else if (!__collision_filter_check(_collision)) {
								__collision_vertical_apply(_collision);
							}
						}
						return _collision;
					}
				}
			
				#region drop through platform interactions
				
				if (__.collision.dropthrough_force_enabled && __.air.velocity_y >= 0) {
				
					// if touching drop through, but not clipping it
					if (__standing_on_pass()) {
					
						var _collision = __get_instance_standing_on_pass();
						if (!__collision_filter_check(_collision)) {
							 __collision_vertical_apply(_collision);
					
							//// if drop through is moving, snap to top of platform
							//var _colliding = this.__collisions_bottom.get_instance_colliding(this.__object_pass);
							//var _mover	   = __instance_get_move_controller(_colliding);
							//if (_mover != undefined) {
							//	velocity_x_add_influence(_colliding.id, _mover.velocity_x);
							//	velocity_y_add_influence(_colliding.id, _mover.velocity_y);
							//  __owner_set_y(_colliding.bbox_top + _mover.velocity_y);
							//}
							return _collision;
						}
					}	
					else {
						__.collision.bounce_vertical_applied = false;	
					}
				}
				
				#endregion
				
				return noone;
			};
			static __gravity_apply					   = function() {
				if (__gravity_check()) {
					__.air.velocity_y = iceberg.tween.approach(
						__.air.velocity_y, 
						__.air.velocity_y_terminal, 
						__.air.gravity
					);	
				}
			};	
			static __gravity_check					   = function() {
				return (__.air.gravity_enabled
					&&	gravity_lock_is_unlocked()
				);
			};
			static __air_acceleration_apply			   = function(_limit) {
				__.ground.velocity_x = iceberg.tween.approach(
					__.ground.velocity_x, 
					_limit, 
					__.air.acceleration
				);
			};
			static __air_friction_apply				   = function() {
				__.ground.velocity_x = iceberg.tween.approach(
					__.ground.velocity_x, 
					   0, 
					__.air.friction
				);
			};
			static __air_turn_force_apply			   = function() {
				__.ground.velocity_x = iceberg.tween.approach(
					__.ground.velocity_x, 
					   0, 
					__.air.turn_force
				);	
			};
			static __air_movement_apply				   = function(_dir = 0) {
				var _limit  = velocity_x_get_scalar() * _dir;
				if (_limit != 0) {
					if ((_dir ==  1 && __.ground.velocity_x < 0) 
					||	(_dir == -1 && __.ground.velocity_x > 0)
					) {
						__air_turn_force_apply();
					}
					__air_acceleration_apply(_limit);
				}
				if (_limit == 0 || __.air.friction_always_apply) {
					__air_friction_apply();
				}
			};
		
			velocity_y_enabled			   = _config[$ "velocity_y_enabled"		  ] ??  true;
			velocity_y_base				   = _config[$ "velocity_y_base"		  ] ??  0.00;
			velocity_y					   = _config[$ "velocity_y"				  ] ??  0.00;
			velocity_y_terminal			   = _config[$ "velocity_y_terminal"	  ] ??  4.00;
			velocity_y_override			   = _config[$ "velocity_y_override"	  ] ??  undefined;
			input_enabled				   = _config[$ "air_input_enabled"		  ] ??  true;
			acceleration				   = _config[$ "air_acceleration"		  ] ?? _self.__.ground.acceleration;
			friction					   = _config[$ "air_friction"			  ] ?? _self.__.ground.friction;
			friction_always_apply		   = _config[$ "air_friction_always_apply"] ?? _self.__.ground.friction_always_apply;
			turn_force					   = _config[$ "air_turn_force"			  ] ?? _self.__.ground.turn_force;
			gravity_enabled				   = _config[$ "gravity_enabled"		  ] ??  true;
			gravity						   = _config[$ "gravity"				  ] ??  0.60;
			
			gravity_lock				   = new IB_LockStack();
			velocity_y_base_influences	   = new IB_Collection_Struct();
			velocity_y_base_influences_sum = 0;
			velocity_y_sub				   = 0;
		};
		
		// = EVENTS ================
		on_initialize(function() {
			__.air.gravity_lock.initialize();
		});
		on_update	 (function() {
			__.air.gravity_lock.update();
		});
		on_cleanup	 (function() {
			__.air.gravity_lock.cleanup();
			__.air.velocity_y_base_influences.cleanup();
		});
		
		#endregion
		#region collision .........|
		
		// = PUBLIC ================
		static collision_filter_add			  = function(_object_index, _conditional) {
			__.collision.filter.set(_object_index, _conditional);
			return self;
		};
		static collision_filter_remove		  = function(_object_index) {
			__.collision.filter.remove(_object_index);
			return self;
		};
		static collision_filter_get_condition = function(_object_index) {
			return __.collision.filter.get(_object_index);
		};
		static collision_on_collide			  = function(_object_index, _callback) {
			__.collision.on_collide_horiz_callbacks.add(_object_index, _callback);
			__.collision.on_collide_vert_callbacks.add(_object_index, _callback);
			return self;
		};
		static collision_on_horizontal		  = function(_object_index, _callback) {
			__.collision.on_collide_horiz_callbacks.add(_object_index, _callback);
			return self;
		};
		static collision_on_vertical		  = function(_object_index, _callback) {
			__.collision.on_collide_vert_callbacks.add(_object_index, _callback);
			return self;
		};
		
		// = PRIVATE ===============
		__[$ "collision"] = {};
		with (__.collision) {
			static __collision_update					  = function() {
				__.collision.left_collisions.update();
				__.collision.right_collisions.update();
				__.collision.top_collisions.update();
				__.collision.bottom_collisions.update();	
			};
			static __collision_horizontal_apply			  = function(_collision_instance) {
				// bounce?
				if (__.collision.bounce_x_enabled) {
					if (!__.collision.bounce_horizontal_applied) {
						    velocity_x_flip(__.collision.bounce_x_mult);
						 __.collision.bounce_horizontal_applied = true;
					}
				}
				// standard collision_collision
				else if (!__pushing_check()) {
					__.ground.velocity_x = 0;	
				}
			};
			static __collision_vertical_apply			  = function(_collision_instance) {
				// bounce?
				if (__.collision.bounce_y_enabled) {
					if (!__.collision.bounce_vertical_applied) {
							velocity_y_flip(__.collision.bounce_y_mult);
						 __.collision.bounce_vertical_applied = true;
					}
				}
				// standard collision_collision
				else __.air.velocity_y = 0;	
			};
			static __collision_filter_check				  = function(_collision_instance) {
				var _filter		= false;
				var _condition  = __.collision.filter.get(_collision_instance.object_index);
				if (_condition != undefined) {
					_filter = _condition(__.owner, _collision_instance);
				}
				return _filter;
			};
			static __collision_on_collide_horiz_callbacks = function(_instance) {
				var _callbacks = __.collision.on_collide_horiz_callbacks.get_items(_instance.object_index);
				iceberg.array.for_each(_callbacks, function(_callback, _instance) {
					_callback(_instance);
				}, _instance);
			};
			static __collision_on_collide_vert_callbacks  = function(_instance) {
				var _callbacks = __.collision.on_collide_vert_callbacks.get_items(_instance.object_index);
				iceberg.array.for_each(_callbacks, function(_callback, _instance) {
					_callback(_instance);
				}, _instance);
			};
			static __dropthrough_check					  = function(_state_is = "") {
				return (__.collision.dropthrough_force_enabled
					&&	__standing_on_pass()
					&&	__input_dropthrough_pressed()
					&& (_state_is == "" || __.state.fsm.state_is(_state_is))
				);
			};
			static __dropthrough_apply					  = function() {
					__owner_adjust_y(__.collision.dropthrough_force);
			};
			static __standing_on_ground					  = function() {
				return (__standing_on_solid()
					||  __standing_on_pass()
				);
			};
			static __standing_on_solid					  = function() {
				return __.collision.bottom_collisions.did_collide(__.collision.object_solid);
			};
			static __standing_on_pass					  = function() {
				return (__.collision.bottom_collisions.did_collide (__.collision.object_pass)
					&& !__.collision.bottom_collisions.is_colliding(__.collision.object_pass, -1)
				);
			};
			static __touching_wall_left					  = function() {
				return __.collision.left_collisions.did_collide(__.collision.object_solid);
			};
			static __touching_wall_right				  = function() {
				return __.collision.right_collisions.did_collide(__.collision.object_solid);
			};
			static __touching_ceiling					  = function() {
				return __.collision.top_collisions.did_collide(__.collision.object_solid);	
			};
			static __get_instance_standing_on_solid		  = function() {
				if (__standing_on_solid()) {
					return __.collision.bottom_collisions.get_instance_colliding(__.collision.object_solid);
				}
				return noone;
			};
			static __get_instance_standing_on_pass		  = function() {
				if (__standing_on_pass()) {
					return __.collision.bottom_collisions.get_instance_colliding(__.collision.object_pass);
				}
				return noone;
			};
			
			// can the mover manually push themselves downwards 
			// through dropthrough objects with input. if this is
			// disabled, collisions may still be recognized, but 
			// instance will not be able to push themselves through.
			dropthrough_force_enabled  = _config[$ "collision_dropthrough_force_enabled"] ?? true;
			dropthrough_force		   = _config[$ "collision_dropthrough_force"		] ?? 1;
	
			// does mover recognize collisions with dropthrough 
			// objects. if this is disabled, no collisions will
			// be recognized.
			dropthrough_enabled		   = _config[$ "collision_dropthrough_enabled" ] ?? true;
	
			bounce_x_enabled		   = _config[$ "collision_bounce_x_enabled"	   ] ?? false;
			bounce_x_mult			   = _config[$ "collision_bounce_x_mult"	   ] ?? 1.00;
			bounce_y_enabled		   = _config[$ "collision_bounce_y_enabled"	   ] ?? false;
			bounce_y_mult			   = _config[$ "collision_bounce_y_mult"	   ] ?? 1.00;
			
			filter					   = new IB_Collection_Struct();
			instances				   = {};
			object_solid			   = IB_Object_Platformer_Solid;
			object_pass				   = IB_Object_Platformer_Pass;
			on_collide_callbacks	   = new IB_Collection_Set();
			on_collide_horiz_callbacks = new IB_Collection_Set();
			on_collide_vert_callbacks  = new IB_Collection_Set();
			
			var _collisions_config	   = { owner: _self, instance: _self.get_owner(), };
			left_collisions			   = new _IB_MoveController_Platformer_Collisions("left",	_collisions_config);
			right_collisions		   = new _IB_MoveController_Platformer_Collisions("right",	_collisions_config);
			top_collisions			   = new _IB_MoveController_Platformer_Collisions("top",	_collisions_config);
			bottom_collisions		   = new _IB_MoveController_Platformer_Collisions("bottom", _collisions_config);
			bounce_horizontal_applied  = false;
			bounce_vertical_applied	   = false;
		};
			
		// = EVENTS ================
		on_initialize(function() {
			__.collision.left_collisions.initialize();
			__.collision.right_collisions.initialize();
			__.collision.top_collisions.initialize();
			__.collision.bottom_collisions.initialize();
		});
		on_cleanup   (function() {
			__.collision.left_collisions.cleanup();
			__.collision.right_collisions.cleanup();
			__.collision.top_collisions.cleanup();
			__.collision.bottom_collisions.cleanup();
		});
		
		#endregion
		#region jump ..............|
		
		// = PUBLIC ================
		static jump					 = function(_jump_velocity = __.jump.velocity, _apply_decay = __.jump.multi_decay_enabled, _count_cost = __.jump.count_cost, _state_target = "jump") {
		
			// this method exists simply as a way to force 
			// the jump behavior from external sources. and 
			// this method should not be used as the default 
			// means to invoke jumping as it skips past the 
			// pre-wired state-transition-triggers.
			
			////////////////////////////////////////////////
			__jump_enter(_jump_velocity, _apply_decay, _count_cost);
			
			// do state transition if the state passed in is
			// defined and we're not already in that state.
			if (_state_target != __.state.fsm.get_current_state())
			{
				__.state.fsm.change(_state_target);
			}
		};
		static jump_on_start		 = function(_callback, _data = undefined) {
			array_push(__.jump.on_start_callbacks, {
				callback: _callback,
				data:	  _data,
			});
			return self;
		};
		static jump_lock_is_locked	 = function() {
			return __.jump.lock.is_locked();
		};
		static jump_lock_is_unlocked = function() {
			return __.jump.lock.is_unlocked();
		};
		static jump_lock_remove		 = function(_lock_name) {
			__.jump.lock.remove_lock(_lock_name);
			return self;
		};
		static jump_lock_set		 = function(_lock_name, _lock_time = -1) {
			__.jump.lock.set_lock(_lock_name, _lock_time);
			return self;
		};
		
		// = PRIVATE ===============
		__[$ "jump"] = {};
		with (__.jump) {
			static __jump_check			 = function(_state_is = "") {
				return (__.jump.enabled
					&&	__.jump.count == 0
					&&	__input_jump_pressed()
					&&  jump_lock_is_unlocked()
					&& (_state_is == "" || __.state.fsm.state_is(_state_is))
				);
			};
			static __jump_multi_check	 = function(_state_is = "") {
				return (__.jump.enabled
					&&	__.jump.multi_enabled
					&&	__.jump.count > 0
					&&	__.jump.count < __.jump.multi_max
					&&	__input_jump_pressed()
					&& (_state_is == "" || __.state.fsm.state_is(_state_is))
				);
			};
			static __jump_coyote_check	 = function(_state_is = "") {
				return (__.jump.enabled
					&&	__.jump.coyote_time_enabled
					&&	__.jump.coyote_time_timer > 0
					&&	__.jump.count == 0
					&&	__input_jump_pressed()
					&& (_state_is == "" || __.state.fsm.state_is(_state_is))
				);
			};
			static __jump_buffer_check	 = function(_state_is = "") {
				return (__.jump.enabled
					&&	__.jump.input_buffer_enabled
					&&	__.jump.input_buffer_timer > 0
					&&	__input_jump_down()
					&& (_state_is == "" || __.state.fsm.state_is(_state_is))
				);
			};
			
			static __jump_enter			 = function(_jump_velocity, _apply_decay, _count_cost) {
				__jump_apply(_jump_velocity, _apply_decay);
				__.jump.coyote_time_timer  = -1;
				__.jump.input_buffer_timer = -1;
				__.jump.count			  += _count_cost;
				__jump_on_callbacks();
			};
			static __jump_apply			 = function(_jump_velocity, _apply_decay) {
				static __get_jump_multi_decay = function(_jump_velocity) {
					var _decay = 0;
					if (__.jump.multi_decay_enabled) {
						if (__.jump.multi_decay_after > -1 && __.jump.count > __.jump.multi_decay_after) {
							_decay  = __.jump.multi_decay  * (__.jump.count - __.jump.multi_decay_after);
							_decay *= _jump_velocity;
						}
					}
					return abs(_decay);
				};
				////////////////////////////////////////////////////////////
				_jump_velocity	  =  abs(_jump_velocity) * -1;
				__.air.velocity_y = _jump_velocity;	
				if (_apply_decay) __.air.velocity_y += __get_jump_multi_decay(_jump_velocity);	
			};
			static __jump_apply_variable = function(_jump_variable_mult = __.jump.variable_mult) {
				__.air.velocity_y *= _jump_variable_mult;
			};
			static __jump_reset			 = function() {
				__.jump.count			  = 0;	
				__.jump.coyote_time_timer = 0;
			};	
			static __jump_on_callbacks	 = function() {
				iceberg.array.for_each(
					__.jump.on_start_callbacks, 
					function(_callback) {
						_callback.callback(_callback.data);
					},
				);
			};
			
			enabled				 = _config[$ "jump_enabled"				] ?? true;
			velocity			 = _config[$ "jump_velocity"			] ?? 10;
			count_cost			 = _config[$ "jump_count_cost"			] ?? 1;
			variable_enabled	 = _config[$ "jump_variable_enabled"	] ?? true;
			variable_mult		 = _config[$ "jump_variable_mult"		] ?? 0.25;
			multi_enabled		 = _config[$ "jump_multi_enabled"		] ?? true;
			multi_max			 = _config[$ "jump_multi_max"			] ?? 1;
			multi_decay			 = _config[$ "jump_multi_decay"			] ?? 0.10;
			multi_decay_after	 = _config[$ "jump_multi_decay_after"	] ?? 1;
			multi_decay_enabled	 = _config[$ "jump_multi_decay_enabled" ] ?? true;
			coyote_time_enabled	 = _config[$ "jump_coyote_time_enabled" ] ?? true;
			coyote_time			 = _config[$ "jump_coyote_time"			] ?? 20;
			input_buffer_enabled = _config[$ "jump_input_buffer_enabled"] ?? true;
			input_buffer_time	 = _config[$ "jump_input_buffer_time"	] ?? 30;
			
			count				 =  0;
			coyote_time_timer	 = -1;
			input_buffer_timer	 = -1;
			lock				 =  new IB_LockStack();
			on_start_callbacks	 =  array_create(0);
		};
		
		// = EVENTS ================
		on_initialize(function() {
			__.jump.lock.initialize();
		});
		on_update	 (function() {
			__.jump.lock.update();
		});
		on_cleanup	 (function() {
			__.jump.lock.cleanup();
		});
		
		#endregion
		#region apex ..............|
		
		// = PRIVATE ===============
		__[$ "apex"] = {};
		with (__.apex) {
			static __apex_modifier_fast_fall_check   = function() {
				return ( __.apex.modifiers_enabled
					&&	 __.apex.fast_fall_enabled
					&& (!__.apex.fast_fall_uses_input || __input_fast_fall_down())
				);
			};
			static __apex_modifier_fast_fall_apply   = function() {
				if (__apex_modifier_fast_fall_check()) {
					__.air.velocity_y += __.apex.fast_fall_force;
				}
			};
			static __apex_modifier_speed_boost_check = function() {
				return (__.apex.modifiers_enabled
					&&	__.apex.speed_boost_enabled
				);
			};
			static __apex_modifier_speed_boost_apply = function() {
				if (__apex_modifier_speed_boost_check()) {
					__.ground.velocity_x += __.apex.speed_boost * (__input_move_right_down() - __input_move_left_down());
				}
			};
		
			modifiers_enabled	  = _config[$ "apex_modifiers_enabled"	  ] ?? true;
			on_wall_jumps_enabled = _config[$ "apex_on_wall_jumps_enabled"] ?? false;
			fast_fall_enabled	  = _config[$ "apex_fast_fall_enabled"	  ] ?? true;
			fast_fall_force		  = _config[$ "apex_fast_fall_force"	  ] ?? 2;
			fast_fall_uses_input  = _config[$ "apex_fast_fall_uses_input" ] ?? true;
			speed_boost_enabled	  = _config[$ "apex_speed_boost_enabled"  ] ?? false;
			speed_boost			  = _config[$ "apex_speed_boost"		  ] ?? 3;
		};
		
		#endregion
		#region sprint ............|
		
		// = PUBLIC ================
		static sprint_lock_is_locked   = function() {
			return __.sprint.lock.is_locked();
		};
		static sprint_lock_is_unlocked = function() {
			return __.sprint.lock.is_unlocked();
		};
		static sprint_lock_remove	   = function(_lock_name) {
			__.sprint.lock.remove_lock(_lock_name);
			return self;
		};
		static sprint_lock_set		   = function(_lock_name, _lock_duration = -1) {
			__.sprint.lock.set_lock(_lock_name, _lock_duration);
			return self;
		};
		
		// = PRIVATE ===============
		__[$ "sprint"] = {};
		with (__.sprint) {
			static __sprint_check = function(_state_is = "") {
				return (__.sprint.enabled
					&&	__input_sprint_down()
					&&  __input_move_check()
					&&  sprint_lock_is_unlocked()
					&& (_state_is == "" || __.state.fsm.state_is(_state_is))
				);
			};
			static __sprint_apply = function() {
				if (!velocity_x_has_scalar("__ib_sprint_mult")) {
					 velocity_x_add_scalar("__ib_sprint_mult", __.sprint.x_mult);
				}
			};
			static __sprint_reset = function() {
				velocity_x_remove_scalar("__ib_sprint_mult");
			};
		
			enabled = _config[$ "sprint_enabled"] ?? true;
			x_mult  = _config[$ "sprint_x_mult" ] ?? 1.50;
			lock	=  new IB_LockStack();
		};
			
		// = EVENTS ================
		on_initialize(function() {
			__.sprint.lock.initialize();
		});
		on_update	 (function() {
			__.sprint.lock.update();
		});
		on_cleanup   (function() {
			__.sprint.lock.cleanup();
		});
		
		#endregion
		#region strafe ............|
		
		// = PUBLIC ================
		static strafe_lock_is_locked   = function() {
			return __.strafe.lock.is_locked();
		};
		static strafe_lock_is_unlocked = function() {
			return __.strafe.lock.is_unlocked();
		};
		static strafe_lock_remove	   = function(_lock_name) {
			__.strafe.lock.remove_lock(_lock_name);
			return self;
		};
		static strafe_lock_set		   = function(_lock_name, _lock_time = -1) {
			__.strafe.lock.set_lock(_lock_name, _lock_time);
			return self;
		};
		
		// = PRIVATE ===============
		__[$ "strafe"] = {};
		with (__.strafe) {
			static __strafe_check = function(_state_is = "") {
				return (__.strafe.enabled
					&&	__input_strafe_pressed()
					&&  __input_move_check()
					&&	strafe_lock_is_unlocked()
					&& (_state_is == "" || __.state.fsm.state_is(_state_is))
				);
			};
			static __strafe_apply = function() {
				if (!velocity_x_has_scalar("__ib_strafe_mult")) {
					 velocity_x_add_scalar("__ib_strafe_mult", __.strafe.x_mult);
				}
				__.strafe.active = true;
			};
			static __strafe_reset = function() {
				velocity_x_remove_scalar("__ib_strafe_mult");
				__.strafe.active = false;
			};
		
			enabled = _config[$ "strafe_enabled"] ?? true;
			x_mult  = _config[$ "strafe_x_mult" ] ?? 0.50;
			active  =  false;
			lock	=  new IB_LockStack();
		};
			
		// = EVENTS ================
		on_initialize(function() {
			__.strafe.lock.initialize();
		});
		on_update	 (function() {
			__.strafe.lock.update();
		});
		on_cleanup   (function() {
			__.strafe.lock.cleanup();
		});
		
		#endregion
		#region slope .............|
		
		// = PUBLIC ================
		static ground_incline_get = function() {
			return __.slope.ground_incline;
		};
		
		// = PRIVATE ===============
		__[$ "slope"] = {};
		with (__.slope) {
			static __slope_up_mult_check	= function(_state_is = "") {
				return (__.ground.velocity_x_enabled
					&&	__.slope.up_mult_enabled
					&&	sign(__.slope.ground_incline) == sign(velocity_x_get(true))
					&& (_state_is == "" || __.state.fsm.state_is(_state_is))
				);
			};
			static __slope_down_mult_check	= function(_state_is = "") {
				return (__.ground.velocity_x_enabled
					&&	__.slope.down_mult_enabled
					&&	sign(__.slope.ground_incline) == -sign(velocity_x_get(true))
					&& (_state_is == "" || __.state.fsm.state_is(_state_is))
				);
			};
			static __slope_up_mult_apply	= function() {
				if (!velocity_x_has_scalar("__ib_slope_up_mult")) {
					 velocity_x_add_scalar("__ib_slope_up_mult", __.slope.up_x_mult);
				}
			};
			static __slope_down_mult_apply	= function() {
				if (!velocity_x_has_scalar("__ib_slope_up_mult")) {
					 velocity_x_add_scalar("__ib_slope_up_mult", __.slope.down_x_mult);	
				}
			};
			static __slope_adjustment_apply	= function(_velocity_x = velocity_x_get(true)) {
				if (__.slope.enabled && __.state.fsm.state_is("grounded")) {
					var _self = self;
					with (__.owner) {
						// upward slopes //
						for (var _height = _self.__.slope.height_max; _height >= 0; _height--) {
							var _do_slope_adjustment = true;
							for (var _sub_height = _height, _i = _sub_height; _i >= 0; _i--) {
								// first iteration
								if (_i == _sub_height) {
									if (place_meeting(x + sign(_velocity_x), y - _i, _self.__.collision.object_solid)) {
										_do_slope_adjustment = false;
										break;
									}
								}
								// all other iterations
								else if (!place_meeting(x + sign(_velocity_x), y - _i, _self.__.collision.object_solid)) {
									_do_slope_adjustment = false;
									break;
								}
							};
							if (_do_slope_adjustment) {
								_self.__owner_adjust_y(-_sub_height);
								break;
							}
						};
				
						// downward slopes //
						for (var _height = _self.__.slope.height_max; _height >= 0; _height--) {
							var _do_slope_adjustment = true;
							for (var _sub_height = _height, _i = _sub_height; _i >= 0; _i--) {
								// first iteration
								if (_i == _sub_height) {
									if (place_meeting(x + sign(_velocity_x), y + _i,	 _self.__.collision.object_solid)
									|| !place_meeting(x + sign(_velocity_x), y + _i + 1, _self.__.collision.object_solid)
									) {
										_do_slope_adjustment = false;
										break;
									}
								}
								// all other iterations
								else if (place_meeting(x + sign(_velocity_x), y + _i, _self.__.collision.object_solid)) {
									_do_slope_adjustment = false;
									break;
								}
							};
							if (_do_slope_adjustment) {
								_self.__owner_adjust_y(_sub_height);
								break;
							}
						};
					};
				}
			};
			static __ground_incline_update	= function() {
				
				static _scan_distance   = 100;
				var	   _self			= self;
				
				__.slope.ground_incline = 0;
				
				with (__.owner) {
					var _solid_data_left  = iceberg.collision.raycast(bbox_left,  bbox_bottom, bbox_left,  bbox_bottom + _scan_distance, _self.__.collision.object_solid, true, false);
					var _solid_data_right = iceberg.collision.raycast(bbox_right, bbox_bottom, bbox_right, bbox_bottom + _scan_distance, _self.__.collision.object_solid, true, false);
				}
				if (_solid_data_left.id != noone && _solid_data_right.id != noone) {
					__.slope.ground_incline = _solid_data_left.y - _solid_data_right.y;
				}
			};
			static __slope_up_mult_reset	= function() {
				velocity_x_remove_scalar("__ib_slope_up_mult");	
			};
			static __slope_down_mult_reset	= function() {
				velocity_x_remove_scalar("__ib_slope_down_mult");	
			};
			
			enabled			  = _config[$ "slope_enabled"		   ] ?? true;
			height_max		  = _config[$ "slope_height_max"	   ] ?? 5.00;
			up_mult_enabled	  = _config[$ "slope_up_mult_enabled"  ] ?? true;
			up_x_mult		  = _config[$ "slope_up_x_mult"		   ] ?? 0.90;
			down_mult_enabled = _config[$ "slope_down_mult_enabled"] ?? true;
			down_x_mult		  = _config[$ "slope_down_x_mult"	   ] ?? 1.10;
			ground_incline	  = 0;
		};
		
		#endregion
		#region wall_slide ........|
		
		// = PUBLIC ================
		static wall_slide_lock_is_locked   = function() {
			return __.wall_slide.lock.is_locked();
		};
		static wall_slide_lock_is_unlocked = function() {
			return __.wall_slide.lock.is_unlocked();
		};
		static wall_slide_lock_remove	   = function(_lock_name) {
			__.wall_slide.lock.remove_lock(_lock_name);
			return self;
		};
		static wall_slide_lock_set		   = function(_lock_name, _lock_time = -1) {
			__.wall_slide.lock.set_lock(_lock_name, _lock_time);
			return self;
		};
		static wall_slide_on_start		   = function(_callback, _data = undefined) {
			array_push(__.wall_slide.on_start_callbacks, {
				callback: _callback,
				data:	  _data,
			});
			return self;
		};
		static wall_slide_on_stop		   = function(_callback, _data = undefined) {
			array_push(__.wall_slide.on_stop_callbacks, {
				callback: _callback,
				data:	  _data,
			});
			return self;
		};
		
		// = PRIVATE ===============
		__[$ "wall_slide"] = {};
		with (__.wall_slide) {
			static __wall_slide_check		  = function(_state_is = "") {
				// right
				if (__.sprite.facing == 1) {
					return (__.wall_slide.enabled
						&&(!__.wall_slide.time_limit_enabled || !__.wall_slide.limit_used_up)
						&&  __.air.velocity_y > 0
						&&    wall_slide_lock_is_unlocked()
						&&	__touching_wall_right()
						&& !__standing_on_ground()
						&&	__input_move_right_down()
						&& !__input_move_left_down()
						&& (_state_is == "" || __.state.fsm.state_is(_state_is))
					);
				}
				// left
				else {
					return (__.wall_slide.enabled
						&&(!__.wall_slide.time_limit_enabled || !__.wall_slide.limit_used_up)
						&&	__.air.velocity_y > 0
						&&    wall_slide_lock_is_unlocked()
						&&	__touching_wall_left()
						&& !__standing_on_ground()
						&&	__input_move_left_down()
						&& !__input_move_right_down()
						&& (_state_is == "" || __.state.fsm.state_is(_state_is))
					);
				}
			};
			static __wall_slide_release_check = function(_state_is = "") {
				if (_state_is == "" || __.state.fsm.state_is(_state_is)) {
					if (__.wall_slide.time_limit_enabled && __.wall_slide.limit_used_up) {
						return true;	
					}
					if (__.sprite.facing == 1) {
						return ((!__input_move_right_down() || __input_move_left_down())
							||	 !__.collision.right_collisions.did_collide(__.collision.object_solid)
						);
					}
					else {
						return ((!__input_move_left_down() || __input_move_right_down())
							||	 !__.collision.left_collisions.did_collide(__.collision.object_solid)
						);
					}	
				}
				return false;
			};
			static __wall_slide_gravity_apply = function() {
				if (__.wall_slide.enabled
				&&	__.wall_slide.gravity_enabled
				) {
					__.air.velocity_y = iceberg.tween.approach(
						__.air.velocity_y, 
						__.wall_slide.gravity_y_limit, 
						__.wall_slide.gravity
					);		
				}
			};
			static __wall_slide_reset		  = function() {
				__.wall_slide.limit_used_up = false;	
			};	
			static __wall_slide_on_start	  = function() {
				iceberg.array.for_each(__.wall_slide.on_start_callbacks, function(_callback) {
					_callback.callback(_callback.data);
				});
			};
			static __wall_slide_on_stop		  = function() {
				iceberg.array.for_each(__.wall_slide.on_stop_callbacks, function(_callback) {
					_callback.callback(_callback.data);
				});
			};
			
			enabled			   = _config[$ "wall_slide_enabled"			  ] ?? true;
			gravity_enabled	   = _config[$ "wall_slide_gravity_enabled"   ] ?? true;
			gravity			   = _config[$ "wall_slide_gravity"			  ] ?? 0.20;
			gravity_y_limit	   = _config[$ "wall_slide_gravity_y_limit"	  ] ?? 1.00;
			time_limit_enabled = _config[$ "wall_slide_time_limit_enabled"] ?? false;
			time_limit		   = _config[$ "wall_slide_time_limit"		  ] ?? 10;
			time_limit_timer   = -1;
			limit_used_up	   =  false;
			lock			   =  new IB_LockStack();
			on_start_callbacks =  array_create(0);
			on_stop_callbacks  =  array_create(0);
		};
			
		// = EVENTS ================
		on_initialize(function() {
			__.wall_slide.lock.initialize();
		});
		on_update	 (function() {
			__.wall_slide.lock.update();
		});
		on_cleanup	 (function() {
			__.wall_slide.lock.cleanup();
		});
		
		#endregion
		#region wall_jump .........|
		
		// = PUBLIC ================
		static wall_jump_on_start		  = function(_callback, _data = undefined) {
			array_push(__.wall_jump.on_start_callbacks, {
				callback: _callback,
				data:	  _data,
			});
			return self;
		};
		static wall_jump_lock_is_locked   = function() {
			return __.wall_jump.lock.is_locked();
		};
		static wall_jump_lock_is_unlocked = function() {
			return __.wall_jump.lock.is_unlocked();
		};
		static wall_jump_lock_remove	  = function(_lock_name) {
			return __.wall_jump.lock.remove_lock(_lock_name);
		};
		static wall_jump_lock_set		  = function(_lock_name, _lock_time = -1) {
			return __.wall_jump.lock.set_lock(_lock_name, _lock_time);
		};
		
		// = PRIVATE ===============
		__[$ "wall_jump"] = {};
		with (__.wall_jump) {
			static __wall_jump_check			  = function(_state_is = "") {
				return ( __.wall_jump.enabled
					&& (!__.wall_jump.count_limit_enabled || __.wall_jump.count < __.wall_jump.count_limit)
					&&	 wall_jump_lock_is_unlocked()
					&&	__input_wall_jump_pressed()
					&& (_state_is == "" || __.state.fsm.state_is(_state_is))
				);
			};
			static __wall_jump_apply			  = function(_wall_jump_velocity = __.wall_jump.velocity) {
				static __get_wall_jump_decay = function(_wall_jump_velocity = __.wall_jump.velocity) {
					var _decay = 0;
					if (__.wall_jump.decay_enabled) {
						if (__.wall_jump.decay_after > -1 && __.wall_jump.count > __.wall_jump.decay_after) {
							_decay  = __.wall_jump.decay * (__.wall_jump.count  - __.wall_jump.decay_after);
							_decay *=   _wall_jump_velocity;
						}	
					}
					return _decay;
				};
				////////////////////////////////////
				var _velocity = -_wall_jump_velocity + __get_wall_jump_decay(_wall_jump_velocity);
				
				__.air.velocity_y = _velocity;
				
				// apply x force 
				if (__.wall_jump.x_velocity != 0 && _velocity < 0) {
					__.ground.velocity_x = __.wall_jump.x_velocity  * -__.sprite.facing;
				}
				__.wall_jump.count++;
			
				// lock input
				if (__.wall_jump.input_lock_enabled) {
					input_lock_set("__wall_jump", round(__.wall_jump.input_lock_time));	
				}
					
				__wall_jump_on_start_callbacks();
			};
			static __wall_jump_reset			  = function() {
				__.wall_jump.count = 0;				
			};
			static __wall_jump_on_start_callbacks = function() {
				iceberg.array.for_each(
					__.wall_jump.on_start_callbacks, 
					function(_callback) {
						_callback.callback(_callback.data);
					},
				);
			};
			
			enabled				= _config[$ "wall_jump_enabled"			   ] ?? true;
			velocity			= _config[$ "wall_jump_velocity"		   ] ?? _self.__.jump.velocity;
			x_velocity			= _config[$ "wall_jump_x_velocity"		   ] ?? 5.00;
			variable_enabled	= _config[$ "wall_jump_variable_enabled"   ] ?? _self.__.jump.variable_enabled;
			variable_mult		= _config[$ "wall_jump_variable_mult"	   ] ?? _self.__.jump.variable_mult;
			count_limit_enabled = _config[$ "wall_jump_count_limit_enabled"] ?? true;
			count_limit			= _config[$ "wall_jump_max"				   ] ?? 3;
			count_cost			= _config[$ "wall_jump_count_cost"		   ] ?? 1;
			decay_enabled		= _config[$ "wall_jump_decay_enabled"	   ] ?? true;
			decay				= _config[$ "wall_jump_decay"			   ] ?? 0.10;
			decay_after			= _config[$ "wall_jump_decay_after"		   ] ?? 1;
			input_lock_enabled	= _config[$ "wall_jump_input_lock_enabled" ] ??  false;
			input_lock_time		= _config[$ "wall_jump_input_lock_time"	   ] ?? -1; // if less than 0, locked until landing
			count				=  0;
			lock				=  new IB_LockStack();
			on_start_callbacks	=  array_create(0);
		};
		
		// = EVENTS ================
		on_initialize(function() {
			__.wall_jump.lock.initialize();
		});
		on_update	 (function() {
			__.wall_jump.lock.update();
		});
		on_cleanup	 (function() {
			__.wall_jump.lock.cleanup();
		});
		
		#endregion
		#region ledge .............|
		
		// = PUBLIC ================
		static ledge_hang_lock_is_locked   = function() {
			return __.ledge.hang_lock.is_locked();
		};
		static ledge_hang_lock_is_unlocked = function() {
			return __.ledge.hang_lock.is_unlocked();
		};
		static ledge_hang_lock_remove	   = function(_lock_name) {
			__.ledge.hang_lock.remove_lock(_lock_name);
			return self;
		};
		static ledge_hang_lock_set		   = function(_lock_name, _lock_time = -1) {
			__.ledge.hang_lock.set_lock(_lock_name, _lock_time);
			return self;
		};
		static ledge_hang_on_start		   = function(_callback, _data = undefined) {
			array_push(__.ledge.hang_on_start, {
				callback: _callback,
				data:	  _data,
			});
			return self;
		};
		static ledge_hang_on_stop		   = function(_callback, _data = undefined) {
			array_push(__.ledge.hang_on_stop, {
				callback: _callback,
				data:	  _data,
			});
			return self;
		};
		
		// = PRIVATE ===============
		__[$ "ledge"] = {};
		with (__.ledge) {
			static __ledge_grace_ceiling_left_check  = function(_state_is = "") {
			
				// dont need to check for a collision with head, since this is only 
				// getting called once a collision with head has already been registered
			
				return ( __.ledge.grace_enabled
					&&	 __.ledge.grace_ceiling_enabled
					&& (!__.ledge.grace_ceiling_needs_input || __input_move_left_down())
					&&  !__.collision.top_collisions.is_colliding(__.collision.object_solid, 1, -__.ledge.grace_ceiling_threshold)
					&& (_state_is == "" || __.state.fsm.state_is(_state_is))
				);
			};
			static __ledge_grace_ceiling_right_check = function(_state_is = "") {
			
				// dont need to check for a collision with head, since this is only 
				// getting called once a collision with head has already been registered
			
				return ( __.ledge.grace_enabled
					&&	 __.ledge.grace_ceiling_enabled
					&& (!__.ledge.grace_ceiling_needs_input || __input_move_right_down())
					&&  !__.collision.top_collisions.is_colliding(__.collision.object_solid, 1, __.ledge.grace_ceiling_threshold)
					&& (_state_is == "" || __.state.fsm.state_is(_state_is))
				);
			};
			static __ledge_grace_jump_up_check		 = function(_state_is = "") {
				if (__.ledge.grace_enabled
				&&	__.ledge.grace_jump_up_enabled
				) {
					if (__.sprite.facing == 1) {
						return (__input_move_right_down()
							&&  __touching_wall_right()
							&& !__.collision.right_collisions.is_colliding(__.collision.object_solid, 1, -__.ledge.grace_jump_up_threshold)
							&& (_state_is == "" || __.state.fsm.state_is(_state_is))
						);
					}
					else {
						return (__input_move_left_down()
							&&  __touching_wall_left()
							&& !__.collision.left_collisions.is_colliding(__.collision.object_solid, 1, -__.ledge.grace_jump_up_threshold)
							&& (_state_is == "" || __.state.fsm.state_is(_state_is))
						);
					}
				}
				return false;
			};
			static __ledge_grace_ceiling_left_apply  = function() {
				static _x_margin = 1;
				while (__.collision.top_collisions.is_colliding(__.collision.object_solid, 1, _x_margin)) {
					__owner_adjust_x(-1);
				}
			};
			static __ledge_grace_ceiling_right_apply = function() {
				static _x_margin = 1;
				while (__.collision.top_collisions.is_colliding(__.collision.object_solid, 1, -_x_margin)) {
					__owner_adjust_x(1);
				}
			};
			static __ledge_grace_jump_up_apply		 = function() {
				static _clearance = 1;
				var _self = self;
				with (__.owner) {
					while (place_meeting(x + _self.__.sprite.facing, bbox_bottom + _clearance, _self.__.collision.object_solid)) {
						y--;
					};
					x += _self.__.sprite.facing;
				};
			};
			static __ledge_hang_solid_check			 = function(_state_is = "") {
				if (__.sprite.facing == 1 && __input_move_right_down()) {
					var _instance = __.collision.right_collisions.get_instance_colliding(__.collision.object_solid, __.ledge.hang_catch_threshold_x);
					if (_instance != noone
						&&	__.collision.top_collisions.is_colliding(__.collision.object_solid, __.ledge.hang_catch_threshold_y_bottom, __.ledge.hang_catch_threshold_x)
						&& !__.collision.top_collisions.is_colliding(__.collision.object_solid, __.ledge.hang_catch_threshold_y_top,	__.ledge.hang_catch_threshold_x)
						&& (_state_is == "" || __.state.fsm.state_is(_state_is))
					) {
						__.ledge.hang_instance = _instance;
						return true;	
					}
				}
				else if (__.sprite.facing == -1 && __input_move_left_down()) {
					var _instance = __.collision.left_collisions.get_instance_colliding(__.collision.object_solid, __.ledge.hang_catch_threshold_x);
					if (_instance != noone
						&&	__.collision.top_collisions.is_colliding(__.collision.object_solid, __.ledge.hang_catch_threshold_y_bottom, -__.ledge.hang_catch_threshold_x)
						&& !__.collision.top_collisions.is_colliding(__.collision.object_solid, __.ledge.hang_catch_threshold_y_top,	-__.ledge.hang_catch_threshold_x)
						&& (_state_is == "" || __.state.fsm.state_is(_state_is))
					) {
						__.ledge.hang_instance = _instance;
						return true;
					}
				}
				return false;
			};
			static __ledge_hang_pass_check			 = function(_state_is = "") {
				if (__.sprite.facing == 1 && __input_move_right_down()) {
					var _instance = __.collision.right_collisions.get_instance_colliding(__.collision.object_pass, __.ledge.hang_catch_threshold_x);
					if (_instance != noone
						&& !__.collision.left_collisions.did_collide(__.collision.object_pass)
						&&	__.collision.top_collisions.is_colliding(__.collision.object_pass, __.ledge.hang_catch_threshold_y_bottom, __.ledge.hang_catch_threshold_x)
						&& !__.collision.top_collisions.is_colliding(__.collision.object_pass, __.ledge.hang_catch_threshold_y_top,	   __.ledge.hang_catch_threshold_x)
						&& (_state_is == "" || __.state.fsm.state_is(_state_is))
					) {
						__.ledge.hang_instance = _instance;
						return true;	
					}
				}
				else if (__.sprite.facing == -1 && __input_move_left_down()) {
					var _instance = __.collision.left_collisions.get_instance_colliding(__.collision.object_pass, __.ledge.hang_catch_threshold_x);
					if (_instance != noone
						&& !__.collision.right_collisions.did_collide(__.collision.object_pass)
						&&	__.collision.top_collisions.is_colliding (__.collision.object_pass, __.ledge.hang_catch_threshold_y_bottom, -__.ledge.hang_catch_threshold_x)
						&& !__.collision.top_collisions.is_colliding (__.collision.object_pass, __.ledge.hang_catch_threshold_y_top,	-__.ledge.hang_catch_threshold_x)
						&& (_state_is == "" || __.state.fsm.state_is(_state_is))
					) {
						__.ledge.hang_instance = _instance;
						return true;	
					}
				}
				return false;
			};
			static __ledge_hang_check				 = function(_state_is = "") {
				if (__.ledge.hang_enabled
				&&	ledge_hang_lock_is_unlocked()
				&& (!__.ledge.hang_time_limit_enabled || !__.ledge.hang_time_limit_used_up)
				) {
					if (__.ledge.hang_on_pass_enabled) {
						if (__ledge_hang_pass_check()
						&& (_state_is == "" || __.state.fsm.state_is(_state_is))) {
							return true;	
						}
					}
					if (__.ledge.hang_on_solid_enabled) {
						if (__ledge_hang_solid_check()
						&& (_state_is == "" || __.state.fsm.state_is(_state_is))) {
							return true;	
						}
					}
				}
				return false;
			};
			static __ledge_hang_drop_check			 = function(_state_is = "") {
				if (_state_is == "" || __.state.fsm.state_is(_state_is)) {
					if (__.ledge.hang_time_limit_enabled && __.ledge.hang_time_limit_used_up) {
						return true;	
					}
					if (__.sprite.facing == 1) {
						return (!__input_move_right_down() || __input_move_down_down());
					}
					else {
						return (!__input_move_left_down() || __input_move_down_down());
					}
				}
			};
			static __ledge_hang_jump_check			 = function(_state_is = "") {
				return (__input_jump_pressed()
					&& (_state_is == "" || __.state.fsm.state_is(_state_is))
				);
			};
			static __ledge_hang_wall_jump_check		 = function(_state_is = "") {
				if (__.sprite.facing == 1) {
					return (__input_jump_pressed()
						&&	__input_move_left_down()
						&& (_state_is == "" || __.state.fsm.state_is(_state_is))
					);
				}
				else {
					return (__input_jump_pressed()
						&&	__input_move_right_down()
						&& (_state_is == "" || __.state.fsm.state_is(_state_is))
					);
				}
			};
			static __ledge_hang_apply				 = function() {
				
				var _self = self;
				
				with (__.owner) {
					while (!place_meeting(x + _self.__.sprite.facing, y, _self.__.ledge.hang_instance)) {
						x += _self.__.sprite.facing;	
					}
					x -= _self.__.ledge.hang_position_offset_x * _self.__.sprite.facing;
					y += _self.__.ledge.hang_position_offset_y;
				};
				
				// kill all momentum
				__.ground.velocity_x = 0;
				__.air.velocity_y	 = 0;
			};
			static __ledge_hang_reset				 = function() {
				__.ledge.hang_time_limit_used_up = false;
				__.ledge.hang_instance			 = undefined;	
			};
			
			grace_enabled				  = _config[$ "ledge_grace_enabled"				   ] ?? true;
			grace_ceiling_enabled		  = _config[$ "ledge_grace_ceiling_enabled"		   ] ?? true;
			grace_ceiling_threshold		  = _config[$ "ledge_grace_ceiling_threshold"	   ] ?? 10;
			grace_ceiling_needs_input	  = _config[$ "ledge_grace_ceiling_needs_input"	   ] ?? false;
			grace_jump_up_enabled		  = _config[$ "ledge_grace_jump_up_enabled"		   ] ?? true;
			grace_jump_up_threshold		  = _config[$ "ledge_grace_jump_up_threshold"	   ] ?? 1;
			hang_enabled				  = _config[$ "ledge_hang_enabled"				   ] ?? true;
			hang_on_solid_enabled		  = _config[$ "ledge_hang_on_solid_enabled"		   ] ?? true;
			hang_on_pass_enabled		  = _config[$ "ledge_hang_on_pass_enabled"		   ] ?? true;
			hang_catch_threshold_x		  = _config[$ "ledge_hang_catch_threshold_x"	   ] ?? 5; 
			hang_catch_threshold_y_top	  = _config[$ "ledge_hang_catch_threshold_y_top"   ] ?? 5;
			hang_catch_threshold_y_bottom = _config[$ "ledge_hang_catch_threshold_y_bottom"] ?? 0;
			hang_position_offset_x		  = _config[$ "ledge_hang_position_offset_x"	   ] ?? 0; 
			hang_position_offset_y		  = _config[$ "ledge_hang_position_offset_y"	   ] ?? 0;
			hang_time_limit_enabled		  = _config[$ "ledge_hang_time_limit_enabled"	   ] ?? false;
			hang_time_limit				  = _config[$ "ledge_hang_time_limit"			   ] ?? 30;
			hang_time_limit_timer		  = -1;
			hang_time_limit_used_up		  =  false;
			hang_instance				  =  undefined;
			hang_lock					  =  new IB_LockStack();
			hang_on_start				  =  array_create(0);
			hang_on_stop				  =  array_create(0);
		};
		
		// = EVENTS ================
		on_initialize(function() {
			__.ledge.hang_lock.initialize();
		});
		on_update	 (function() {
			__.ledge.hang_lock.update();
		});
		on_cleanup	 (function() {
			__.ledge.hang_lock.cleanup();
		});
		
		#endregion
		#region pushing ...........|
		
		// = PUBLIC ================
		static pushing_filter_add			= function(_object_index, _conditional) {
			__.pushing.filter.set(_object_index, _conditional);
			return self;
		};
		static pushing_filter_remove		= function(_object_index) {
			__.pushing.filter.remove(_object_index);
			return self;
		};
		static pushing_filter_get_condition = function(_object_index) {
			return __.pushing.filter.get(_object_index);
		};
		static pushing_lock_is_locked		= function() {
			return __.pushing.lock.is_locked();
		};
		static pushing_lock_is_unlocked		= function() {
			return __.pushing.lock.is_unlocked();
		};
		static pushing_lock_remove			= function(_lock_name) {
			__.pushing.lock.remove_lock(_lock_name);
			return self;
		};
		static pushing_lock_set				= function(_lock_name, _lock_time = -1) {
			__.pushing.lock.set_lock(_lock_name, _lock_time);
			return self;
		};
		
		// = PRIVATE ===============
		__[$ "pushing"] = {};
		with (__.pushing) {
			static __pushing_check		   = function(_state_is = "") {
				if (__.pushing.enabled
				&&  __input_move_check()
				&&  pushing_lock_is_unlocked()
				&& (_state_is == "" || __.state.fsm.state_is(_state_is))) 
				{
					var _did_collide = (__.sprite.facing == 1) 
						? __.collision.right_collisions.did_collide(__.collision.object_solid)
						: __.collision.left_collisions.did_collide (__.collision.object_solid);
				
					if (_did_collide) {
						return __pushing_get_instances() > 0;
					}
				}
				return false;
			};
			static __pushing_apply		   = function() {
			
				// modify velocity_x_terminal by pushing factor
				// ...
			
				// re-populate __pushing_list
				var _push_instance_count = __pushing_get_instances();
			
				// adjust push instances' x
				for (var _i = 0; _i < _push_instance_count; _i++) {
					var _push_instance = __.pushing.list[|_i];
					var _mover		   = __instance_get_move_controller(_push_instance);
					_mover.__pushable_apply(velocity_x_get(true));
				};
			};
			static __pushing_stop_check    = function(_state_is = "") {
				if (_state_is == "" || __.state.fsm.state_is(_state_is)) {
					return (__.sprite.facing != __.pushing.dir
						|| !__input_move_check()
					//	||	ds_list_size(__.pushing.list) == 0
					);
				}
				return false;
			};
			static __pushing_filter_check  = function(_pushing_instance) {
				var _condition  = __.pushing.filter.get(_pushing_instance.object_index);
				if (_condition != undefined) {
					if (_condition(__.owner, _pushing_instance)) {
						return true;
					}
				}
				return false;
			};
			static __pushing_get_instances = function() {
			
				ds_list_clear(__.pushing.list);
				var _push_instance_count = (__.sprite.facing == 1)
					? __.collision.right_collisions.get_instance_colliding(__.collision.object_solid,,,,,__.pushing.list)
					: __.collision.left_collisions.get_instance_colliding (__.collision.object_solid,,,,,__.pushing.list);
				
				for (var _i = _push_instance_count - 1; _i >= 0; _i--) {
					var _instance = __.pushing.list[|_i];
						
					// remove instances from list that cannot be pushed
					var _instance_mover  = __instance_get_move_controller(_instance);
					if (_instance_mover == undefined || !_instance_mover.__pushable_check()) {
						ds_list_delete(__.pushing.list, _i);
						_push_instance_count--;
					}
				
					// remove instances if filtered
					if (__pushing_filter_check(_instance)) {
						ds_list_delete(__.pushing.list, _i);
						_push_instance_count--;
					}
				};
				return _push_instance_count;
			};
			
			// depending on mover's config, push logic may happen without
			// being forced into a push state, this is the case if we want 
			// to implement a "passive" pushing system.
			static __pushing_enter		   = function() {
				__.pushing.dir = __.sprite.facing;
			};
			static __pushing_step		   = function() {
				__pushing_apply();
			};
			static __pushing_leave		   = function() {
				__.pushing.dir = 0;
				ds_list_clear(__.pushing.list);
			};
			
			enabled	   = _config[$ "pushing_enabled"   ] ?? true; 
			velocity_x = _config[$ "pushing_velocity_x"] ?? _self.__.ground.velocity_x_terminal * 0.5;
			uses_state = _config[$ "pushing_uses_state"] ?? false;
			
			list	   =  ds_list_create();
			dir		   =  0;
			filter	   =  new IB_Collection_Struct();
			lock	   =  new IB_LockStack();
		};
			
		// = EVENTS ================
		on_initialize(function() {
			__.pushing.lock.initialize();
		});
		on_update	 (function() {
			__.pushing.lock.update();
		});
		on_cleanup   (function() {
			__.pushing.filter.cleanup();
			__.pushing.lock.cleanup();
			ds_list_destroy(__.pushing.list);
		});
		
		#endregion
		#region pushable ..........|
		
		// = PUBLIC ================
		static pushable_lock_is_locked	 = function() {
			return __.pushable.lock.is_locked();
		};
		static pushable_lock_is_unlocked = function() {
			return __.pushable.lock.is_unlocked();
		};
		static pushable_lock_remove		 = function(_lock_name) {
			__.pushable.lock.remove_lock(_lock_name);
			return self;
		};
		static pushable_lock_set		 = function(_lock_name, _lock_time = -1) {
			__.pushable.lock.set_lock(_lock_name, _lock_time);
			return self;
		};
		
		// = PRIVATE ===============
		__[$ "pushable"] = {};
		with (__.pushable) {
			static __pushable_check	= function(_state_is = "") {
				return (__.pushable.enabled
					&&	pushable_lock_is_unlocked()
					&& (_state_is == "" || __.state.fsm.state_is(_state_is))
				);
			};
			static __pushable_apply	= function(_x) {
				__owner_adjust_x(_x);
			};	
			
			enabled = _config[$ "pushable_enabled"] ?? true;
			lock	= new IB_LockStack();
		};
		
		// = EVENTS ================
		on_initialize(function() {
			__.pushable.lock.initialize();
		});
		on_update	 (function() {
			__.pushable.lock.update();
		});
		on_cleanup   (function() {
			__.pushable.lock.cleanup();
		});
		
		#endregion
		#region sprite ............|
		
		// = PUBLIC ================
		static sprite_facing_get			  = function() {
			return __.sprite.facing;	
		};
		static sprite_facing_set			  = function(_facing) {
			__.sprite.facing = _facing;
			return self;
		};
		static sprite_facing_lock_is_locked   = function() {
			return __.sprite.facing_lock.is_locked();
		};
		static sprite_facing_lock_is_unlocked = function() {
			return __.sprite.facing_lock.is_unlocked();
		};
		static sprite_facing_lock_remove	  = function(_lock_name) {
			__.sprite.facing_lock.remove_lock(_lock_name);
			return self;
		};
		static sprite_facing_lock_set		  = function(_lock_name, _lock_time = -1) {
			__.sprite.facing_lock.set_lock(_lock_name, _lock_time);
			return self;
		};
		static sprite_render_x_get			  = function() {
			return __.sprite.render_x;	
		};
		static sprite_render_y_get			  = function() {
			return __.sprite.render_y;	
		};
		static sprite_render_angle_get		  = function() {
			return __.sprite.render_angle;	
		};
		
		// = PRIVATE ===============
		__[$ "sprite"] = {};
		with (__.sprite) {
			static __facing_check				  = function() {
				return (!__.strafe.active
					&&	sprite_facing_lock_is_unlocked()
				);
			};
			static __facing_apply				  = function(_dir = undefined) {
				if (__facing_check()) {
					
					// default direction if not set
					_dir ??= sign(__.ground.velocity_x);			
					
					// if direction set, apply to variable
					if (_dir != 0) __.sprite.facing = _dir;	
				}
			};
			static __sprite_rotate_to_slope_apply = function() {
				if (__.sprite.rotate_to_slope) {
					__.sprite.render_angle = ground_incline_get() * 2;
					__.sprite.render_x	   = __.sprite.render_angle == 0 ? 0 : lengthdir_x(2, __.sprite.render_angle - 90);
					__.sprite.render_y	   = __.sprite.render_angle == 0 ? 0 : lengthdir_y(2, __.sprite.render_angle - 90);
				}
				else {
					__.sprite.render_angle = 0;
					__.sprite.render_x	   = 0;
					__.sprite.render_y	   = 0;	
				}
			};
			
			facing			= _config[$ "facing"] ?? 1;
			rotate_to_slope = _config[$ "sprite_rotate_to_slope_enabled"] ?? false;
			facing_lock		=  new IB_LockStack();
			render_x		=  0;
			render_y		=  0;
			render_angle	=  0;
		};
		
		// = EVENTS ================
		on_initialize(function() {
			__.sprite.facing_lock.initialize();
		});
		on_update	 (function() {
			__.sprite.facing_lock.update();
		});
		on_cleanup	 (function() {
			__.sprite.facing_lock.cleanup();
		});
		
		#endregion
	};
	
	