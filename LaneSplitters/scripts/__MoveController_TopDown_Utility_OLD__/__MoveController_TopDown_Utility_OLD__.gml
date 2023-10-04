/*
	function ibMoveControllerUtilMovePlatform(_config = {}) : ibMoveControllerUtil(_config) constructor {
		with (this) {
			object_index = _config[$ "object_index"] ?? undefined;
			movespeed	 = _config[$ "movespeed"   ] ?? "";
			moveset		 = _config[$ "moveset"	   ] ?? "";
		};
	};
	function ibMoveControllerUtilMovePath(_config = {}) : ibMoveControllerUtil(_config) constructor {
		
		// this path class gets its own update method in order to work around
		// the inherit limitations of iota. iota currently does not support
		// effective interactions with gamemaker's built in path_speed var,
		// so in order to work around that, we need to override the default
		// behavior with our own implmentation. when calling update(), you
		// can pass in an instance reference, and that instance will have 
		// its path_position var updated to match our custom position var.
		
		with (this) {
			triggers  = iceberg.method.new_trigger_stack();
			instance  = _config[$ "instance" ] ?? undefined;
			path	  = _config[$ "path"	 ] ?? path_add();
			speed	  = _config[$ "speed"	 ] ?? 1;
			hspeed	  =  0;
			vspeed	  =  0;
			closed	  = _config[$ "closed"	 ] ?? false;
			smooth	  = _config[$ "smooth"	 ] ?? true;
			absolute  = _config[$ "absolute" ] ?? false;
			position  = _config[$ "position" ] ?? 0;
			previous  =  position;
			running   = _config[$ "running"  ] ?? false;
			points	  = {
				start_x: undefined,	
				start_y: undefined,	
				end_x:	 undefined,	
				end_y:	 undefined,	
				count:   undefined,
				length:  undefined,
			};
			on_end	  = {
				action: _config[$ "endaction"	] ?? path_action_stop,
				clear:  _config[$ "clear_on_end"] ?? true, // clear from MoveController.current on end?
			};
			position  = iceberg.math.wrap(position, 0, 1);
		};
	 
		this.trigger.set_action(
			method(owner, function(_name) {
				change_path(_name);
			}),
			name,
		);
		path_set_closed(path, closed);
		path_set_kind(path, smooth);
	
		static update					   = function() {
			this.triggers.check_activation();
			
			// update and apply progress
			if (running) {
				previous  = position;
				position += speed;
		
				// hard-set path_position to override IOTA incompatibility
				var _position = position / this.points.length;
				var _previous = previous / this.points.length;
				instance.path_position		   = _position;	
				instance.path_positionprevious = _previous;
				
				// infer hspeed and vspeed from path position 
				if (owner.path_check_collisions) {
					var _current_x	= path_get_x(path, instance.path_position);
					var _current_y	= path_get_y(path, instance.path_position);
					var _previous_x = path_get_x(path, instance.path_positionprevious);
					var _previous_y = path_get_y(path, instance.path_positionprevious);
					var _distance   = point_distance(_previous_x, _previous_y, _current_x, _current_y);
					var _direction  = point_direction(_previous_x, _previous_y, _current_x, _current_y);
					this.hspeed		= lengthdir_x(_distance, _direction);
					this.vspeed		= lengthdir_y(_distance, _direction);
				}
				else {
					this.hspeed = 0;	
					this.vspeed = 0;	
				}
			
				// check for completion
				if (instance.path_position >= 1.0) {
					instance.path_position  = 1.0;
					stop();	
				}
			}
			return self;
		};
		static cleanup					   = function() {
			path_delete(path);
			return self;
		};
		static start					   = function() {
			running				   = true;
			position			   = 0;
			instance.path_speed	   = speed;
			instance.path_position = 0;
			this.hspeed			   = 0;
			this.vspeed			   = 0;
		
			// replace literal storage with iteration over path and store every point into array
			this.points.count	= path_get_number(path);
			this.points.start_x = path_get_point_x(path, 0);
			this.points.start_y = path_get_point_y(path, 0);
			this.points.end_x	= path_get_point_x(path, max(0, this.points.count - 1));
			this.points.end_y	= path_get_point_y(path, max(0, this.points.count - 1));
			this.points.length	= point_distance(this.points.start_x, this.points.start_y, this.points.end_x, this.points.end_y);
		
			with (instance) {
				path_start(other.path, other.speed, other.endaction, other.absolute);
			}
			owner.broadcaster.publish("path_started", name);
			return self;
		};
		static stop						   = function() {
			running				= false;
			this.hspeed			= 0;
			this.vspeed			= 0;
			instance.path_speed = 0;
			if (clear_on_end) owner.path = "";
			owner.broadcaster.publish("path_stopped", name);
			return self;
		};
		static pause					   = function() {
			running				= false;
			instance.path_speed = 0; // need to update the instance vars also
			owner.broadcaster.publish("path_paused", name);
			return self;
		};
		static resume					   = function() {
			running				= true;
			instance.path_speed	= speed; // need to update the instance vars also
			owner.broadcaster.publish("path_resumed", name);
			return self;
		};
		static set_position				   = function(_position, _update_private = false) {
			position = iceberg.math.wrap(_position, 0, 1);
			if (_update_private) {
				this.position = position;	
			}
			return self;
		};
		static new_action				   = function(_trigger_name, _trigger_method, _trigger_params = undefined) {
			this.triggers.new_action(_trigger_name, _trigger_method, _trigger_params);
			return self;
		};
		static new_condition			   = function(_trigger_name, _condition_method, _condition_params = undefined) {
			this.triggers.new_condition(_trigger_name, _condition_method, _condition_params);
			return self;
		};
	};
	function ibMoveControllerUtilMoveCurve(_config = {}) : ibMoveControllerUtil(_config) constructor {
	
		with (this) {
			triggers	   = iceberg.method.new_trigger_stack();
			instance	   = _config[$ "instance"     ] ?? undefined;
			curve_index    = _config[$ "curve_index"  ] ?? undefined;
			channel_index  = _config[$ "channel_index"] ?? 0;
			var_binding	   = _config[$ "var_binding"  ] ?? "";
			speed		   = _config[$ "speed"		  ] ?? 0.01;
			progress	   = _config[$ "progress"	  ] ?? 0;
			absolute	   = _config[$ "absolute"	  ] ?? false;	// if variable manipulation should be additive or absolute
			running		   = _config[$ "running"	  ] ?? false;
			channel_struct = undefined;								// need struct reference for animcurve_channel_evaluate()
			on_end		   = {
				action: _config[$ "endaction"	] ?? undefined,
				clear:  _config[$ "clear_on_end"] ?? true, // clear from MoveController.current on end?
			};
			progress = iceberg.math.wrap(progress, 0, 1);
		
			static __update_channel_struct = function() {
				if (curve_index != undefined && channel_index != undefined && channel_index >= 0) {
					this.channel_struct = animcurve_get_channel(curve_index, channel_index);	
				}
				return self;
			};
		};
	
		this.trigger.set_action(
			method(owner, function(_name) {
				change_curve(_name);
			}),
			name,
		);
		set_curve_index(curve_index);
		set_channel_index(channel_index);
	
		static update					   = function() {
			this.triggers.check_activation();
			
			// update and apply progress
			if (running) {
				progress += speed;
			
				// apply
				if (absolute) {
					instance[$ var_binding] = get();	
				}
				else {
					instance[$ var_binding] += get();
				}
				
				// check for completion
				if (progress >= 1.0) {
					progress  = 1.0;	
					stop();
				}
			}
			return self;
		};
		static cleanup					   = function() {
			if (animcurve_exists(curve_index)) {
				try {
					animcurve_destroy(curve_index);
				}
				catch (_err) {}
			}
			curve_index = undefined;
			return self;
		};
		static start					   = function(_channel_index = channel_index) {
			running	 = true;
			progress = 0;
			set_channel_index(_channel_index);
			owner.broadcaster.publish("curve_started", name);
			return self;
		};
		static stop						   = function() {
			running	 = false;
			progress = 0;
			if (clear_on_end) owner.curve = "";	
			owner.broadcaster.publish("curve_stopped", name);
			return self;
		};
		static pause					   = function() {
			running = false;
			owner.broadcaster.publish("curve_paused", name);
			return self;
		};
		static resume					   = function() {
			running = true;
			owner.broadcaster.publish("curve_resumed", name);
			return self;
		};
		static get						   = function() {
			return animcurve_channel_evaluate(this.channel_struct, progress);
		};
		static set_progress				   = function(_progress, _update_private = false) {
			progress = iceberg.math.wrap(_progress, 0, 1);
			if (_update_private) {
				this.progress = progress;	
			}
			return self;
		};
		static set_curve_index			   = function(_curve_index, _update_private = false) {
			curve_index = _curve_index;
		
			if (_update_private) {
				this.curve_index = curve_index;	
			}
			__update_channel_struct();
			return self;
		};
		static set_channel_index		   = function(_channel_index, _update_private = false) {
			// if channel_name is passed in instead of channel_index
			if (is_string(_channel_index)) {
				channel_index = animcurve_get_channel_index(curve_index, _channel_index);
			}
			else {
				channel_index = _channel_index;
			}
		
			if (_update_private) {
				this.channel_index = channel_index;	
			}
			__update_channel_struct();
			return self;
		};
		static new_action				   = function(_trigger_name, _trigger_method, _trigger_params = undefined) {
			this.triggers.new_action(_trigger_name, _trigger_method, _trigger_params);
			return self;
		};
		static new_condition			   = function(_trigger_name, _condition_method, _condition_params = undefined) {
			this.triggers.new_condition(_trigger_name, _condition_method, _condition_params);
			return self;
		};
	};
