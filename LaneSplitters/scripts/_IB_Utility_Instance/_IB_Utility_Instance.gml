
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  __   __   __   ______   ______  ______   __   __   ______   ______    //
	// /\ \ /\ "-.\ \ /\  ___\ /\__  _\/\  __ \ /\ "-.\ \ /\  ___\ /\  ___\   //
	// \ \ \\ \ \-.  \\ \___  \\/_/\ \/\ \  __ \\ \ \-.  \\ \ \____\ \  __\   //
	//  \ \_\\ \_\\"\_\\/\_____\  \ \_\ \ \_\ \_\\ \_\\"\_\\ \_____\\ \_____\ //
	//   \/_/ \/_/ \/_/ \/_____/   \/_/  \/_/\/_/ \/_/ \/_/ \/_____/ \/_____/ //
	//                                                                        //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function _IB_Utility_Instance() constructor {

		static generate_name = function(_instance) {
			var _prefix = object_get_name(_instance.object_index);
			var _suffix = string(_instance);
			return _prefix + "_" + _suffix;	
		};
		static nth_nearest	 = function(_x, _y, _object_index, _n, _priority_list) {
			var _count	 = min(max(1, _n), instance_number(_object_index));
			var _nearest = undefined;
			ds_priority_clear(_priority_list);
			with (_object_index) {
				ds_priority_add(_priority_list, self.id, distance_to_point(_x, _y)); 
			}
			repeat (_count) {
				_nearest = ds_priority_delete_min(_priority_list); 
			}
			return _nearest;
		};
	};
