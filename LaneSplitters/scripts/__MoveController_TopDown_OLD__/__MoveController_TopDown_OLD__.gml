
	function old_mover() constructor {
		
		#region use case example

		#region platforms

		////mover
		//	.set_platform_object(obj_move_platform)

		#endregion
		#region paths

		//mover
		//	.set_path("test_path", 0.5,,,,function() {
		//		return keyboard_check_pressed(vk_space);
		//	})
		//	.add_path_point("test_path", x, y, 100)
		//	.add_path_point("test_path", x + 100, y, 100)
		//	.set_path_custom_action("test_path", "pause", method(mover, function() {
		//		pause_path("test_path");
		//	}))
		//	.set_path_custom_condition("test_path", "pause", function() {
		//		return keyboard_check_pressed(ord("P"));
		//	})
		//	.set_path_custom_action("test_path", "resume", method(mover, function() {
		//		resume_path("test_path");
		//	}))
		//	.set_path_custom_condition("test_path", "resume", function() {
		//		return keyboard_check_pressed(ord("C"));
		//	})

		#endregion
		#region curves

		//mover
		//	.new_curve("jump", crv_test, "crv_jump", "y")
		//	.set_curve_trigger_condition("jump", function() {
		//		//return keyboard_check_pressed(vk_space);
		//	})
		//	.set_curve_speed("jump", 0.01)
		//	.set_curve_absolute("jump", false)

		//mover
		//	.new_curve("stretch", crv_test, "crv_stretch", "image_xscale")
		//	.set_curve_trigger_condition("stretch", function() {
		//		return keyboard_check_pressed(ord("X"));
		//	})
		//	.set_curve_speed("stretch", 0.01)
		//	.set_curve_absolute("stretch", true)
	
		//mover
		//	.set_curve_custom_action("jump", "pause", method(mover, function() {
		//		pause_curve("jump");
		//	}))
		//	.set_curve_custom_condition("jump", "pause", function() {
		//		return keyboard_check_pressed(ord("P"));
		//	})
		//	.set_curve_custom_action("jump", "resume", method(mover, function() {
		//		resume_curve("jump");
		//	}))
		//	.set_curve_custom_condition("jump", "resume", function() {
		//		return keyboard_check_pressed(ord("C"));
		//	})

		#endregion

		#endregion

		with (this) {
			static __update_output = function() {
				// account for moving platforms
				var _platform_hspeed = platform != noone ? platform.hspeed : 0;
				var _platform_vspeed = platform != noone ? platform.vspeed : 0;
				
				// owner instance manipulation
				owner.hspeed = _platform_hspeed + velocity_vector.x;
				owner.vspeed = _platform_vspeed + velocity_vector.y;
			};
			static __check_platform_collision = function(_object_index) {
				with (owner) {
					return collision_point(x, y, _object_index, false, true);	
				}
			};
		};
	
		#region ~moveset~
	
		with (this) {
			static __update_moveset	= function() {
				if (moveset_enabled && this.moveset.active) {
					var _target = moveset_default;
				
					// default to platform if assigned
					if (platform != noone) {
						var _platform = this.platform.platforms.get(platform.object_index);
						if (_platform.moveset != "") {
							_target = _platform.moveset;
						}
					}
				
					// check for moveset trigger activation
					for (var _i = 0; _i < this.moveset.movesets.count; _i++) {
						var _name	 = this.moveset.movesets.names[_i];
						var _moveset = this.moveset.movesets.get(_name);
						if (_moveset.trigger_can_activate()) {
							_moveset.trigger_execute();
							 return self;
						}
					}
				
					// do moveset change/update
					if (_target != moveset) {
						change_moveset(_target);
					}
				}
				return self;
			};
		};
	 
		#endregion
		#region ~movespeed~
	
		with (this) {
			static __update_movespeed = function() {
				if (movespeed_enabled && this.movespeed.active) {
					var _target = movespeed_default;
				
					// default to platform if assigned
					if (platform != noone) {
						var _platform = this.platform.platforms.get(platform.object_index);
						if (_platform.movespeed != "") {
							_target = _platform.movespeed;
						}
					}
				
					// check for movespeed trigger activation
					for (var _i = 0; _i < this.movespeed.movespeeds.count; _i++) {
						var _name	   =  this.movespeed.movespeeds.names[_i];
						var _movespeed =  this.movespeed.movespeeds.get(_name);
						if (_movespeed.trigger_can_activate()) {
							_movespeed.trigger_execute();
							return self;
						}
					}
				
					// do movespeed change/update
					if (_target != movespeed) {
						change_movespeed(_target);
					}
				}
				return self;
			};
		};
	 
		#endregion
		#region ~platform~
	
		with (this) {
			//~members~
			platform = {
				active:	   false,
				enabled:   true,
				platforms: new ibCollectionStructExt(),
				instance:  noone,
			};
	 
			//~methods~
			static __update_platform		  = function() {
				if (platform_enabled && this.platform.active) {
					var _platform, _name, _index, _instance = noone;
					for (var _i = 0; _i < this.platform.platforms.count; _i++) {
						_name	  =  this.platform.platforms.names[_i];
						_platform =  this.platform.platforms.get(_name);
						_index    = _platform.object_index;
					 
						with (owner) { 
							_instance = __check_platform_collision(_index);
						}
						if (_instance != noone) break;
					};
					// set new platorm instance
					if (platform != _instance) {
						platform  = _instance;
					
						if (_platform.movespeed != "") change_movespeed(_platform.movespeed);
						if (_platform.moveset   != "") change_moveset(_platform.moveset);
					}
				}
				return self;
			};
			static __new_platform			  = function(_name, _config = {}) {
				var _platform = new ibMoveControllerUtilMovePlatform(_config);
				this.platform.platforms.add(_name, _platform);
				return _platform;
			};
			static __check_platform_collision = function() {};
		};
	 
		static set_platform_object	  = function(_object_index, _movespeed_name = "", _moveset_name = "") {
			var _platform = this.platform.platforms.contains(_object_index)
				? this.platform.platforms.get(_object_index)
				: __new_platform(_object_index)
			
			// assign platform data
			_platform.object_index = _object_index;
			_platform.movespeed	   = _movespeed_name;
			_platform.moveset	   = _moveset_name;
			this.platform.active   = true;
			return self;
		};
		static has_platform			  = function(_object_index) {
			return this.platform.platforms.contains(_object_index);
		};
		static remove_platform_object = function(_object_index) {
			this.platform.platforms.remove(_object_index);
		
			// check if is current
			if (platform != noone && platform.object_index == _object_index) {
				platform  = noone;
			}
		
			// disable?
			if (this.platform.platforms.is_empty()) {
				this.platform.active = false;
			}
			return self;
		};
	
		#endregion
		#region ~path~
	
		with (this) {
			//~members~
			path = {
				active:			  false,
				enabled:		  true,
				paths:			  new ibCollectionStructExt(),
				current:		  _config[$ "path"				   ] ?? "",
				check_collisions: _config[$ "path_check_collisions"] ?? false,
			};
	 
			//~methods~
			static __update_path = function() {
				if (path_enabled && this.platform.active) {
					// check for path trigger activation
					for (var _i = 0; _i < this.path.paths.count; _i++) {
						var _name = this.path.paths.names[_i];
						var _path = this.path.paths.get(_name);
						if (_path.trigger_can_activate()) {
							_path.trigger_execute();
							break;
						}
					}
				
					// update path
					if (path != "") {
						this.path.paths.get(path).update();
					}
				}
				return self;
			};
			static __new_path	 = function(_name, _config = {}) {
				_config[$ "name"	] = _name;
				_config[$ "instance"] =  owner;
				var _path = new ibMoveControllerUtilMovePath(_config);
				this.path.paths.add(_name, _path);
				return _path;
			};
			static __get_path	 = function(_name) {
				return this.path.paths.get(_name);
			};
		};
			
		static new_path					 = function(_name, _speed) {
			// because paths have multiple adjustable parameters, this method exist
			// as a simplier version to quickly define a new path, so that the params
			// can then be adjusted afterwards using the public setter methods.
			set_path(_name, _speed);
			return self;
		};
		static set_path					 = function(_name, _speed, _closed = false, _smooth = true, _endaction = path_action_stop, _condition_method = undefined, _condition_params = undefined) {
			var _path = this.path.paths.contains(_name)	
				? __get_path(_name)
				: __new_path(_name);

			_path.speed		= _speed;
			_path.closed	= _closed;
			_path.smooth	= _smooth;
			_path.endaction = _endaction;
			_path.set_position(0);
		
			// assign path condition
			if (_condition_method != undefined) {
				_path.set_trigger_condition(_condition_method, _condition_params);
			}
		
			this.path.active = true;
			broadcaster.publish("path_set", _name);
			return self;
		};
		static change_path				 = function(_name, _start = true) {
			path = _name;
			if (_start) {
				__get_path(path).start();
			}
			return self;
		};
		static remove_path				 = function(_name) {
			// cleanup path from memory
			__get_path(_name).cleanup();
			
			// remove from struct
			this.path.paths.remove(_name);
		
			// check if need to disable?
			if (this.path.paths.is_empty()) {
				this.path.active = false;
			}
			return self;
		};
		static start_path				 = function(_name) {
			__get_path(_name).start();
			return self;
		};
		static stop_path				 = function(_name) {
			__get_path(_name).stop();
			return self;
		};
		static pause_path				 = function(_name) {
			__get_path(_name).pause();
			return self;
		};
		static resume_path				 = function(_name) {
			__get_path(_name).resume();
			return self;
		};
		static add_path_point			 = function(_name, _x, _y, _speed) {
			if (this.path.paths.contains(_name)) {
				var _path = __get_path(_name);
				path_add_point(_path.path, _x, _y, _speed);
			}
			return self;
		};
		static set_path_custom_action	 = function(_path_name, _action_name, _method, _params = undefined) {
			__get_path(_path_name).new_action(_action_name, _method, _params);
			return self
		};
		static set_path_custom_condition = function(_path_name, _condition_name, _method, _params = undefined) {
			__get_path(_path_name).new_condition(_condition_name, _method, _params);
			return self
		};
	
		#endregion
		#region ~curves~
	
		with (this) {
			//~members~
			curve = {
				active:  false,
				enabled: true,
				curves:  new ibCollectionStructExt(),
				current: _config[$ "curve"] ?? "",
			};
	 
			//~methods~
			static __update_curves = function() {
				if (curve_enabled && this.curve.active) {
					// check for curve trigger activation
					for (var _i = 0; _i < this.curve.curves.count; _i++) {
						var _name  = this.curve.curves.names[_i];
						var _curve = this.curve.curves.get(_name);
						if (_curve.trigger_can_activate()) {
							_curve.trigger_execute();
							break;
						}
					}
				
					// update curve
					if (curve != "") {
						this.curve.curves.get(curve).update();
					}
				}
				return self;
			};
			static __new_curve	   = function(_name, _config = {}) {
				_config[$ "name"	] = _name;
				_config[$ "instance"] =  owner;
			
				var _curve = new ibMoveControllerUtilMoveCurve(_config);
				this.curve.curves.add(_name, _curve);
				return _curve;
			};
			static __get_curve	   = function(_name) {
				return this.curve.curves.get(_name);
			};
		};
	 
		//~methods~
		static new_curve	= function(_name, _curve_index, _channel_index, _bind_var_name) {
			// because curves have multiple adjustable parameters, this method exist
			// as a simplier version to quickly define a new curve, so that the params
			// can then be adjusted afterwards using the public setter methods.
			set_curve(_name, _curve_index, _channel_index, _bind_var_name);	
			return self;
		};
		static set_curve	= function(_name, _curve_index, _channel_index, _bind_var_name, _speed, _absolute = false, _condition_method = undefined, _condition_params = undefined) {
			var _curve = this.curve.curves.contains(_name)
				? __get_curve(_name)
				: __new_curve(_name);
			
			_curve.var_binding = _bind_var_name;
			_curve.set_curve_index(_curve_index);
			_curve.set_channel_index(_channel_index);
			_curve.set_progress(0);
		
			if (_speed			  != undefined) _curve.speed	= _speed;
			if (_absolute		  != undefined) _curve.absolute	= _absolute;	
			if (_condition_method != undefined) _curve.set_trigger_condition(_condition_method, _condition_params);
		
			this.curve.active = true;
			return self;
		};
		static change_curve	= function(_name, _start = true) {
			curve = _name;
			if (_start) {
				__get_curve(curve).start();	
			}
			return self;
		};
		static remove_curve	= function(_name) {
			__get_curve(_name).cleanup();
			this.curve.curves.remove(_name);
		
			// check if curve removing is current
			if (curve == _name) {
				curve = "";
			}
		
			// check if need to disable?
			if (this.curve.curves.is_empty()) {
				this.curve.active = false;
			}
			return self;
		};
		static start_curve	= function(_name) {
			__get_curve(_name).start();
			return self;
		};
		static stop_curve	= function(_name) {
			__get_curve(_name).stop();
			return self;
		};
		static pause_curve	= function(_name) {
			__get_curve(_name).pause();
			return self;
		};
		static resume_curve	= function(_name) {
			__get_curve(_name).resume();
			return self;
		};
	
		// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
		// because curves have so many adjustable parameters, the parameters 
		// will be exposed through these various public setter methods.
		static set_curve_index			   = function(_name, _curve_index) {
			__get_curve(_name).set_curve_index(_curve_index);
			return self;
		};
		static set_curve_channel_index	   = function(_name, _channel_index) {
			// can pass in channel_name instead of channel_index and it will get handled properly
			__get_curve(_name).set_channel_index(_channel_index);
			return self;
		};
		static set_curve_var_binding	   = function(_name, _bind_var_name) {
			__get_curve(_name).var_binding = _bind_var_name;
			return self;
		};
		static set_curve_progress		   = function(_name, _progress) {
			__get_curve(_name).progress = _progress;
			return self;
		};
		static set_curve_speed			   = function(_name, _speed) {
			__get_curve(_name).speed = _speed;
			return self;
		};
		static set_curve_absolute		   = function(_name, _absolute) {
			__get_curve(_name).absolute = _absolute;
			return self;
		};
		static set_curve_endaction		   = function(_name, _endaction) {
			__get_curve(_name).endaction = _endaction;
			return self;
		};
		static set_curve_clear_on_end	   = function(_name, _clear_on_end) {
			__get_curve(_name).clear_on_end = _clear_on_end;
			return self;
		};
		static set_curve_trigger_condition = function(_name, _method, _params = undefined) {
			__get_curve(_name).set_trigger_condition(_method, _params);
			return self;
		};
		static set_curve_custom_action	   = function(_curve_name, _action_name, _method, _params = undefined) {
			__get_curve(_curve_name).new_action(_action_name, _method, _params);
			return self
		};
		static set_curve_custom_condition  = function(_curve_name, _condition_name, _method, _params = undefined) {
			__get_curve(_curve_name).new_condition(_condition_name, _method, _params);
			return self
		};
	
		#endregion
		#region ~collisions~
	
		with (this) {
			collision = {
				object: {
					active:  false,
					enabled: true,
					indexes: new ibCollectionStructExt(),
				},
			};
	 
			//~methods~
			static __update_collision			= function() {
				#region ~collision_objects~
			
				if (collision_object_enabled && this.collision.object.active) {
					for (var _i = 0; _i < this.collision.object.indexes.count; _i++) {
						var _name		  = this.collision.object.indexes.names[_i];
						var _index		  = this.collision.object.indexes.get(_name);
						var _collide_data = __check_collision_object(_index);
						var _collided	  = _collide_data.collided_h || _collide_data.collided_v;
						if (_collided) exit;
					};
				}
			
				#endregion
			};
			static __check_collision_object		= function(_index) {
				var _collide_data = {
					collided_h: false,
					collided_v: false,
					instance_h: undefined,
					instance_v: undefined,
				};
				var _collided_h   = false;
				var _instance_h   = noone;
				var _collided_v   = false;
				var _instance_v   = noone;
			
				#region check for collisions with owners hspeed & vspeed
			
				with (owner) {
					// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
					// horizontal collision check
					_instance_h = instance_place(x + hspeed, y, _index);
					if (_instance_h != noone) {
						while (!place_meeting(x + sign(hspeed), y, _index)) {
							x += sign(hspeed);
						};
						hspeed					= 0;
						_collided_h				= true;
						_collide_data.collided_h = _collided_h;
						_collide_data.instance_h = _instance_h;
					}
				
					// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
					// vertical collision check
					_instance_v = instance_place(x, y + vspeed, _index);
					if (_instance_v != noone) {
						while (!place_meeting(x, y + sign(vspeed), _index)) {
							y += sign(vspeed);
						};
						vspeed					= 0;
						_collided_v				= true;
						_collide_data.collided_v = _collided_v;
						_collide_data.instance_v = _instance_v;
					}
				};
			
				#endregion
				#region check for collisions with paths  hspeed & vspeed
			
				if (path_check_collisions && path != "") {
				
					var _path = __get_path(path);
				
					with (owner) {
						// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
						// horizontal collision check
						_instance_h = instance_place(x + _path.this.hspeed, y, _index);
						if (_instance_h != noone) {
							while (!place_meeting(x + sign(_path.this.hspeed), y, _index)) {
								x += sign(_path.this.hspeed);
							};
							_collided_h = true;
							_path.stop();
						}
				
						// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
						// vertical collision check
						_instance_v = instance_place(x, y + _path.this.vspeed, _index);
						if (_instance_v != noone) {
							while (!place_meeting(x, y + sign(_path.this.vspeed), _index)) {
								y += sign(_path.this.vspeed);
							};
							_collided_v = true;
							_path.stop();
						}
					}
				}
				
				#endregion
			
				return _collide_data;
			};
		};
	 
		static add_collision_object	   = function(_object_index) {
			var _name = object_get_name(_object_index);
			if (!this.collision.object.indexes.contains(_name)) {
					this.collision.object.indexes.add(_name, _object_index);
			}
			this.collision.object.active = true;
			return self;
		};
		static remove_collision_object = function(_object_index) {
			var _name = object_get_name(_object_index);
			this.collision.object.indexes.remove(_name);
			if (this.collision.object.indexes.is_empty()) {
				this.collision.object.active = false;
			}
			return self;
		};
	
		#endregion
	
		static update			   = function() {
			__update_platform();
			__update_movespeed();
			__update_moveset();
			__update_accel();
			__update_fric();
			__update_speed();
			__update_steer();
			__update_motor();
			__update_path();
			__update_curves();
			__update_velocity();
			__update_movement();  // should be last movement update
			__update_collision();
			return self;
		};
	};












