
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   ______  ______   __   ______  ______    //
	// /\  ___\ /\  == \/\  == \ /\ \ /\__  _\/\  ___\   //
	// \ \___  \\ \  _-/\ \  __< \ \ \\/_/\ \/\ \  __\   //
	//  \/\_____\\ \_\   \ \_\ \_\\ \_\  \ \_\ \ \_____\ //
	//   \/_____/ \/_/    \/_/ /_/ \/_/   \/_/  \/_____/ //
	//                                                   //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function IB_Entity_Sprite(_config = {}) : IB_Entity(_config) constructor {
		
		var _self =  self;
		var _data = _config;
		
		// public
		sprite_get_image_index	= function() {
			return __.entity.visual.image_index;
		};
		sprite_get_image_speed	= function() {
			return __.entity.visual.image_speed;	
		};
		sprite_get_sprite_index = function() {
			return __.entity.visual.sprite_index;
		};
		sprite_set_image_index	= function(_image_index) {
			__.entity.visual.image_index = _image_index;
			return self;
		};
		sprite_set_image_speed  = function(_image_speed) {
			__.entity.visual.image_speed = _image_speed;
			return self;
		};
		sprite_set_sprite_index = function(_sprite_index) {
			if (_sprite_index != undefined) {
				__.entity.visual.sprite_number = sprite_get_number(_sprite_index);
			}
			__.entity.visual.sprite_index = _sprite_index;
			return self;
		};
		
		// private
		with (__.entity.visual) {
			render_default	=  method(_self, function() {
				var _sprite_index  =  sprite_get_sprite_index();
				if (_sprite_index !=  undefined
				&&	_sprite_index != -1
				&&	 alpha_get() > 0
				) {
					draw_sprite_ext(
						_sprite_index,
						sprite_get_image_index(),
						position_get_x(),
						position_get_y(),
						scale_get_x(true, true),
						scale_get_y(true),
						angle_get(),
						color_get(),
						alpha_get(),
					);
				}
			});
			render_function = _data[$ "render_function"] ?? render_default;
			sprite_index	= _data[$ "sprite_index"   ] ?? undefined;
			image_index		= _data[$ "image_index"    ] ?? 0;
			image_speed		= _data[$ "image_speed"	   ] ?? 1;
			sprite_number   =  0;
			
			// set to assign sprite_number
			_self.sprite_set_sprite_index(sprite_index);
		};
		
		// events
		on_update(function() {
			if (__.entity.visual.sprite_index !=  undefined
			&&	__.entity.visual.sprite_index != -1
			&&	__.entity.visual.image_speed   >  0
			) {
				__.entity.visual.image_index += __.entity.visual.image_speed;
				__.entity.visual.image_index %= __.entity.visual.sprite_number;
			}
		});
	};


	