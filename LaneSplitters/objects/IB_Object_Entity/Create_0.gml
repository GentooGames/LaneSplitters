	
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   __   __   ______  __   ______  __  __    //
	// /\  ___\ /\ "-.\ \ /\__  _\/\ \ /\__  _\/\ \_\ \   //
	// \ \  __\ \ \ \-.  \\/_/\ \/\ \ \\/_/\ \/\ \____ \  //
	//  \ \_____\\ \_\\"\_\  \ \_\ \ \_\  \ \_\ \/\_____\ //
	//   \/_____/ \/_/ \/_/   \/_/  \/_/   \/_/  \/_____/ //
	//                                                    //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	// IB_Object_Entity.create //
	event_inherited();
	var _self = self;
	var _data = self[$ "data"] ?? self;
	
	/////////////////////////////
	
	__[$ "entity"] ??= {};
	
	#region sprite ............|
	
		// public 
		sprite_get_image_index	= function() {
			return image_index;	
		};
		sprite_get_image_speed	= function() {
			return image_speed;	
		};
		sprite_get_sprite_index = function() {
			return sprite_index;	
		};
			
		sprite_set_image_index	= function(_image_index) {
			__.entity.sprite.image_index = _image_index;
			image_index					 = _image_index;
			return self;
		};
		sprite_set_image_speed  = function(_image_speed) {
			__.entity.sprite.image_speed = _image_speed;
			image_speed					 = _image_speed;
			return self;
		};
		sprite_set_sprite_index = function(_sprite_index) {
			__.entity.sprite.sprite_index = _sprite_index;
			sprite_index				  = _sprite_index;
			return self;
		};
			
		// private 
		__.entity[$ "sprite"] ??= {};
		with (__.entity.sprite) {
			sprite_index = (_data[$ "sprite_index"] ?? _self[$ "sprite_index"]) ?? -1;
			image_index  = (_data[$ "image_index" ] ?? _self[$ "image_index" ]) ??  0;
			image_speed  = (_data[$ "image_speed" ] ?? _self[$ "image_speed" ]) ??  1;
		};
		
		// events
		on_initialize(function() {
			sprite_set_sprite_index(__.entity.sprite.sprite_index);
			sprite_set_image_index (__.entity.sprite.image_index );
			sprite_set_image_speed (__.entity.sprite.image_speed );
		});
	
	#endregion
	#region position ..........|
	
		// public
		position_get_x				= function() {
			return __.entity.transform.position.x.current.value;
		};
		position_get_x_start		= function() {
			return __.entity.transform.position.x.start.value;
		};
		position_get_x_lerp_target	= function() {
			return __.entity.transform.position.x.target.value;
		};
		position_get_x_lerp_speed	= function(_get_start_speed = false) {
			if (_get_start_speed) {
				return __.entity.transform.position.x.target.speed.start;		
			}
			return __.entity.transform.position.x.target.speed.value;	
		};
		position_get_y				= function(_apply_z_position = true) {
			if (_apply_z_position) {
				if (__.entity.transform.position.z.up_is_negative) {
					return __.entity.transform.position.y.current.value + position_get_z();	
				}
				return __.entity.transform.position.y.current.value - position_get_z();	
			}
			return __.entity.transform.position.y.current.value;
		};
		position_get_y_start		= function() {
			return __.entity.transform.position.y.start.value;
		};
		position_get_y_lerp_target	= function(_apply_z_position = true) {
			if (_apply_z_position) {
				return __.entity.transform.position.y.target.value - position_get_z();	
			}
			return __.entity.transform.position.y.target.value;
		};
		position_get_y_lerp_speed	= function(_get_start_speed = false) {
			if (_get_start_speed) {
				return __.entity.transform.position.y.target.speed.start;		
			}
			return __.entity.transform.position.y.target.speed.value;	
		};
		position_get_z				= function() {
			return __.entity.transform.position.z.current.value;
		};
		position_get_z_start		= function() {
			return __.entity.transform.position.z.start.value;
		};
		position_get_z_lerp_target	= function() {
			return __.entity.transform.position.z.target.value;
		};
		position_get_z_lerp_speed	= function(_get_start_speed = false) {
			if (_get_start_speed) {
				return __.entity.transform.position.z.target.speed.start;		
			}
			return __.entity.transform.position.z.target.speed.value;	
		};

		position_get_bottom			= function() {
			return position_get_top() + size_get_height();
		};
		position_get_center_h		= function() {
			return position_get_left() + (size_get_width() * 0.5);
		};
		position_get_center_v		= function() {
			return position_get_top() + (size_get_height() * 0.5);
		};
		position_get_left			= function() {
			return position_get_x();
		};
		position_get_right			= function() {
			return position_get_left() + size_get_width();
		};
		position_get_top			= function() {
			return position_get_y(true);
		};

		position_set_x				= function(_x, _lerp_movement = false, _lerp_speed = position_get_x_lerp_speed(true)) {
			position_set_x_lerp_target(_x, _lerp_speed);
			if (!_lerp_movement) position_snap_x();
			return self;
		};
		position_set_x_start		= function(_x_start) {
			__.entity.transform.position.x.start.value = _x_start;
			return self;
		};
		position_set_x_lerp_target	= function(_x_target, _x_speed = position_get_x_lerp_speed(true)) {
			__.entity.transform.position.x.target.value = _x_target;
			position_set_x_lerp_speed(_x_speed, false);
			return self;
		};
		position_set_x_lerp_speed	= function(_x_speed, _update_start = true) {
			__.entity.transform.position.x.target.speed.value = _x_speed;
			if (_update_start) {
				__.entity.transform.position.x.target.speed.start = _x_speed;
			}
			return self;
		};
		position_set_y				= function(_y, _lerp_movement = false, _lerp_speed = position_get_y_lerp_speed(true)) {
			position_set_y_lerp_target(_y, _lerp_speed);
			if (!_lerp_movement) position_snap_y();
			return self;
		};
		position_set_y_start		= function(_y_start) {
			__.entity.transform.position.y.start.value = _y_start;
			return self;
		};
		position_set_y_lerp_target	= function(_y_target, _y_speed = position_get_y_lerp_speed(true)) {
			__.entity.transform.position.y.target.value = _y_target;
			position_set_y_lerp_speed(_y_speed, false);
			return self;
		};	
		position_set_y_lerp_speed	= function(_y_speed, _update_start = true) {
			__.entity.transform.position.y.target.speed.value = _y_speed;
			if (_update_start) {
				__.entity.transform.position.y.target.speed.start = _y_speed;
			}
			return self;
		};
		position_set_z				= function(_z, _lerp_movement = false, _lerp_speed = position_get_z_lerp_speed(true)) {
			position_set_z_lerp_target(_z, _lerp_speed);
			if (!_lerp_movement) position_snap_z();
			return self;
		};
		position_set_z_start		= function(_z_start) {
			__.entity.transform.position.z.start.value = _z_start;
			return self;
		};
		position_set_z_lerp_target	= function(_z_target, _z_speed = position_get_z_lerp_speed(true)) {
			__.entity.transform.position.z.target.value = _z_target;
			position_set_z_lerp_speed(_z_speed, false);
			return self;
		};	
		position_set_z_lerp_speed	= function(_z_speed, _update_start = true) {
			__.entity.transform.position.z.target.speed.value = _z_speed;
			if (_update_start) {
				__.entity.transform.position.z.target.speed.start = _z_speed;
			}
			return self;
		};
			
		position_adjust_x			= function(_amount, _lerp_movement = false, _lerp_speed = position_get_x_lerp_speed(true)) {
			position_set_x(position_get_x() + _amount, _lerp_movement, _lerp_speed);
			return self;
		};
		position_adjust_y			= function(_amount, _lerp_movement = false, _lerp_speed = position_get_y_lerp_speed(true)) {
			position_set_y(position_get_y(false) + _amount, _lerp_movement, _lerp_speed);
			return self;
		};
		position_adjust_z			= function(_amount, _lerp_movement = false, _lerp_speed = position_get_z_lerp_speed(true)) {
			position_set_z(position_get_z() + _amount, _lerp_movement, _lerp_speed);
			return self;
		};
		position_snap_x				= function(_x_target = position_get_x_lerp_target()) {
			__.entity.transform.position.x.current.value = _x_target;
			__.entity.transform.position.x.target.value  = _x_target;
			__.entity.transform.position.update_lerp_x();
			return self;
		};
		position_snap_y				= function(_y_target = position_get_y_lerp_target(false)) {
			__.entity.transform.position.y.current.value = _y_target;
			__.entity.transform.position.y.target.value  = _y_target;
			__.entity.transform.position.update_lerp_y();
			return self;
		};
		position_snap_z				= function(_z_target = position_get_z_lerp_target()) {
			__.entity.transform.position.z.current.value = _z_target;
			__.entity.transform.position.z.target.value  = _z_target;
			__.entity.transform.position.update_lerp_z();
			return self;
		};
			
		// private
		__.entity[$ "transform"] ??= {};
		with (__.entity.transform) {
			position = {
				x: {
					start:	 {
						value: (_data[$ "x"] ?? _self[$ "x"]),
					},
					current: {
						value: (_data[$ "x"] ?? _self[$ "x"]),
					},
					target:  {
						value: ((_data[$ "x_lerp_target"] ?? _data[$ "x"]) ?? _self[$ "x"]) ?? 0,
						speed: {
							value: _data[$ "x_lerp_speed"] ?? 0.25,
							start: _data[$ "x_lerp_speed"] ?? 0.25,
						},
					},
				},
				y: {
					start:	 {
						value: (_data[$ "y"] ?? _self[$ "y"]),
					},
					current: {
						value: (_data[$ "y"] ?? _self[$ "y"]),
					},
					target:  {
						value: ((_data[$ "y_lerp_target"] ?? _data[$ "y"]) ?? _self[$ "y"]) ?? 0,
						speed: {
							value: _data[$ "y_lerp_speed"] ?? 0.25,
							start: _data[$ "y_lerp_speed"] ?? 0.25,
						},
					},
				},
				z: {
					start:	 {
						value: (_data[$ "z_start"] ?? _data[$ "z"]) ?? 0,
					},
					current: {
						value: _data[$ "z"] ?? 0,
					},
					target:	 {
						value: (_data[$ "z_lerp_target"] ?? _data[$ "z"]) ?? 0,
						speed: {
							value: _data[$ "z_lerp_speed"] ?? 0.25,
							start: _data[$ "z_lerp_speed"] ?? 0.25,
						},
					},
					up_is_negative: true, // how GM handles the y axis?
				},
				update_lerp_all:	  method(_self, function() {
					__.entity.transform.position.update_lerp_x();
					__.entity.transform.position.update_lerp_y();
					__.entity.transform.position.update_lerp_z();
				}),
				update_lerp_x:		  method(_self, function() {
					if (__.entity.transform.position.x.current.value 
					!=  __.entity.transform.position.x.target.value
					) { 
						__.entity.transform.position.x.current.value = lerp(
							__.entity.transform.position.x.current.value, 
							__.entity.transform.position.x.target.value, 
							__.entity.transform.position.x.target.speed.value
						);
					}
					x = __.entity.transform.position.x.current.value;
				}),
				update_lerp_y:		  method(_self, function() {
					if (__.entity.transform.position.y.current.value 
					!=	__.entity.transform.position.y.target.value
					) { 
						__.entity.transform.position.y.current.value = lerp(
							__.entity.transform.position.y.current.value, 
							__.entity.transform.position.y.target.value, 
							__.entity.transform.position.y.target.speed.value
						);
					}
					y = __.entity.transform.position.y.current.value;
				}),
				update_lerp_z:		  method(_self, function() {
					if (__.entity.transform.position.z.current.value 
					!=	__.entity.transform.position.z.target.value
					) { 
						__.entity.transform.position.z.current.value = lerp(
							__.entity.transform.position.z.current.value, 
							__.entity.transform.position.z.target.value, 
							__.entity.transform.position.z.target.speed.value
						);
					}
				}),
				update_on_step_begin: false,
				update_on_step:		  true,
				update_on_step_end:   false,
			};	
		};
		
		// events
		on_initialize  (function() {
			x = position_get_x();
			y = position_get_y();
		});
		on_update_begin(function() {
			if (__.entity.transform.position.update_on_step_begin) {
				__.entity.transform.position.update_lerp_all();
			}
		});
		on_update	   (function() {
			if (__.entity.transform.position.update_on_step) {
				__.entity.transform.position.update_lerp_all();
			}
		});
		on_update_end  (function() {
			if (__.entity.transform.position.update_on_step_end) {
				__.entity.transform.position.update_lerp_all();
			}
		});
	
	#endregion
	#region dimensions ........|
	
		// public 
		size_get_height	= function(_apply_scale_base = true) {
			if (_apply_scale_base) {
				return __.entity.transform.size.height * abs(scale_get_y());
			}
			return __.entity.transform.size.height;
		};
		size_get_width	= function(_apply_scale_base = true) {
			if (_apply_scale_base) {
				return __.entity.transform.size.width * abs(scale_get_x(,false));
			}
			return __.entity.transform.size.width;
		};
		size_set_width	= function(_width) {
			__.entity.transform.size.width = abs(_width);
			return self;
		};
		size_set_height	= function(_height) {
			__.entity.transform.size.height = abs(_height);
			return self;
		};
			
		// private
		__.entity[$ "transform"] ??= {};
		with (__.entity.transform) {
			size = {
				width:  (_data[$ "width" ] ?? _self[$ "sprite_width" ]) ?? 1,
				height: (_data[$ "height"] ?? _self[$ "sprite_height"]) ?? 1,
			};
		};
	
	#endregion
	#region scale .............|
	
		// public
		scale_get				= function() {
			return __.entity.transform.size.scale.factor.current.value;
		};
		scale_get_lerp_target	= function() {
			return __.entity.transform.size.scale.factor.target.value;
		};
		scale_get_lerp_speed	= function(_get_start_speed = false) {
			if (_get_start_speed) {
				return __.entity.transform.size.scale.factor.target.speed.start;		
			}
			return __.entity.transform.size.scale.factor.target.speed.value;
		};
		scale_get_x				= function(_apply_scale_base = true, _apply_facing = false) {
			var _scale_x = __.entity.transform.size.scale.factor_x.current.value;
			if (_apply_scale_base) _scale_x *= scale_get();	
			if (_apply_facing	 ) _scale_x *= facing_get();
			return _scale_x;
		};
		scale_get_x_lerp_target	= function(_apply_scale_base = true, _apply_facing = false) {
			var _scale_x_target = __.entity.transform.size.scale.factor_x.target.value;
			if (_apply_scale_base) _scale_x_target *= scale_get();	
			if (_apply_facing	 ) _scale_x_target *= facing_get();
			return _scale_x_target;
		};
		scale_get_x_lerp_speed	= function(_get_start_speed = false) {
			if (_get_start_speed) {
				return __.entity.transform.size.scale.factor_x.target.speed.start;		
			}
			return __.entity.transform.size.scale.factor_x.target.speed.value;
		};
		scale_get_y				= function(_apply_scale_base = true, _apply_facing = false) {
			var _scale_y = __.entity.transform.size.scale.factor_y.current.value;
			if (_apply_scale_base) _scale_y *= scale_get();	
			if (_apply_facing	 ) _scale_y *= facing_get();
			return _scale_y;
		};
		scale_get_y_lerp_target	= function(_apply_scale_base = true, _apply_facing = false) {
			var _scale_y_target = __.entity.transform.size.scale.factor_y.target.value;
			if (_apply_scale_base) _scale_y_target *= scale_get();	
			if (_apply_facing	 ) _scale_y_target *= facing_get();
			return _scale_y_target;
		};
		scale_get_y_lerp_speed	= function(_get_start_speed = false) {
			if (_get_start_speed) {
				return __.entity.transform.size.scale.factor_y.target.speed.start;		
			}
			return __.entity.transform.size.scale.factor_y.target.speed.value;
		};
			
		scale_set				= function(_scale, _lerp = false, _lerp_speed = scale_get_lerp_speed(true)) {
			scale_set_lerp_target(_scale, _lerp_speed);
			if (!_lerp) scale_snap();
			return self;
		};
		scale_set_lerp_target	= function(_scale_target, _target_speed = scale_get_lerp_speed(true)) {
			__.entity.transform.size.scale.factor.target.value = _scale_target;
			scale_set_lerp_speed(_target_speed, false);
			return self;
		};
		scale_set_lerp_speed	= function(_scale_speed, _update_start = true) {
			__.entity.transform.size.scale.factor.target.speed.value = _scale_speed;
			if (_update_start) {
				__.entity.transform.size.scale.factor.target.speed.start = _scale_speed;
			}
			return self;
		};
		scale_set_x				= function(_scale_x, _lerp = false, _lerp_speed = scale_get_lerp_speed(true)) {
			scale_set_x_lerp_target(_scale_x, _lerp_speed);
			if (!_lerp) scale_snap_x();
			return self;
		};
		scale_set_x_lerp_target	= function(_scale_x_target, _x_target_speed = scale_get_lerp_speed(true)) {
			__.entity.transform.size.scale.factor_x.target.value = _scale_x_target;
			scale_set_x_lerp_speed(_x_target_speed, false);
			return self;
		};
		scale_set_x_lerp_speed	= function(_scale_x_speed, _update_start = true) {
			__.entity.transform.size.scale.factor_x.target.speed.value = _scale_x_speed;
			if (_update_start) {
				__.entity.transform.size.scale.factor_x.target.speed.start = _scale_x_speed;
			}
			return self;
		};
		scale_set_y				= function(_scale_y, _lerp = false, _lerp_speed = scale_get_lerp_speed(true)) {
			scale_set_y_lerp_target(_scale_y, _lerp_speed);
			if (!_lerp) scale_snap_y();
			return self;
		};
		scale_set_y_lerp_target	= function(_scale_y_target, _y_target_speed = scale_get_lerp_speed(true)) {
			__.entity.transform.size.scale.factor_y.target.value = _scale_y_target;
			scale_set_y_lerp_speed(_y_target_speed, false);
			return self;
		};
		scale_set_y_lerp_speed	= function(_scale_y_speed, _update_start = true) {
			__.entity.transform.size.scale.factor_y.target.speed.value = _scale_y_speed;
			if (_update_start) {
				__.entity.transform.size.scale.factor_y.target.speed.start = _scale_y_speed;
			}
			return self;
		};
			
		scale_flip_x			= function(_lerp_flip = false, _lerp_speed = scale_get_x_lerp_speed(true)) {
			__.entity.transform.size.scale.factor_y.target.value	  *= -1;
			__.entity.transform.size.scale.factor_y.target.speed.value = _lerp_speed;
			if (!_lerp_flip) scale_snap_x();
			return self;
		};
		scale_flip_y			= function(_lerp_flip = false, _lerp_speed = scale_get_y_lerp_speed(true)) {
			__.entity.transform.size.scale.factor_y.target.value	  *= -1;
			__.entity.transform.size.scale.factor_y.target.speed.value = _lerp_speed;
			if (!_lerp_flip) scale_snap_y();
			return self;
		};
		scale_squish			= function(_scale) {
			__.entity.transform.size.scale.factor.current.value *= _scale;
			return self;
		};
		scale_squish_x			= function(_scale_x) {
			__.entity.transform.size.scale.factor_x.current.value *= _scale_x;
			return self;
		};
		scale_squish_y			= function(_scale_y) {
			__.entity.transform.size.scale.factor_y.current.value *= _scale_y;
			return self;
		};
		scale_snap				= function(_scale = scale_get_lerp_target()) {
			__.entity.transform.size.scale.factor.current.value = _scale;
			__.entity.transform.size.scale.factor.target.value  = _scale;
			return self;
		};
		scale_snap_x			= function(_scale_x = scale_get_x_lerp_target()) {
			__.entity.transform.size.scale.factor_x.current.value = _scale_x;
			__.entity.transform.size.scale.factor_x.target.value  = _scale_x;
			image_xscale										  = _scale_x;
			return self;
		};
		scale_snap_y			= function(_scale_y = scale_get_y_lerp_target()) {
			__.entity.transform.size.scale.factor_y.current.value = _scale_y;
			__.entity.transform.size.scale.factor_y.target.value  = _scale_y;
			image_yscale										  = _scale_y;
			return self;
		};
	
		// private
		__.entity[$ "transform"] ??= {};
		with (__.entity.transform) {
			scale_update	 = method(_self, function() {
				if (__.entity.transform.size.scale.factor.current.value 
				!=	__.entity.transform.size.scale.factor.target.value
				) { 
					__.entity.transform.size.scale.factor.current.value = lerp(
						__.entity.transform.size.scale.factor.current.value, 
						__.entity.transform.size.scale.factor.target.value, 
						__.entity.transform.size.scale.factor.target.speed.value, 
					);
					image_xscale = __.entity.transform.size.scale.factor_x.current.value *
						__.entity.transform.size.scale.factor.current.value;
						
					image_yscale = __.entity.transform.size.scale.factor_y.current.value *
						__.entity.transform.size.scale.factor.current.value;
				}
			});
			scale_update_x	 = method(_self, function() {
				if (__.entity.transform.size.scale.factor_x.current.value 
				!=	__.entity.transform.size.scale.factor_x.target.value
				) { 
					__.entity.transform.size.scale.factor_x.current.value = lerp(
						__.entity.transform.size.scale.factor_x.current.value, 
						__.entity.transform.size.scale.factor_x.target.value, 
						__.entity.transform.size.scale.factor_x.target.speed.value, 
					);
				}
				image_xscale = __.entity.transform.size.scale.factor_x.current.value *
					__.entity.transform.size.scale.factor.current.value;
			});
			scale_update_y	 = method(_self, function() {
				if (__.entity.transform.size.scale.factor_y.current.value 
				!=	__.entity.transform.size.scale.factor_y.target.value
				) { 
					__.entity.transform.size.scale.factor_y.current.value = lerp(
						__.entity.transform.size.scale.factor_y.current.value, 
						__.entity.transform.size.scale.factor_y.target.value, 
						__.entity.transform.size.scale.factor_y.target.speed.value, 
					);
				}
				image_yscale = __.entity.transform.size.scale.factor_y.current.value *
					__.entity.transform.size.scale.factor.current.value;
			});
			scale_update_all = method(_self, function() {
				__.entity.transform.scale_update();
				__.entity.transform.scale_update_x();
				__.entity.transform.scale_update_y();
			});
			size[$ "scale"]	 = {
				factor:   {
					current: {
						value: _data[$ "scale"] ?? 1,
					},
					target:  {
						value: (_data[$ "scale_lerp_target"] ?? _data[$ "scale"]) ?? 1,
						speed: {
							value: _data[$ "scale_lerp_speed"] ?? 0.25,
							start: _data[$ "scale_lerp_speed"] ?? 0.25,
						},
					},
				},
				factor_x: {
					current: {
						value: ((_data[$ "scale_x_start" ] ?? _data[$ "scale_x"]) ?? _self[$ "image_xscale"]) ?? 1,
					},
					target:  {
						value: ((_data[$ "scale_x_lerp_target"] ?? _data[$ "scale_x"]) ?? _self[$ "image_xscale"]) ?? 1,
						speed: {
							value: _data[$ "scale_x_lerp_speed"] ?? 0.25,
							start: _data[$ "scale_x_lerp_speed"] ?? 0.25,
						},
					},
				},
				factor_y: {
					current: {
						value: ((_data[$ "scale_y_start"] ?? _data[$ "scale_y"]) ?? _self[$ "image_yscale"]) ?? 1,
					},
					target:  {
						value: ((_data[$ "scale_y_lerp_target"] ?? _data[$ "scale_y"]) ?? _self[$ "image_yscale"]) ?? 1,
						speed: {
							value: _data[$ "scale_y_lerp_speed"] ?? 0.25,
							start: _data[$ "scale_y_lerp_speed"] ?? 0.25,
						},
					},
				},
			};
		};
		
		// events
		on_initialize(function() {
			image_xscale = scale_get_x();
			image_yscale = scale_get_y();
		});
		on_update	 (function() {
			__.entity.transform.scale_update_all();
		});
		
	#endregion
	#region angle .............|
	
		// public
		angle_get = function() {
			return __.entity.transform.angle;
		};
		angle_set = function(_angle) {
			__.entity.transform.angle = _angle;
			image_angle				  = _angle;
			return self;
		};
			
		// private
		__.entity[$ "transform"] ??= {};
		with (__.entity.transform) {
			angle_update = method(_self, function() {
				// angle lerping here ...
			});
			angle		 = (_data[$ "angle"] ?? _self[$ "image_angle"]) ?? 0;
		};
		
		// events
		on_initialize(function() {
			angle_set(__.entity.transform.angle);
		});
		on_update(function() {
			__.entity.transform.angle_update();
		});
	
	#endregion
	#region interactions ......|
	
		// public
		intersecting_point = function(_x, _y) {
			return point_in_rectangle(
				_x, 
				_y,
				position_get_left(),
				position_get_top(),
				position_get_right(),
				position_get_bottom(),
			);
		};
		touching_mouse	   = function(_device_index = 0) {
			var _x = device_mouse_x(_device_index);
			var _y = device_mouse_y(_device_index);
			return intersecting_point(_x, _y);
		};
		touching_mouse_gui = function(_device_index = 0) {
			var _x = device_mouse_x_to_gui(_device_index);
			var _y = device_mouse_y_to_gui(_device_index);
			return intersecting_point(_x, _y);
		};
		
	#endregion
	#region visuals ...........|
	
		// public	
		alpha_get			   = function() {
			return __.entity.visual.alpha;	
		};
		alpha_set			   = function(_alpha) {
			__.entity.visual.alpha = _alpha;
			image_alpha			   = _alpha;
			return self;
		};
		color_get			   = function() {
			return __.entity.visual.color;	
		};
		color_set			   = function(_color) {
			__.entity.visual.color = _color;
			image_blend			   = _color;
			return self;
		};
		depth_get			   = function() {
			return __.entity.visual.depth;
		};
		depth_set			   = function(_depth) {
			__.entity.visual.depth = _depth;
			depth				   = _depth;
			return self;
		};
		facing_get			   = function() {
			return __.entity.visual.facing;	
		};
		facing_set			   = function(_facing) {
			__.entity.visual.facing = _facing;
			return self;
		};
		render_bbox			   = function(_color = color_get(), _outline = true) {
			draw_rectangle_color(
				position_get_left(),
				position_get_top(),
				position_get_right(),
				position_get_bottom(),
				_color,
				_color,
				_color,
				_color,
				_outline,
			);
			return self;
		};
		render_get_default	   = function() {
			return __.entity.visual.render_default;	
		};
		render_get_function	   = function() {
			return __.entity.visual.render_function;	
		};
		render_set_function	   = function(_function) {
			__.entity.visual.render_function = _function;
			return self;
		};
		render_set_pre_render  = function(_function) {
			__.entity.visual.render_pre_render = _function;
			return self;
		};
		render_set_post_render = function(_function) {
			__.entity.visual.render_post_render = _function;
			return self;
		};
			
		// private
		__.entity[$ "visual"] ??= {};
		with (__.entity.visual) {
			alpha_update	   = method(_self, function() {
				// alpha lerping here ...
			});
			depth_update	   = method(_self, function() {
				// depth lerping here ...
			});
			render_sprite_ext  = method(_self, function() {
				var _sprite_index  =  sprite_get_sprite_index();
				if (_sprite_index !=  undefined
				&&	_sprite_index != -1
				&&	 alpha_get() > 0
				) {
					draw_sprite_ext(
						sprite_get_sprite_index(),
						sprite_get_image_index(),
						position_get_x(),
						position_get_y(),
						scale_get_x(true, true),
						scale_get_y(true),
						angle_get(),
						color_get(),
						alpha_get(),
					);
				};
			});
			render_default	   = method(_self, function() {
				if (__.entity.visual.render_z_undergound_partial) {
					var _z = position_get_z();
					if (( __.entity.transform.position.z.up_is_negative && _z > 0)
					||  (!__.entity.transform.position.z.up_is_negative && _z < 0) 
					) {
						if (abs(_z) <= sprite_height) {
							__.entity.visual.render_partial(_z);
						}
					}
					else __.entity.visual.render_sprite_ext();
				}
				else __.entity.visual.render_sprite_ext();
			});
			render_partial     = method(_self, function(_z = position_get_z()) {
				var _facing = facing_get();
				draw_sprite_part_ext(
					sprite_index,
					image_index,
					0,
					0,
					sprite_width,
					sprite_height - abs(_z),
					position_get_x() - (sprite_xoffset * _facing),
					position_get_y() -  sprite_yoffset,
					scale_get_x() * _facing,
					scale_get_y(),
					image_blend,
					image_alpha,
				);
			});
			render_function	   = render_default;
			render_pre_render  = undefined;
			render_post_render = undefined;
			
			alpha  = (_data[$ "alpha" ] ?? _self[$ "image_alpha"]) ?? 1;
			color  = (_data[$ "color" ] ?? _self[$ "image_blend"]) ?? c_white;
			depth  = (_data[$ "depth" ] ?? _self[$ "depth"		]) ?? 0;
			facing =  _data[$ "facing"] ?? 1;
			
			// if set to true, if the z value ever goes "underground"
			// then we will use draw_sprite_part() in order to achieve
			// a visual effect that makes it look like the entity is
			// partially underground.
			render_z_undergound_partial = _data[$ "render_z_underground_partial"] ?? true;
		};
		
		// events
		on_initialize(function() {
			alpha_set (alpha_get ());
			color_set (color_get ());
			depth_set (depth_get ());
			facing_set(facing_get());
		});
		on_update	 (function() {
			__.entity.visual.alpha_update();
			__.entity.visual.depth_update();
		});
		on_render	 (function() {
			if (__.entity.visual.render_pre_render  != undefined) {
				__.entity.visual.render_pre_render();
			}
			if (__.entity.visual.render_function    != undefined) {
				__.entity.visual.render_function();	
			}
			if (__.entity.visual.render_post_render != undefined) {
				__.entity.visual.render_post_render();
			}
		});
	
	#endregion
	
	