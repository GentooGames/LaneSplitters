
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  __       __   ______   ______  //
	// /\ \     /\ \ /\  ___\ /\__  _\ //
	// \ \ \____\ \ \\ \___  \\/_/\ \/ //
	//  \ \_____\\ \_\\/\_____\  \ \_\ //
	//   \/_____/ \/_/ \/_____/   \/_/ //
	//                                 //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function _IB_Utility_List() constructor {
	
		static contains = function(_ds_list /* item_1, ..., item_n */) {
			var _count  = 0;
			var _size   = ds_list_size(_ds_list);
			for (var _i = 1; _i < argument_count; _i++) {
				var _item = argument[_i];
				for (var _j = 0; _j < _size; _j++) {
					if (_ds_list[|_j] == _item) {
						_count++;
						if (_count >= argument_count - 1) {
							return true;	
						}
					}
				};
			};
			return false;
		};
		
	};
