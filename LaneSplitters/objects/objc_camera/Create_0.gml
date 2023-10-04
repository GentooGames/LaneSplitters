
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   ______   __    __   ______   ______   ______    //
	// /\  ___\ /\  __ \ /\ "-./  \ /\  ___\ /\  == \ /\  __ \   //
	// \ \ \____\ \  __ \\ \ \-./\ \\ \  __\ \ \  __< \ \  __ \  //
	//  \ \_____\\ \_\ \_\\ \_\ \ \_\\ \_____\\ \_\ \_\\ \_\ \_\ //
	//   \/_____/ \/_/\/_/ \/_/  \/_/ \/_____/ \/_/ /_/ \/_/\/_/ //
	//                                                           //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	// objc_camera.create //
	event_inherited();
	var _self = self;
	
	#region size ..................|
	
		// public
		size_get_width  = function(_scaled = true) {
			if (_scaled) {
				return __.size.width * zoom_get();
			}
			return __.size.width;
		};
		size_get_height = function(_scaled = true) {
			if (_scaled) {
				return __.size.height * zoom_get();	
			}
			return __.size.height;
		};
		size_get_ratio  = function() {
			return __.size.ratio;	
		};
		size_set_width  = function(_width) {
			__.size.width = _width;
			__.size.update_ratio();
			return self;
		};
		size_set_height = function(_height) {
			__.size.height = _height;
			__.size.update_ratio();
			return self;
		};
	
		// private
		__[$ "size"] = {};
		with (__.size) {
			update_ratio =  method(_self, function() {
				__.size.ratio = __.size.width / __.size.height;
			});
			width		 = _self[$ "width" ] ?? 320 * 2;
			height		 = _self[$ "height"] ?? 180 * 2;
			ratio		 =  width / height;
		};
	
	#endregion
	#region position ..............|
	
		// public
		position_get_x				 = function() {
			return __.position.x;	
		};
		position_get_x_target		 = function() {
			return __.position.target.x;
		};
		position_get_y				 = function() {
			return __.position.y;	
		};
		position_get_y_target		 = function() {
			return __.position.target.y;
		};
		position_get_z				 = function() {
			return __.position.z;	
		};
		position_get_z_target		 = function() {
			return __.position.target.z;	
		};
		position_get_instance		 = function() {
			return __.position.instance;	
		};
		position_get_instance_target = function() {
			return __.position.target.instance;
		};
		
		position_set_x				 = function(_x, _lerp = false) {
			if (_lerp) {
				__.position.target.x = _x;
			}
			else {
				__.position.x		 = _x;
				__.position.target.x = _x;
			}
			return self;
		};
		position_set_y				 = function(_y, _lerp = false) {
			if (_lerp) {
				__.position.target.y = _y;
			}
			else {
				__.position.y		 = _y;
				__.position.target.y = _y;
			}
			return self;
		};
		position_set_z				 = function(_z, _lerp = false) {
			if (_lerp) {
				__.position.target.z = _z;
			}
			else {
				__.position.z		 = _z;
				__.position.target.z = _z;
			}
			return self;
		};
		position_set_instance		 = function(_instance, _lerp = false) {
			if (_lerp) {
				__.position.target.instance = _instance;
			}
			else {
				__.position.instance		= _instance;
				__.position.target.instance = _instance;
			}
			return self;
		};
			
		// private
		__[$ "position"] = {};
		with (__.position) {
			instance = _self[$ "position_target"] ??  undefined;
			x		 = _self[$ "position_x"		] ??  room_width  * 0.5;
			y		 = _self[$ "position_y"		] ??  room_height * 0.5;
			z		 = _self[$ "position_z"		] ?? -10000;
			target	 = {
				instance: _self[$ "position_target"] ?? undefined,	
				x:		  _self[$ "position_x"	   ] ?? 0,
				y:		  _self[$ "position_y"	   ] ?? 0,
				z:		  _self[$ "position_z"	   ] ?? 0,
				speed:	  _self[$ "position_speed" ] ?? 0.3,
			};
		};
	
	#endregion
	#region edges .................|
	
		// public
		edge_get_left	  = function() {
			return position_get_x() - (size_get_width(true) * 0.5);
		};
		edge_get_top	  = function() {
			return position_get_y() - (size_get_height(true) * 0.5);
		};
		edge_get_right	  = function() {
			return position_get_x() + (size_get_width(true) * 0.5);
		};
		edge_get_bottom	  = function() {
			return position_get_y() + (size_get_height(true) * 0.5);
		};
		edge_intersecting = function(_x, _y) {
			return point_in_rectangle(
				_x, 
				_y, 
				edge_get_left(),
				edge_get_top(),
				edge_get_right(),
				edge_get_bottom(),
			);
		};
	
	#endregion
	#region zoom ..................|
	
		// public
		zoom_get		 = function() {
			return __.zoom.factor;
		};
		zoom_get_target	 = function() {
			return __.zoom.target.factor;
		};
		zoom_get_speed	 = function() {
			return __.zoom.target.speed;
		};
		zoom_set		 = function(_zoom) {
			__.zoom.factor = _zoom;
			return self;
		};
		zoom_set_dynamic = function(_dynamic) {
			__.zoom_dynamic_active = _dynamic;
			return self;
		};
		zoom_set_target  = function(_target) {
			__.zoom.target.factor = _target;
			return self;
		};
		zoom_set_speed	 = function(_speed) {
			__.zoom.target.speed = _speed;
			return self;
		};
	
		// private
		__[$ "zoom"] = {};
		with (__.zoom) {
			factor	= _self[$ "zoom_factor"] ?? 0.5;
			target	= {
				factor: _self[$ "zoom_factor"] ?? 1.0,
				speed:  _self[$ "zoom_speed" ] ?? 0.1,
			};	
			dynamic = {
				active: _self[$ "zoom_dynamic_active"] ?? false,	
			};
				
			variable_struct_remove(_self, "zoom_dynamic_active");
		};
		
		// events
		on_update(function() {
			if (__.zoom.target.factor != __.zoom.factor) {
				__.zoom.factor = lerp(__.zoom.factor, __.zoom.target.factor, __.zoom.target.speed);	
			}
		});
	
	#endregion
	#region focus .................|
	
		// public
		focus_get_length = function() {
			return __.focus.length;	
		};
		focus_get_target = function() {
			return __.focus.target;	
		};
		focus_set_length = function(_length) {
			__.focus.length = _length;
			return self;	
		};
		focus_set_target = function(_target) {
			__.focus.target = _target;
			return self;
		};
	
		// private
		__[$ "focus"] = {};
		with (__.focus) {
			length = _self[$ "focus_length"] ?? 1000;	
			target = _self[$ "focus_target"] ?? undefined;
			
			variable_struct_remove(_self, "focus_length");
			variable_struct_remove(_self, "focus_target");
		};
	
	#endregion
	#region state .................|
	
		// public
		state_change   = function(_state) { // should remove
			__.state.name = _state_name;
			__.state.fsm.change(_state_name);
			return self;
		};
		state_get_name = function() {
			return __.state.name;	
		};
	
		// public
		__[$ "state"] = {};
		with (__.state) {
			name = "__";
			fsm  = new SnowState(name, false, {
				owner: _self,
			});
			fsm.add("__", {
				enter: function() {},
				step:  function() {
				
					// follow target
					var _target  = focus_get_target();
					if (_target != undefined && instance_exists(_target)) {
						
						// accumulate average position
						var _x_min = room_width;
						var _x_max = 0;
						var _x_pos = 0;
						var _y_pos = 0;
						var _count = instance_number(_target.object_index);
						for (var _i = 0; _i < _count; _i++) {
							var _instance = instance_find(_target.object_index, _i);	
							_x_pos += _instance.x;
							_y_pos += _instance.y;
							if (_instance.x > _x_max) _x_max = _instance.x;
							if (_instance.x < _x_min) _x_min = _instance.x;
						};
						_x_pos /= _count;
						_y_pos /= _count;
						
						// limit to room edges
						var _width  = size_get_width () * 0.5;
						var _height = size_get_height() * 0.5;
						_x_pos = clamp(_x_pos, _width,  room_width  - _width );
						_y_pos = clamp(_y_pos, _height, room_height - _height);
				
						// set position to camera
						position_set_x(_x_pos);
						position_set_y(_y_pos);
					
						// dynamic zoom
						if (__.zoom.dynamic.active) {
							var _scalar  = 1.5;
							var _delta_x = (_x_max - _x_min) / room_width;
							var _scale	 = _delta_x * _scalar;
								_scale	 = clamp(_scale, 0.4, 1.0);
							zoom_set(_scale);
						}
					}
				
					// audio listener
					audio_listener_position(
						position_get_x(),
						position_get_y(),
						position_get_z(),
					);
				},
				draw:  function() {
				
					////////////////////////////////
				
					var _x = position_get_x();
					var _y = position_get_y();
					var _z = position_get_z();
				
					view_matrix = matrix_build_lookat(
						_x, _y, _z,
						_x, _y, _z + focus_get_length(), 
						 0,  1,  0
					);
					camera_set_view_mat(camera, view_matrix);
				
					////////////////////////////////
				
					proj_matrix = matrix_build_projection_ortho(
						size_get_width (true),
						size_get_height(true),
						1,
						32000
					);	
					camera_set_proj_mat(camera, proj_matrix);
				
					////////////////////////////////
				
					camera_apply(camera);
					view_camera = camera;	
				},
				leave: function() {},
			});	
		};
	
	#endregion
	#region camera ................|
	
		// public
		camera		= camera_create();
		view_matrix	= 0;
		proj_matrix = 0;
	
	#endregion
	
	// public
	x_world_to_gui = function(_x_world) {
		var _ratio = SURF_W / size_get_width(true);
		var _gui_x = (_x_world - edge_get_left()) * _ratio;
		return _gui_x;
	};
	y_world_to_gui = function(_y_world) {
		var _ratio = SURF_W / size_get_width(true);
		var _gui_y = (_y_world - edge_get_top()) * _ratio;
		return _gui_y;
	};
	
	// events
	on_update(function() {
		__.state.fsm.step();
	});
	on_render(function() {
		__.state.fsm.draw();
	});
	