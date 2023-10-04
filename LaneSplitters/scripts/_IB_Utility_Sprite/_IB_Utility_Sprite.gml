
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   ______  ______   __   ______  ______    //
	// /\  ___\ /\  == \/\  == \ /\ \ /\__  _\/\  ___\   //
	// \ \___  \\ \  _-/\ \  __< \ \ \\/_/\ \/\ \  __\   //
	//  \/\_____\\ \_\   \ \_\ \_\\ \_\  \ \_\ \ \_____\ //
	//   \/_____/ \/_/    \/_/ /_/ \/_/   \/_/  \/_____/ //
	//                                                   //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function _IB_Utility_Sprite() constructor {
	
		static animation_ended   = function(_sprite_index = sprite_index, _image_index = image_index, _image_speed = image_speed, _image_number = image_number) {
			
			var _units = (sprite_get_speed_type(_sprite_index) == spritespeed_framespergameframe) ? 1 : game_get_speed(gamespeed_fps);
			var _fixed = _image_index + _image_speed * sprite_get_speed(_sprite_index) / _units;
			
			return _fixed >= _image_number;
		};
		static image_index_is	 = function(_image_index_target, _sprite_index = sprite_index, _image_index = image_index, _image_speed = image_speed) {
			
			var _units = (sprite_get_speed_type(_sprite_index) == spritespeed_framespergameframe) ? 1 : game_get_speed(gamespeed_fps);
			var _fixed = _image_index + _image_speed * sprite_get_speed(_sprite_index) / _units;
			
			return _fixed == (_image_index_target + 1);
		};
		static get_bbox_center_x = function(_sprite_index) {
			return get_bbox_width(_sprite_index) * 0.5;
		};
		static get_bbox_center_y = function(_sprite_index) {
			return get_bbox_height(_sprite_index) * 0.5;
		};
		static get_bbox_height   = function(_sprite_index) {
			return sprite_get_bbox_bottom(_sprite_index) - sprite_get_bbox_top(_sprite_index);
		};
		static get_bbox_width    = function(_sprite_index) {
			return sprite_get_bbox_right(_sprite_index) - sprite_get_bbox_left(_sprite_index);
		};
	};

