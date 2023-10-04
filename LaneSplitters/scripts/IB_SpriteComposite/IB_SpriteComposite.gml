
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   ______   __    __   ______  ______   ______   __   ______  ______    //
	// /\  ___\ /\  __ \ /\ "-./  \ /\  == \/\  __ \ /\  ___\ /\ \ /\__  _\/\  ___\   //
	// \ \ \____\ \ \/\ \\ \ \-./\ \\ \  _-/\ \ \/\ \\ \___  \\ \ \\/_/\ \/\ \  __\   //
	//  \ \_____\\ \_____\\ \_\ \ \_\\ \_\   \ \_____\\/\_____\\ \_\  \ \_\ \ \_____\ //
	//   \/_____/ \/_____/ \/_/  \/_/ \/_/    \/_____/ \/_____/ \/_/   \/_/  \/_____/ //
	//                                                                                //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function IB_SpriteComposite(_config = {}) : IB_Base(_config) constructor {
	
		var _self = self;
	
		// = PUBLIC ================
		static animation_ended	= function(_part_name) {
			return iceberg.sprite.animation_ended(
				get_sprite_index(_part_name),
				get_image_index (_part_name),
				get_image_speed (_part_name),
				get_image_number(_part_name),
			);
		};
		static update_composite	= function(_part_name = undefined, _state_name = __.state_name) {
			__.state_name = _state_name;
			// update just a single part
			if (_part_name != undefined) {
				__update_part(_part_name, _state_name);
			}
			// update every part
			else {
				for (var _i = 0, _len = __.parts.get_size(); _i < _len; _i++) {
					__update_part(__.parts.get_name(_i), _state_name);
				};	
			}
			return self;
		};
		static render_composite	= function(_part_name = undefined, _x, _y, _scale_x, _scale_y, _angle = 0, _color = c_white, _alpha = 1) {
			// render just a single part
			if (_part_name != undefined) {
				if (_alpha > 0) {
					 __render_part(_part_name, _x, _y, _scale_x,
						_scale_y, _angle, _color, _alpha);
				}
			}
			// render every part
			else {
				if (_alpha > 0) {
					for (var _i = 0, _len = __.parts.get_size(); _i < _len; _i++) {
						__render_part(__.parts.get_name(_i), _x, _y, 
							_scale_x, _scale_y, _angle, _color, _alpha);		
					};
				}	
			}
			return self;
		};
		
		static get_dir			= function(_part_name) {
			var _part = __.parts.get(_part_name);
			return _part.dir;
		};
		static get_image_index  = function(_part_name) {
			var _part = __.parts.get(_part_name);
			return _part.image;
		};
		static get_image_speed  = function(_part_name) {
			var _part = __.parts.get(_part_name);
			return _part.speed;
		};
		static get_image_number = function(_part_name) {
			var _part = __.parts.get(_part_name);
			return sprite_get_number(_part.index);
		};
		static get_sprite_index = function(_part_name) {
			var _part = __.parts.get(_part_name);
			return _part.index;
		};
		
		static set_dir			= function(_part_name = undefined, _dir) {
			// set just a single part
			if (_part_name != undefined) {
				__set_part_dir(_part_name, _dir);
			}
			// set every part 
			else {
				for (var _i = 0, _len = __.parts.get_size(); _i < _len; _i++) {
					__set_part_dir(__.parts.get_name(_i), _dir);
				};	
			}
			return self;
		};
		static set_image_index  = function(_part_name = undefined, _image_index) {
			// set just a single part
			if (_part_name != undefined) {
				__set_part_image_index(_part_name, _image_index);
			}
			// set every part
			else {
				for (var _i = 0, _len = __.parts.get_size(); _i < _len; _i++) {
					__set_part_image_index(__.parts.get_name(_i), _image_index);
				};	
			}
			return self;
		};
		static set_image_speed	= function(_part_name = undefined, _speed) {
			// set just a single part
			if (_part_name != undefined) {
				__set_part_speed(_part_name, _speed);
			}
			// set every part
			else {
				for (var _i = 0, _len = __.parts.get_size(); _i < _len; _i++) {
					__set_part_speed(__.parts.get_name(_i), _speed);
				};	
			}
			return self;
		};
		static set_offset		= function(_part_name = undefined, _offset_x, _offset_y = _offset_x) {
			// set just a single part
			if (_part_name != undefined) {
				__set_part_offset(_part_name, _offset_x, _offset_y);
			}
			// set every part
			else {
				for (var _i = 0, _len = __.parts.get_size(); _i < _len; _i++) {
					__set_part_offset(__.parts.get_name(_i), _offset_x, _offset_y);
				};	
			}
			return self;
		};
		static sprite_set_sprite_index = function(_part_name = undefined, _sprite_index) {
			// set just a single part
			if (_part_name != undefined) {
				__set_part_sprite_index(_part_name, _sprite_index);
			}
			// set every part
			else {
				for (var _i = 0, _len = __.parts.get_size(); _i < _len; _i++) {
					__set_part_sprite_index(__.parts.get_name(_i), _sprite_index);
				};	
			}
			return self;
		};
		
		// = PRIVATE ===============
		with (__) {
			static __render_part		   = function(_part_name, _x, _y, _scale_x, _scale_y, _angle = 0, _color = c_white, _alpha = 1) {
				with (__.parts.get(_part_name)) {
					if (index != undefined) {
						draw_sprite_ext(
							index,
							image,
							_x + ((offset.x * _scale_x) * sign(dir)),
							_y +  (offset.y * _scale_y),
							_scale_x * sign(dir),
							_scale_y,
							_angle,
							_color,
							_alpha,
						);
					}
				};
			};
			static __set_part_dir		   = function(_part_name, _dir) {
				with (__.parts.get(_part_name)) {
					dir = _dir;
				};	
			};
			static __set_part_image_index  = function(_part_name, _image_index) {
				with (__.parts.get(_part_name)) {
					image = _image_index;
				};
			};
			static __set_part_offset	   = function(_part_name, _offset_x, _offset_y = _offset_x) {
				with (__.parts.get(_part_name)) {
					offset.x = _offset_x;
					offset.y = _offset_y;
				};
			};
			static __set_part_speed		   = function(_part_name, _speed) {
				with (__.parts.get(_part_name)) {
					speed = _speed;
				};
			};
			static __set_part_sprite_index = function(_part_name, _sprite_index) {
				with (__.parts.get(_part_name)) {
					index = _sprite_index;
				};	
			};
			static __update_part		   = function(_part_name, _state_name = __.state_name) {
				with (__.parts.get(_part_name)) {
					index  = state[$ _state_name].index;
					image += speed;
					image %= sprite_get_number(index);
				};
			};
		
			data	    = _config[$ "data"	    ] ?? {};
			dir_start   = _config[$ "dir"	    ] ?? 1;
			image_start = _config[$ "image"	    ] ?? 0;
			state_name  = _config[$ "state_name"] ?? "";
			parts		= new IB_Collection_Struct();
		};
		
		// = EVENTS ================
		on_initialize(function() {
			var _part_names =  variable_struct_get_names(__.data);
			var _part_count =  array_length(_part_names);
			for (var _i = 0; _i < _part_count; _i++) {
					
				var _part_name   = _part_names[_i];
				var _part_data   = __.data[$ _part_name];
				var _state_data  = _part_data[$ "state" ];
				var _offset_data = _part_data[$ "offset"];
					
				__.parts.set(_part_name, {
					state:   _state_data,
					offset:  _offset_data,
					index:	 _state_data[$ __.state_name].index,
					speed:   _state_data[$ __.state_name].speed,
					image: __.image_start,
					dir:   __.dir_start,
				});
			};
		});
		on_cleanup   (function() {
			__.parts.cleanup();
		});
	};
	
