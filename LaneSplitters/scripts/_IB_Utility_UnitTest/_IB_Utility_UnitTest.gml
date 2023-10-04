
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______  ______   ______   ______  //
	// /\__  _\/\  ___\ /\  ___\ /\__  _\ //
	// \/_/\ \/\ \  __\ \ \___  \\/_/\ \/ //
	//    \ \_\ \ \_____\\/\_____\  \ \_\ //
	//     \/_/  \/_____/ \/_____/   \/_/ //
	//                                    //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function _IB_Utility_UnitTest() constructor {
	
		static compare_instance_count_data = function(_instance_struct_data_1, _instance_struct_data_2) {
			var _return_data = { 
				equals: true, 
				data:	{} 
			};
			var _object_indexes = resource_tree_get_objects();
			for (var _i = 0, _len =  array_length(_object_indexes); _i < _len; _i++) {
				var _object_index = _object_indexes[_i];
				var _object_name  =  object_get_name(_object_index);
				var _value_1	  = _instance_struct_data_1[$ _object_name];
				var _value_2	  = _instance_struct_data_2[$ _object_name];
				if (_value_1 != _value_2) {
					_return_data.equals = false;
					_return_data.data   = {
						object_index: _object_index,
						count_delta:  abs( _value_2 - _value_1),
						count_sign:   sign(_value_2 - _value_1),
					};
					break;
				}
			}
			return _return_data;
		};
		static get_instance_count_data	   = function() {
		
			#region [info] 
			/*	
				return: {
					<object_index>: <number_of_instances>,
					...
					<object_index>: <number_of_instances>,
				},
			*/
			#endregion
			
			var _count_data	= {};
			var _object_indexes = iceberg.asset_tree.get_objects_as_array();
			for (var _i = 0, _len = array_length(_object_indexes); _i < _len; _i++) {
				var _object_index = _object_indexes[_i];
				var _object_name  = object_get_name(_object_index);
				var _object_count = instance_number(_object_index);
				_count_data[$ _object_name] = _object_count;
			}
			return _count_data;
		};
	};
