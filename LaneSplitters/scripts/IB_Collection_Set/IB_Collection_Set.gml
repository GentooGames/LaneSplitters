
	// ~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   ______  ______  //
	// /\  ___\ /\  ___\/\__  _\ //
	// \ \___  \\ \  __\\/_/\ \/ //
	//  \/\_____\\ \_____\ \ \_\ //
	//   \/_____/ \/_____/  \/_/ //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function IB_Collection_Set(_config = {}) constructor {
	
		// public
		static add				 = function(_set_id, _item) {
			if (!contains(_set_id)) {
				__.sets.set(_set_id, array_create(0));
			}
			var _array = __.sets.get(_set_id);
			array_push(_array, _item);
			return self;
		};
		static clear			 = function(_set_id = undefined) {
			if (_set_id != undefined) {
				 __.sets.set(_set_id, array_create(0));
			}
			else __.sets.clear();
			return self;
		};
		static contains			 = function(_set_id = undefined, _item = undefined) {
		
			// contains item in set
			if (_set_id != undefined && _item != undefined) {
				var _array = __.sets.get(_set_id);
				return iceberg.array.contains(_array, _item);
			}
			// contains set
			else if (_set_id != undefined) {
				var _struct = __.sets.get_items();
				return iceberg.struct.contains(_struct, _set_id);
			}
			// contains item
			else if (_item != undefined) {
				var _struct = __.sets.get_items();
				var _array  = iceberg.struct.to_array(_struct);
				return iceberg.array.contains(_array, _item);
			}
			return true;
		};	
		static for_each_item	 = function(_callback, _data = undefined) {
			var _count = __.sets.get_size();
			for (var _i = 0; _i < _count; _i++) {
				var _array = __.sets.get_by_index(_i);
				iceberg.array.for_each(_array, _callback, _data);
			};
		};
		static for_each_item_ext = function(_callback, _data = undefined) {
			
			var _categories		= __.sets.get_items();
			var _category_names = variable_struct_get_names(_categories);
			var _category_count = array_length(_category_names);
			
			for (var _i = 0; _i < _category_count; _i++) {
				var _category_name	= _category_names[_i];
				var _category_array	= _categories[$ _category_name];
				
				for (var _j = array_length(_category_array) - 1; _j >= 0; _j--) {
					_callback({
						data:	_data,
						struct: _categories,
						array:	_category_array,
						item:	_category_array[_j],
						name:	_category_name,
						
					});
				};
			}
		};
		static get_items		 = function(_set_id = undefined) {
			if (_set_id == undefined) {
				return __.sets.get_items();
			}
			return __.sets.get(_set_id);
		};
		static get_name			 = function(_index) {
			return __.sets.get_name(_index);
		};
		static get_names		 = function() {
			return __.sets.get_names();
		};
		static get_random		 = function(_set_id = undefined) {
		
			if (_set_id != undefined) {
				var _array = __.sets.get(_set_id);
				return iceberg.array.get_random(_array);
			}
			else {
				var _struct = __.sets.get_items();
				var _array  = iceberg.struct.get_random(_struct);
				return iceberg.array.get_random(_array);
			}
			return undefined;
		};
		static get_size			 = function(_set_id = undefined) {
			if (_set_id == undefined) {
				return __.sets.get_size();
			}
			var _array = __.sets.get(_set_id);
			return array_length(_array);
		};
		static is_empty			 = function(_set_id = undefined) {
			if (_set_id == undefined) {
				return get_size() == 0;
			}
			else {
				var _array  = get_items(_set_id);
				if (_array == undefined) {
					return true;	
				}
				return array_length(_array) == 0;
			}
		};
		static remove			 = function(_set_id = undefined, _item = undefined) {
		
			// remove item in set
			if (_set_id != undefined && _item != undefined) {
				var _array = __.sets.get(_set_id);
				iceberg.array.find_delete(_array, _item);
			
				// remove array entirely if empty
				if (array_length(_array) == 0) {
					__.sets.remove(_set_id);
				}
			}
			// remove set
			else if (_set_id != undefined) {
				__.sets.remove(_set_id);
			}
			// remove just item
			else if (_item != undefined) {
				var _names  = __.sets.get_names();
				for (var _i = 0; _i < __.sets.get_size(); _i++) {
					var _name  = _names[_i];
					var _array = __.sets.get(_name);
					iceberg.array.find_delete(_array, _item);
				
					// remove array entirely if empty
					if (array_length(_array) == 0) {
						__.sets.remove(_name);
					}
				};
			}
			return self;
		};
		static reset			 = function() {
			__.sets.clear();
			return self;
		};
			
		// private
		__ = {};
		with (__) {
			sets = new IB_Collection_Struct();
		};
	};
