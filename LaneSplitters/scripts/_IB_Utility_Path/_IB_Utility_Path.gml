
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______  ______   ______  __  __    //
	// /\  == \/\  __ \ /\__  _\/\ \_\ \   //
	// \ \  _-/\ \  __ \\/_/\ \/\ \  __ \  //
	//  \ \_\   \ \_\ \_\  \ \_\ \ \_\ \_\ //
	//   \/_/    \/_/\/_/   \/_/  \/_/\/_/ //
	//                                     //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function _IB_Utility_Path() constructor {
	
		static is_empty					= function(_path) {
			return path_get_number(_path) == 0;
		};
		static linear_object_condition	= function(_path, _xgoal, _ygoal, _object, _stepsize = 1, _condition = undefined) {
			static _condition_check = function(_method, _instance) {
				return (_method == undefined ||	_method(_instance));
			};
			// ~~~~~~~~~~~~~~~~~~ //
			path_clear_points(_path);
	
			var _dist		= point_distance (x, y, _xgoal, _ygoal);
			var _dir		= point_direction(x, y, _xgoal, _ygoal);
			var _collisions	= ds_list_create();

			for (var _i = 0; _i <= _dist; _i += _stepsize) {
				var _x			 = x		   + lengthdir_x(_i, _dir);
				var _y			 = y		   + lengthdir_y(_i, _dir);
				var _bbox_left	 = bbox_left   + lengthdir_x(_i, _dir);
				var _bbox_right	 = bbox_right  + lengthdir_x(_i, _dir);
				var _bbox_top	 = bbox_top	   + lengthdir_y(_i, _dir);
				var _bbox_bottom = bbox_bottom + lengthdir_y(_i, _dir);	
		
				// check for collisions
				ds_list_clear(_collisions);
				var _n_collisions = collision_rectangle_list(_bbox_left, _bbox_top, _bbox_right, _bbox_bottom, _object, true, true, _collisions, false);
				for (var _j = 0; _j < _n_collisions; _j++) {
					var _collision  = _collisions[| _j];	
					if (_collision != noone && _condition_check(_condition, _collision)) {
						ds_list_destroy(_collisions);
						return false;	
					}
				}
				path_add_point(_path, _x, _y, 100);
			}	
			ds_list_destroy(_collisions);	
			return true;
		}
		static linear_object_is_active	= function(_path, _xgoal, _ygoal, _object, _stepsize = 1) {
			return linear_object_condition(_path, _xgoal, _ygoal, _object, _stepsize,
				function(_instance) {
					return _instance.active;
				}
			);
		};
		static set_smooth				= function(_path, _smooth = true) {
			path_set_kind(_path, _smooth);
			return _path;
		};
	};
