
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   ______   __    __   ______   ______   ______    //
	// /\  ___\ /\  __ \ /\ "-./  \ /\  ___\ /\  == \ /\  __ \   //
	// \ \ \____\ \  __ \\ \ \-./\ \\ \  __\ \ \  __< \ \  __ \  //
	//  \ \_____\\ \_\ \_\\ \_\ \ \_\\ \_____\\ \_\ \_\\ \_\ \_\ //
	//   \/_____/ \/_/\/_/ \/_/  \/_/ \/_____/ \/_/ /_/ \/_/\/_/ //
	//                                                           //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	// obj_camera.create //
	event_inherited();
	event_user(15);
	
	// a camera is an object that exists within a gamemaker room. the 
	// camera has a defined "view" area, that gets projected onto its 
	// associated view_port. while any number of cameras can exist in 
	// a given room, gamemaker only supports 8 active view ports. this
	// means that if there are more than 8 cameras in a given room,
	// not every camera will be able to render onto a view port.
	// the camera flow is as follows: 
	//		[camera] -> [view] -> [view_port]
	
	// camera:		that device to film the room scene with
	// view:		the lense attached to the camera the determines what
	//				gets filtered into the cameras "line-of-sight"
	// view_port:	the screen that displays the final output captured
	
	// even if a camera, view, and view_port are not created by the user,
	// gamemaker will still create a default camera, view, and view_port
	// based off of the dimensions of the first room.
	
	// for example:
	// if the first room is 800x400, then gamemaker will create a view 
	// port that is 800x400 and a camera with a view that covers the whole 
	// room. if you then change rooms to one that is 1024x768, the game 
	// window and view port will still be 800x400 but the camera view will 
	// be 1024x768 and then scaled/stretched to fit the smaller view port
	
	// note that the draw events get run once per camera in the room. 
	// so if 3 cameras exist, then the draw event will execute 3 times.
	// using view_current can help limit this behavior. 
	// additionally, cameras are considered dynamic resources, and 
	// should be garbage collected whenever they are no longer needed
	// using the runtime function: camera_destroy().
	
	// https://gamemaker.io/en/tutorials/cameras-and-views
	
	var _self = self;
	
	// = PUBLIC ====================
	get_bottom	 = function() {
		return get_top() + size_get_height();
	};
	get_center_x = function() {
		return get_left() + size_get_width() * 0.5;
	};
	get_center_y = function() {
		return get_top() + size_get_height() * 0.5;
	};
	size_get_height	 = function() {
		return __.view.size.height;
	};
	get_left	 = function() {
		return position_get_x();
	};
	get_right	 = function() {
		return get_left() + size_get_width();
	};
	get_rotation = function() {
		return __.rotation.angle.current;
	};
	get_top		 = function() {
		return position_get_y();
	};
	size_get_width	 = function() {
		return __.view.size.width;
	};
	position_get_x		 = function() {
		return __.view.position.x;	
	};
	position_get_y		 = function() {
		return __.view.position.y;
	};
	
	// = PRIVATE ===================
	with (__) {
		clock = iceberg.clock_create();
		state = {};
		view  = {};
		
		with (state) {
			fsm = new SnowState("__", false, {
				owner: _self,	
			});
			fsm.add("__", _self.state_base());	
		};
		with (view ) {
			camera	  = undefined;
			index	  = _self[$ "view_index"] ?? 0;
			port	  = {
				position: {
					x: _self[$ "view_port_x"] ?? _self.x,
					y: _self[$ "view_port_y"] ?? _self.y,
				},
				size:	  {
					width:  _self[$ "view_port_width" ] ?? room_width,
					height: _self[$ "view_port_height"] ?? room_height,
				},
			};
			position  = {
				x: 0,
				y: 0,
			};
			size	  = {
				width:  _self[$ "view_width" ] ?? room_width,
				height: _self[$ "view_height"] ?? room_height,
			};
		};
	};
	
	// = EVENTS ====================
	on_initialize(function() {
			
		//window_set_rectangle(0, 0, display_get_width(), display_get_height());
			
		// camera <<<<<<<<<<<<<<
		camera_destroy(view_get_camera(__.view.index));
		__.camera = camera_create_view(position_get_x(), position_get_y(), size_get_width(), size_get_height());
			
		// view <<<<<<<<<<<<<<<<
		view_enabled = true;
		view_visible[__.view.index] = true;
		view_camera [__.view.index] = __.camera;
		view_xport  [__.view.index] = __.view.port.position.x;
		view_yport  [__.view.index] = __.view.port.position.y;
		view_wport	[__.view.index] = __.view.port.size.width;
		view_hport	[__.view.index] = __.view.port.size.height;
	});
	on_cleanup   (function() {
		iceberg.clock_destroy(__.clock);
		// destroy camera ...
	});
	
	/*
	width		  = 1080;
	height		  = 720;
	x_to          = 0;
	y_to          = 0;
	focus_target  = undefined;
	focus_point   = undefined;
	move_speed    = preset.move.speed.base;
	zoom		  = preset.zoom.base;
	zoom_to		  = zoom;
	zoom_speed	  = preset.zoom.speed.base;
	zoom_complete = false;

	shakers = {
		rand:	{
			x: new Shaker(),
			y: new Shaker(),
		},
		spring: {
			x:		new Spring(0.15, 0.25),
			y:		new Spring(0.15, 0.25),
			zoom:	new Spring(0.10, 0.20),
		}
	}

	panning	    = false;
	pan_start_x = undefined
	pan_start_y = undefined
	
	middle_mouse_down		= false;
	middle_mouse_pressed	= false;
	middle_mouse_released	= false;
	middle_mouse_wheel_down = false;
	middle_mouse_wheel_up	= false;

	pos_x	  = x;		// interpolate pos
	pos_y	  = y;		// interpolate pos
	zoom_draw = zoom;	// interpolate zoom

	clock_stable.add_cycle_method(function() {
		_update_pos();
		_update_zoom();
		_update_shakes(); 
	});
	clock_stable.variable_interpolate("pos_x",	   "iota_pos_x");
	clock_stable.variable_interpolate("pos_y",	   "iota_pos_y");
	clock_stable.variable_interpolate("zoom_draw", "iota_zoom" );

	_update_edges  = function() {	
		left   = x - (width  * 0.5) * zoom;
		right  = x + (width  * 0.5) * zoom;
		top	   = y - (height * 0.5) * zoom;
		bottom = y + (height * 0.5) * zoom;
	}
	_update_depth  = function() {
		depth = MAX_DEPTH - 1;	
	}
	_update_pos	   = function() {
		// Panning 1st Priority
		if (panning) {
			var _mouse_x = sys_input.mouse.position_get_x();
			var _mouse_y = sys_input.mouse.position_get_y();
		
			// Capture Initial Mouse Position
			if (pan_start_x == undefined || pan_start_y == undefined) {
				pan_start_x = _mouse_x;	
				pan_start_y = _mouse_y;// + TILE_HEIGHT;	
			} 
		    // Center Camera Pan Around Initial Click Position
			var _cursor_xoff = -pan_start_x;
			var _cursor_yoff = -pan_start_y;//+ TILE_HEIGHT;
		
			// Update Camera Position & Camera's Target "to" Position
			x   += -_mouse_x - _cursor_xoff;
			y   += -_mouse_y - _cursor_yoff;
			x_to = x;
			y_to = y;
		
			// Wipe Focus Target
			focus_target = undefined;
		}
		// Focus Target 2nd Priority
		else if (focus_target != undefined && instance_exists(focus_target)) {
			x_to = focus_target.x;
			y_to = focus_target.y;
			x   += (x_to - x) * move_speed;
			y   += (y_to - y) * move_speed;
		
			pan_start_x = undefined;
			pan_start_y = undefined;
		}
		// Focus Point 3rd Priority
		else if (focus_point != undefined) {
		    x_to = focus_point.x;
			y_to = focus_point.y;
			x   += (x_to - x) * move_speed;
			y   += (y_to - y) * move_speed;
		
			pan_start_x = undefined;
			pan_start_y = undefined;
		}
		// Standard Movement Last Priority
		else {
			focus_target = undefined;
			x += (x_to - x) * move_speed;
			y += (y_to - y) * move_speed;
	
			pan_start_x = undefined;
			pan_start_y = undefined;
		}
	}
	_update_zoom   = function() {
		//if (imgui_blocked()) return;
	
	    if (!instance_exists(objp_player) || objp_player.has_camera_control) {
		    if (middle_mouse_wheel_down) zoom_in (0.1);
			if (middle_mouse_wheel_up)	 zoom_out(0.1);
	    }
		zoom	  = lerp(zoom, zoom_to, zoom_speed);	
		zoom_draw = zoom + shakers.spring.zoom.val;
	
		/// @event: zoom complete
		if (dist_thresh(zoom, zoom_to, 0.01, true)) {
			if (!zoom_complete) {
				radio.broadcast("zoom_completed");
				zoom_complete = true;
			}
		}
		else zoom_complete = false;
	}
	_update_shakes = function() {
		with (shakers) {
			rand.x.update();
			rand.y.update();
			spring.x.update();
			spring.y.update();
			spring.zoom.update();
		}
		pos_x = x + (shakers.rand.x.val + shakers.spring.x.val); 
		pos_y = y + (shakers.rand.y.val + shakers.spring.y.val);
	}
	_check_for_pan = function() {
		if (instance_exists(objp_player) && !objp_player.has_camera_control) return;
		
		if (middle_mouse_pressed) {
			//if (!imgui_blocked()) {
				panning = true;
				clear_focus_target();
			//}
		}
		else if (middle_mouse_released) {
			panning = false;
			//camera_reset_focus();
		}
	}
	get_zoom		 = function() {
		return zoom;
	}
	size_get_width		 = function(_scaled = true) {
		if (_scaled) {
			return width * zoom;
		}
		return width;
	}
	size_get_height		 = function(_scaled = true) {
		if (_scaled) {
			return height * zoom;
		}
		return height;
	}
	get_focus_point  = function() {
	    return focus_point;
	}
	get_focus_target = function() {
		return focus_target;	
	}
	set_zoom		 = function(_zoom) {
		zoom_to = clamp(_zoom, preset.zoom.min, preset.zoom.max);
	}
	set_focus_point  = function(_x, _y) {
		focus_point = {x: _x, y: _y };
	}
	set_focus_target = function(_target_inst) {
		focus_target = _target_inst;	
	}
	is_focusing_on_point  = function(_point) {
		return get_focus_target() == _point;
	}
	is_focusing_on_target = function(_inst) {
		return get_focus_target() == _inst;
	}
	clear_focus_point = function() {
	    focus_point = undefined;
	}
	clear_focus_target = function() {
		focus_target = undefined;	
	}
	shake_random_time	= function(_size = 5, _time = 8) {
		with (shakers.rand) {
			x.shake_time(_size, _time);
			y.shake_time(_size, _time);
		}
	}
	shake_random_time_x	= function(_size = 5, _time = 8) {
		shakers.rand.x.shake_time(_size, _time);
	}
	shake_random_time_y	= function(_size = 5, _time = 8) {
		shakers.rand.y.shake_time(_size, _time);
	}
	shake_random_damp	= function(_size = 5, _damp = 1) {
		with (shakers.rand) {
			x.shake_damp(_size, _damp);
			y.shake_damp(_size, _damp);
		}
	}
	shake_random_damp_x	= function(_size = 5, _damp = 1) {
		shakers.rand.x.shake_damp(_size, _damp);
	}
	shake_random_damp_y	= function(_size = 5, _damp = 1) {
		shakers.rand.y.shake_damp(_size, _damp);
	}
	shake_spring_x		= function(_size, _tens, _damp) {
		shakers.spring.x.fire(-_size, _tens, _damp);
	}
	shake_spring_y		= function(_size, _tens, _damp) {
		shakers.spring.y.fire(-_size, _tens, _damp);
	}
	shake_spring_zoom	= function(_size, _tens, _damp) {
		shakers.spring.zoom.fire(-_size, _tens, _damp);
	}
	zoom_in	 = function(_increment) {
		zoom_to = clamp(zoom + _increment, preset.zoom.min, preset.zoom.max);
	}
	zoom_out = function(_increment) {
		zoom_to = clamp(zoom - _increment, preset.zoom.min, preset.zoom.max);
	}
	



