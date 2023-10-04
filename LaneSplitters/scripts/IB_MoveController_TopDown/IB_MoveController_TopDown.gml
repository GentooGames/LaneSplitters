
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______  ______   ______  _____    ______   __     __   __   __    //
	// /\__  _\/\  __ \ /\  == \/\  __-. /\  __ \ /\ \  _ \ \ /\ "-.\ \   //
	// \/_/\ \/\ \ \/\ \\ \  _-/\ \ \/\ \\ \ \/\ \\ \ \/ ".\ \\ \ \-.  \  //
	//    \ \_\ \ \_____\\ \_\   \ \____- \ \_____\\ \__/".~\_\\ \_\\"\_\ //
	//     \/_/  \/_____/ \/_/    \/____/  \/_____/ \/_/   \/_/ \/_/ \/_/ //
	//                                                                    //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function IB_MoveController_TopDown(_config = {}) : IB_Base(_config) constructor {
		
		#region config {}
		
		//	config = {
		//		acceleration_rate: 0.1,					// the rate at which acceleration interpolates 
		//												// from current to terminal.
		//		acceleration_terminal: 1,				
		//		acceleration_start: 0,
		//
		//		friction_rate: 0.1,						// the rate at which friction interpolates from 
		//												// current to terminal.
		//		friction_terminal: 1,
		//		friction_start: 0,
		//
		//		motor_clear_each_frame: true,			// motor switches are stored in an array. every 
		//												// step, if there are more motor switches set to 
		//												// true than false, then the motor remains active. 
		//												// if there are more switches set to false than 
		//												// true, then the motor becomes inactive. this
		//												// toggle determines if this array should be 
		//												// cleared out each frame to make way for new 
		//												// motor_switch values to be passed in on a 
		//												// regular, frame-by-frame basis.
		//												
		//		speed_multiplier_acceleration: 0.1,		// the rate at which the speed_multiplied value
		//												// interpolates from current to terminal.
		//		speed_multiplier_terminal: 1,
		//		speed_terminal: 1,			
		//		speed_start: 0,
		//
		//		steer_clear_each_frame: true,			// steer vectores are stored in an array. every
		//												// step, the stored steer vectors are all added
		//												// together to determine the final output steer
		//												// direction. this toggle determines if this 
		//												// array should be cleared out each frame to make
		//												// way for new steer_vector inputs to be passed
		//												// in on a regular, frame-by-frame basis.
		//												
		//		velocity_terminal: -1,					// what is the absolute maximum magnitude allowed
		//												// for the velocity vector. if this is set to -1,
		//												// then there is no limit applied to the terminal
		//												// velocity vector.
		//	};
		
		#endregion
		
		////////////////////////////
		
		#region acceleration
		
		// public
		static acceleration_lock_set		 = function(_lock_name, _lock_time = -1) {
			__.acceleration.lock.set_lock(_lock_name, _lock_time);
			return self;
		};
		static acceleration_lock_remove		 = function(_lock_name) {
			__.acceleration.lock.remove_lock(_lock_name);
			return self;
		};
		static acceleration_lock_is_locked	 = function() {
			return __.acceleration.lock.is_locked();
		};
		static acceleration_lock_is_unlocked = function() {
			return __.acceleration.lock.is_unlocked();
		};
		
		// private
		__[$ "acceleration"] ??= {};
		with (__.acceleration) {
			static __acceleration_update = function() {
				if (acceleration_lock_is_unlocked()) {
					__.acceleration.value = lerp(
						__.acceleration.value,
						__.acceleration.terminal.get(),
						__.acceleration.rate.get(),
					);
				}
			};
				
			lock	 =  new IB_LockStack();
			rate	 =  new IB_Stat({
				value: _config[$ "acceleration_rate"] ?? 1,	
			});
			terminal =  new IB_Stat({
				value: _config[$ "acceleration_terminal"] ?? 1,	
			});
			value	 = _config[$ "acceleration_start"] ?? 0.7;
		};
		
		// events
		on_initialize(function() {
			__.acceleration.lock.initialize();
			__.acceleration.rate.initialize();
			__.acceleration.terminal.initialize();
		});
		on_update	 (function() {
			__.acceleration.lock.update();
		});
		on_cleanup	 (function() {
			__.acceleration.lock.cleanup();
			__.acceleration.rate.cleanup();
			__.acceleration.terminal.cleanup();
		});
		
		#endregion
		#region friction
		
		// public
		static friction_lock_set		 = function(_lock_name, _lock_time = -1) {
			__.friction.lock.set_lock(_lock_name, _lock_time);
			return self;
		};
		static friction_lock_remove		 = function(_lock_name) {
			__.friction.lock.remove_lock(_lock_name);
			return self;
		};
		static friction_lock_is_locked	 = function() {
			return __.friction.lock.is_locked();
		};
		static friction_lock_is_unlocked = function() {
			return __.friction.lock.is_unlocked();
		};
		
		// private
		__[$ "friction"] ??= {};
		with (__.friction) {
			static __friction_update = function() {
				if (friction_lock_is_unlocked()) {
					__.friction.value = lerp(
						__.friction.value,
						__.friction.terminal.get(),
						__.friction.rate.get(),
					);
				}
			};
				
			lock	 =  new IB_LockStack();
			rate	 =  new IB_Stat({
				value: _config[$ "friction_rate"] ?? 1,	
			});
			terminal =  new IB_Stat({
				value: _config[$ "friction_terminal"] ?? 1,	
			});
			value	 = _config[$ "friction_start"] ?? 0.2;	
		};
		
		// events
		on_initialize(function() {
			__.friction.lock.initialize();
			__.friction.rate.initialize();
			__.friction.terminal.initialize();
		});
		on_update	 (function() {
			__.friction.lock.update();
		});
		on_cleanup	 (function() {
			__.friction.lock.cleanup();
			__.friction.rate.cleanup();
			__.friction.terminal.cleanup();
		});
		
		#endregion
		#region speed
		
		// private
		__[$ "speed"] ??= {};
		with (__.speed) {
			static __speed_update = function() {
				__.speed.multiplier.value = lerp(
					__.speed.multiplier.value,
					__.speed.multiplier.terminal.get(),
					__.speed.multiplier.acceleration.get(),
				);
				__.speed.terminal.value = lerp(
					__.speed.terminal.value,
					__.speed.terminal.target.get(),
					__.acceleration.rate.get(),
				);
				__.speed.value = __.speed.terminal.value 
					* __.speed.multiplier.value;
			};
				
			multiplier = {
				acceleration: new IB_Stat({
					value: _config[$ "speed_multiplier_acceleration"] ?? 0.1,	
				}),
				terminal:	  new IB_Stat({
					value: _config[$ "speed_multiplier_terminal"] ?? 1,	
				}),
				value:		  0,
			};
			terminal   = {
				target: new IB_Stat({
					value: _config[$ "speed_terminal"] ?? 1,
				}),
				value: _config[$ "speed_terminal"] ?? 1,
			};
			value	   = _config[$ "speed_start"] ?? 0;
		};
		
		// events
		on_initialize(function() {
			__.speed.terminal.target.initialize();
			__.speed.multiplier.acceleration.initialize();
			__.speed.multiplier.terminal.initialize();
		});
		on_cleanup	 (function() {
			__.speed.terminal.target.cleanup();
			__.speed.multiplier.acceleration.cleanup();
			__.speed.multiplier.terminal.cleanup();
		});
		
		#endregion
		#region velocity
		
		// public
		static velocity_add_vector					= function(_vector) {
			array_push(__.velocity.vectors, _vector);
			return self;
		};
		static velocity_add_point					= function(_x, _y) {
			var _vector = new XD_Vector2(_x, _y);
			array_push(__.velocity.vectors, _vector);
			return self;
		};
		static velocity_clear						= function() {
			__.velocity.vector.zero();	
			__.velocity.output.zero();
			return self;
		};
		static velocity_draw_vector					= function(_x, _y, _length, _width = 1, _color = c_teal) {
			__.velocity.output.draw(_x, _y, _length, _width, _color);
			return self;
		};
		static velocity_get_vector_internal			= function() {
			return __.velocity.vector;
		};
		static velocity_get_vector_output			= function() {
			return __.velocity.output;
		};
		static velocity_get_x_internal				= function() {
			return __.velocity.vector.x;
		};
		static velocity_get_x_output				= function() {
			return __.velocity.output.x;
		};
		static velocity_get_y_internal				= function() {
			return __.velocity.vector.y;
		};
		static velocity_get_y_output				= function() {
			return __.velocity.output.y;
		};
		static velocity_is_moving_internal			= function(_threshold = 0) {
			return (abs(__.velocity.vector.x) >= _threshold
				||	abs(__.velocity.vector.y) >= _threshold
			);
		};
		static velocity_is_moving_output			= function(_threshold = 0) {
			return (abs(__.velocity.output.x) >= _threshold
				||	abs(__.velocity.output.y) >= _threshold
			);
		};
		static velocity_lock_set					= function(_lock_name, _lock_time = -1) {
			__.velocity.lock.set_lock(_lock_name, _lock_time);
			return self;
		};
		static velocity_lock_remove					= function(_lock_name) {
			__.velocity.lock.remove_lock(_lock_name);
			return self;
		};
		static velocity_lock_is_locked				= function() {
			return __.velocity.lock.is_locked();
		};
		static velocity_lock_is_unlocked			= function() {
			return __.velocity.lock.is_unlocked();
		};
		static velocity_max							= function(_dir = undefined) {
			var _steer_vector = __.steer.vector.copy();	
			_steer_vector.set_magnitude(__.speed.value);
			if (_dir != undefined) _steer_vector.set_direction(_dir);
			velocity_set_vector_internal(_steer_vector);
			return self;
		};
		static velocity_set_vector_internal			= function(_vector) {
			__.velocity.vector.assign_to(_vector);
			return self;
		};
		static velocity_set_vector_output			= function(_vector) {
			__.velocity.output.assign_to(_vector);
			return self;
		};
		static velocity_set_x_internal				= function(_hspeed) {
			__.velocity.vector.x = _hspeed;
			return self;
		};
		static velocity_set_x_output				= function(_hspeed) {
			__.velocity.output.x = _hspeed;
			return self;
		};
		static velocity_set_y_internal				= function(_hspeed) {
			__.velocity.vector.y = _hspeed;
			return self;
		};
		static velocity_set_y_output				= function(_vspeed) {
			__.velocity.output.y = _vspeed;
			return self;
		};
		static velocity_scale_value_to_internal		= function(_value) {
			var _scale = __.velocity.vector.get_magnitude() / __.speed.value;
			return _value * _scale * __.speed.multiplier.value;
		};
		static velocity_scalar_new_modifier_scalar	= function(_modifier_name, _value, _duration = -1) {
			__.velocity.scalar.modifier_new_scalar(_modifier_name, _value, _duration);
			return self;
		};
		static velocity_scalar_remove_modifier		= function(_modifier_name) {
			__.velocity.scalar.modifier_remove(_modifier_name);
			return self;
		};
		
		// private
		__[$ "velocity"] ??= {};
		with (__.velocity) {
			static __velocity_accelerate		 = function() {
				var _steer_vector = __.steer.vector.copy();
				var _speed_vector = _steer_vector.multiply_by(__.speed.value);
				__.velocity.vector.interpolate_to(_speed_vector, __.acceleration.value);
			};
			static __velocity_aggregate_external = function() {
				iceberg.array.for_each(
					__.velocity.vectors,
					function(_vector) {
						__.velocity.vector.add(_vector);
					},
				);
			};
			static __velocity_clear_external	 = function() {
				__.velocity.vectors = [];
			};
			static __velocity_friction			 = function() {					
				__.velocity.vector.interpolate_to(iceberg.vector.ZERO, __.friction.value);
			};
			static __velocity_update			 = function() {
				if (velocity_lock_is_unlocked()) {
					if (__.motor.switched) {
						if (acceleration_lock_is_unlocked()) {
							__velocity_accelerate();
						}
					}
					else if (friction_lock_is_unlocked()) {
						__velocity_friction();
					}
			
					__velocity_aggregate_external();
					__velocity_clear_external();
			
					if (__.velocity.terminal >= 0) {
						__.velocity.vector.limit_magnitude(
							__.velocity.terminal.get(),
						);	
					}
				}
				__.velocity.output.x = (__.velocity.vector.x * __.velocity.scalar.get());
				__.velocity.output.y = (__.velocity.vector.y * __.velocity.scalar.get());
			};
				
			lock	 = new IB_LockStack();
			output	 = new XD_Vector2();
			vector	 = new XD_Vector2();
			vectors  = array_create(0);
			terminal = new IB_Stat({
				value: _config[$ "velocity_terminal"] ?? -1,
			});
			scalar	 = new IB_Stat({
				value:	   1,
				limit_min: 0,
			});
		};
			
		// events
		on_initialize(function() {
			__.velocity.lock.initialize();
			__.velocity.terminal.initialize();
			__.velocity.scalar.initialize();
		});
		on_update	 (function() {
			__.velocity.lock.update();
			__.velocity.terminal.update();
			__.velocity.scalar.update();
			// see on_update() down below. order matters.
		});
		on_cleanup	 (function() {
			__.velocity.lock.cleanup();
			__.velocity.terminal.cleanup();
			__.velocity.scalar.cleanup();
		});
		
		#endregion
		#region motor
		
		// public
		static motor_add_switch		  = function(_switch, _weight = 1) {
			array_push(__.motor.switches, {
				command: _switch,
				weight:  _weight,
			});
			return self;
		};
		static motor_clear_switches   = function() {
			__.motor.switches = array_create(0);
			return self;
		};
		static motor_get_active		  = function() {
			return __.motor.active;	
		};
		static motor_is_active		  = function() {
			return __.motor.active;	
		};
		static motor_is_switched	  = function() {
			return __.motor.switched;	
		};
		static motor_lock_set		  = function(_lock_name, _lock_time = -1) {
			__.motor.lock.set_lock(_lock_name, _lock_time);
			return self;
		};
		static motor_lock_remove	  = function(_lock_name) {
			__.motor.lock.remove_lock(_lock_name);
			return self;
		};
		static motor_lock_is_locked   = function() {
			return __.motor.lock.is_locked();
		};
		static motor_lock_is_unlocked = function() {
			return __.motor.lock.is_unlocked();
		};
		static motor_set_active		  = function(_active) {
			__.motor.active = _active;
			return self;
		};
			
		// events
		on_update(function() {
			// see on_update() down below. order matters.
		});
		
		// private
		__[$ "motor"] ??= {};
		with (__.motor) {
			static __motor_check  = function() {
				return (__.motor.active
					&&	motor_lock_is_unlocked()
				);
			};
			static __motor_update = function() {
				if (__motor_check()) {
					// if more "on" commands, turn motor on.
					// if more "off" commands, turn motor off.
					var _ons  = 0;
					var _offs = 0;
			
					// count number of commands
					for (var _i = 0, _len = array_length(__.motor.switches); _i < _len; _i++) {
						var _data	 = __.motor.switches[_i];
						var _command = _data.command;
						var _weight	 = _data.weight;
				
						if (_command) _ons  += _weight;	
						else		  _offs += _weight;	
					}
						
					// if "on" commands equals "off" commands, do nothing
					if (_ons != _offs) __.motor.switched = _ons > _offs;	
			
					// wipe stored motor switches
					if (__.motor.clear_each_frame) motor_clear_switches();
				}
			};
				
			active			 = _config[$ "motor_active"			 ] ?? true;
			clear_each_frame = _config[$ "motor_clear_each_frame"] ?? true;
			lock			 =  new IB_LockStack();
			switches		 =  array_create(0);
			switched		 =  false;
		};
		
		// events
		on_initialize(function() {
			__.motor.lock.initialize();
		});
		on_update	 (function() {
			__.motor.lock.update();
		});
		on_cleanup	 (function() {
			__.motor.lock.cleanup();
		});
		
		#endregion
		#region steer
		
		// public
		static steer_add_vector		  = function(_vector, _weight = 1) {
			if (_vector.has_magnitude()) {
				_vector.set_magnitude(_weight);
			}
			array_push(__.steer.vectors, _vector);
			return self;
		};
		static steer_add_point		  = function(_x, _y, _weight = 1) {
			var _vector = new XD_Vector2(_x, _y);
			steer_add_vector(_vector, _weight);
			return self;
		};
		static steer_add_dir		  = function(_dir, _weight = 1) {
			var _vector = new XD_Vector2(1, 1).set_direction(_dir);
			steer_add_vector(_vector, _weight);
			return self;
		};
		static steer_clear_vectors	  = function() {
			__.steer.vectors = array_create(0);
			return self;
		};
		static steer_draw_vector	  = function(_x, _y, _length, _width = 1, _color = c_yellow) {
			__.steer.vector.draw(_x, _y, _length, _width, _color);	
			return self;
		};
		static steer_get_vector		  = function() {
			return __.steer.vector;	
		};
		static steer_get_x			  = function() {
			return __.steer.vector.x;	
		};
		static steer_get_y			  = function() {
			return __.steer.vector.y;	
		};
		static steer_lock_set		  = function(_lock_name, _lock_time = -1) {
			__.steer.lock.set_lock(_lock_name, _lock_time);
			return self;
		};
		static steer_lock_remove	  = function(_lock_name) {
			__.steer.lock.remove_lock(_lock_name);
			return self;
		};
		static steer_lock_is_locked	  = function() {
			return __.steer.lock.is_locked();
		};
		static steer_lock_is_unlocked = function() {
			return __.steer.lock.is_unlocked();
		};
		static steer_set_vector		  = function(_steer_vector) {
			__.steer.vector.assign_to(_steer_vector);
			return self;
		};
		
		// private
		__[$ "steer"] ??= {};
		with (__.steer) {
			static __steer_aggregate_external = function() {
				iceberg.array.for_each(
					__.steer.vectors,
					function(_vector) {
						__.steer.vector.add(_vector);
					},
				);
			};
			static __steer_check			  = function() {
				return (__.steer.active
					&&	steer_lock_is_unlocked()
				);
			};
			static __steer_clamp_magnitude	  = function() {
				if (__.steer.vector.has_magnitude()) {
					__.steer.vector.set_magnitude(1);
				}
			};
			static __steer_clear_external	  = function() {
				if (__.steer.clear_each_frame) {
					steer_clear_vectors();
				}
			};
			static __steer_clear_internal	  = function() {
				if (__.steer.clear_each_frame) {
					__.steer.vector.zero();
				}
			};
			static __steer_update			  = function() {
				if (__steer_check()) {
					__steer_clear_internal();
					__steer_aggregate_external();
					__steer_clamp_magnitude();
					__steer_clear_external();
				}
				else {
					__steer_clamp_magnitude();
				}
			};
				
			active			 = _config[$ "steer_active"			 ] ?? true;
			clear_each_frame = _config[$ "steer_clear_each_frame"] ?? true;
			lock			 =  new IB_LockStack();
			vector			 =  new XD_Vector2();
			vectors			 =  array_create(0);
		};
		
		// events
		on_initialize(function() {
			__.steer.lock.initialize();
		});
		on_update	 (function() {
			__.steer.lock.update();
		});
		on_cleanup	 (function() {
			__.steer.lock.cleanup();
		});
		
		#endregion
		#region collisions
		
		// public
		static collision_object_add    = function(_object_index) {
			__.collision.object.objects.set(
				_object_index, 
				_object_index
			);
			__.collision.object.active = true;
			return self;
		};
		static collision_object_remove = function(_object_index) {
			__.collision.object.objects.remove(_object_index)
			if (__.collision.object.objects.is_empty()) {
				__.collision.object.active = false;	
			}
			return self;
		};
		
		// private
		__[$ "collision"] ??= {};
		with (__.collision) {
			static __collision_objects_init	  = function(_collision_objects_data) {
				for (var _i = 0, _len_i = array_length(_collision_objects_data); _i < _len_i; _i++) {
					collision_object_add(_collision_objects_data[_i]);	
				};	
			};
			static __collision_objects_update = function() {
				if (__.collision.object.active) {
					for (var _i = 0, _len_i = __.collision.object.objects.get_size(); _i < _len_i; _i++) {
						var _index		  = __.collision.object.objects.get_by_index(_i);
						var _collide_data = __collision_object_check(_index);
						var _collided	  = _collide_data.collided_horizontal || _collide_data.collided_vertical;
						if (_collided) exit;
					};
				}
			};
			static __collision_object_check   = function(_object_index) {
					
				var _collided_horizontal = false;
				var _collided_vertical   = false;
				var _instance_horizontal = noone;
				var _instance_vertical   = noone;
			
				var _hspeed = __.velocity.output.x;
				var _vspeed = __.velocity.output.y;
			
				with (get_owner()) {
						
					// horizontal collisions
					_instance_horizontal = instance_place(x + _hspeed, y, _object_index);
					if (_instance_horizontal != noone) {
						while (!place_meeting(x + sign(_hspeed), y, _object_index)) {
							position_adjust_x(sign(_hspeed));
						};
						other.velocity_set_x_output(0);
						_collided_horizontal = true;
					}
				
					// vertical collisions
					_instance_vertical = instance_place(x, y + _vspeed, _object_index);
					if (_instance_vertical != noone) {
						while (!place_meeting(x, y + sign(_vspeed), _object_index)) {
							position_adjust_y(sign(_vspeed));
						};
						other.velocity_set_y_output(0);
						_collided_vertical = true;
					}
				};
			
				return {
					collided_horizontal: _collided_horizontal,
					collided_vertical:	 _collided_vertical,
					instance_horizontal: _instance_horizontal,
					instance_vertical:	 _instance_vertical,
				};
			};
			object = {
				active:  false,
				objects: new IB_Collection_Struct(),
			};
		};
			
		// events
		on_update (function() {
			// see on_update() down below. order matters.
		});
		
		#endregion
		#region moveset
		
		// public
		static moveset_preset_create	  = function(_moveset_name, _acceleration, _friction, _speed_multiplier, _condition = undefined) {
			var _moveset = new _IB_MoveController_TopDown_MoveSet({
				acceleration:	  _acceleration,
				condition:		  _condition,
				friction:		  _friction,
				name:			  _moveset_name,
				speed_multiplier: _speed_multiplier,
			});
			__.moveset.presets.set(_moveset_name, _moveset);
			__.moveset.active = true;
			
			// if default moveset not set, assign as default
			if (__.moveset.preset_default == "") {
				__.moveset.preset_default = _moveset_name;	
			}
			return _moveset;
		};
		static moveset_preset_exists	  = function(_moveset_name) {
			return __.moveset.presets.contains(_moveset_name);
		};
		static moveset_preset_change	  = function(_moveset_name) {
			__.moveset.preset_current = _moveset_name;
			__moveset_apply(_moveset_name);
			return self;
		};
		static moveset_preset_remove	  = function(_moveset_name) {
			
			__.moveset.presets.remove(_moveset_name);
			
			// is default?
			if (__.moveset.preset_default == _moveset_name) {
				__.moveset.preset_default  =  "";	
			}
			
			// is current?
			if (__.moveset.preset_current == _moveset_name) {
				__.moveset.preset_current  =  "";	
			}
				
			// disable if last preset removed
			if (__.moveset.presets.is_empty()) {
				__.moveset.active = false;	
			}
			
			return self;
		};
		static moveset_preset_set_default = function(_moveset_name) {
			__.moveset.preset_default = _moveset_name;
			return self;
		};
		
		// private
		__[$ "moveset"] ??= {};
		with (__.moveset) {
			static __moveset_init	= function(_movesets_data) {
				for (var _i = 0, _len_i = array_length(_movesets_data); _i < _len_i; _i++) {
					
					var _moveset_data		  = _movesets_data[_i];
					var _moveset_name		  = _moveset_data.name;
					var _moveset_acceleration = _moveset_data.acceleration;
					var _moveset_friction	  = _moveset_data.friction;
					var _moveset_speed_mult	  = _moveset_data.speed_mult;
					var _moveset_condition	  = _moveset_data.condition;
					
					moveset_preset_create(
						_moveset_name, 
						_moveset_acceleration,
						_moveset_friction,
						_moveset_speed_mult,
						method(self, _moveset_condition),
					);
				};
			};
			static __moveset_check	= function() {
				return __.moveset.active;	
			};
			static __moveset_update = function() {
				if (__moveset_check()) {
					var _target = __.moveset.preset_default;
					
					// check for moveset trigger activation
					for (var _i = 0, _len = __.moveset.presets.get_size(); _i < _len; _i++) {
						var _moveset = __.moveset.presets.get_by_index(_i);
						if (_moveset.condition_check()) {
								moveset_preset_change(_moveset.get_name());
								exit;
						}
					}
				
					// do moveset change
					if (_target != __.moveset.preset_current) {
						moveset_preset_change(_target);
					}
				}
			};
			static __moveset_apply  = function(_moveset_name) {
				var _moveset = __.moveset.presets.get(_moveset_name);
				__.speed.multiplier.terminal.set(_moveset.get_speed_multiplier());
				__.acceleration.terminal.set(_moveset.get_acceleration());
				__.friction.terminal.set(_moveset.get_friction());
			};
				
			active		   = false;
			presets		   = new IB_Collection_Struct();
			preset_current = "";
			preset_default = "";
		};
		
		// events
		on_cleanup(function() {
			__.moveset.presets.for_each(function(_preset) {
				_preset.cleanup();
			});
		});
		
		#endregion 
		#region movespeed
		
		// public
		static movespeed_preset_create		= function(_movespeed_name, _speed, _condition = undefined) {
			var _movespeed = new _IB_MoveController_TopDown_MoveSpeed({
				condition: _condition,
				name:	   _movespeed_name,
				speed:	   _speed,
			});
			__.movespeed.presets.set(_movespeed_name, _movespeed);
			__.movespeed.active = true;
			
			// if default movespeed not set, assign as default
			if (__.movespeed.preset_default == "") {
				__.movespeed.preset_default = _movespeed_name;	
			}
			return _movespeed;
		};
		static movespeed_preset_exists		= function(_movespeed_name) {
			return __.movespeed.presets.contains(_movespeed_name);
		};
		static movespeed_preset_change		= function(_movespeed_name) {
			__.movespeed.preset_current = _movespeed_name;
			__movespeed_apply(_movespeed_name);
			return self;
		};
		static movespeed_preset_remove		= function(_movespeed_name) {
			
			__.movespeed.presets.remove(_movespeed_name);
			
			// is default?
			if (__.movespeed.preset_default == _movespeed_name) {
				__.movespeed.preset_default  =  "";	
			}
			
			// is current?
			if (__.movespeed.preset_current == _movespeed_name) {
				__.movespeed.preset_current  =  "";	
			}
				
			// disable if last preset removed
			if (__.movespeed.presets.is_empty()) {
				__.movespeed.active = false;	
			}
			
			return self;
		};
		static movespeed_preset_set_default = function(_movespeed_name) {
			__.movespeed.preset_default = _movespeed_name;
			return self;
		};
		
		// private
		__[$ "movespeed"] ??= {};
		with (__.movespeed) {
			static __movespeed_init   = function(_movespeeds_data) {
				for (var _i = 0, _len_i = array_length(_movespeeds_data); _i < _len_i; _i++) {
					
					var _movespeed_data		 = _movespeeds_data[_i];
					var _movespeed_name		 = _movespeed_data.name;
					var _movespeed_speed	 = _movespeed_data.speed;
					var _movespeed_condition = _movespeed_data.condition;
					
					movespeed_preset_create(
						_movespeed_name, 
						_movespeed_speed,
						method(self, _movespeed_condition),
					);
				};
			};
			static __movespeed_update = function() {
				if (__.movespeed.active) {
					var _target = __.movespeed.preset_default;
					
					// check for movespeed trigger activation
					for (var _i = 0, _len = __.movespeed.presets.get_size(); _i < _len; _i++) {
						var _movespeed = __.movespeed.presets.get_by_index(_i);
						if (_movespeed.condition_check()) {
								movespeed_preset_change(_movespeed.get_name());
								exit;
						}
					}
				
					// do movespeed change
					if (_target != __.movespeed.preset_current) {
						movespeed_preset_change(_target);
					}
				}
			};
			static __movespeed_apply  = function(_movespeed_name) {
				var _movespeed = __.movespeed.presets.get(_movespeed_name);
				__.speed.terminal.target.set(_movespeed.get_speed());
			};
				
			active		   = false;
			presets		   = new IB_Collection_Struct();
			preset_current = "";
			preset_default = "";
		};
			
		// events
		on_cleanup(function() {
			__.movespeed.presets.for_each(function(_preset) {
				_preset.cleanup();
			});
		});
		
		#endregion
			
		on_update(function() {
			__moveset_update();
			__movespeed_update();
			__acceleration_update();
			__friction_update();
			__speed_update();
			__motor_update();
			__steer_update();
			__velocity_update();
			__collision_objects_update();
		});
	};
	
	
	