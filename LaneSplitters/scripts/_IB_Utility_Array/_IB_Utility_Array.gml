
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   ______   ______   ______   __  __    //
	// /\  __ \ /\  == \ /\  == \ /\  __ \ /\ \_\ \   //
	// \ \  __ \\ \  __< \ \  __< \ \  __ \\ \____ \  //
	//  \ \_\ \_\\ \_\ \_\\ \_\ \_\\ \_\ \_\\/\_____\ //
	//   \/_/\/_/ \/_/ /_/ \/_/ /_/ \/_/\/_/ \/_____/ //
	//                                                //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function _IB_Utility_Array() constructor {
	
		static append			 = function(_array_source /* array_1, ..., array_n */) {
			for (var _a = 1; _a < argument_count; _a++) {
				var _array_in = argument[_a];
				for (var _i = 0, _len_i = array_length(_array_in); _i < _len_i; _i++) {
					var _item_in = _array_in[_i];
					array_push(_array_source, _item_in);	
				};
			};
			return _array_source;
		};
		static append_unique	 = function(_array_source /* array_1, ..., array_n */) {
			var _source_size = array_length(_array_source);
			for (var _a = 1; _a < argument_count; _a++) {
				var _array_coming_in = argument[_a];
				for (var _i = 0, _len_i = array_length(_array_coming_in); _i < _len_i; _i++) {
					var _item_coming_in = _array_coming_in[_i];
					// check if item already exists
					if (!contains(_array_source, _item_coming_in)) {
						array_push(_array_source, _item_coming_in);	
					}
				};
			};
			return _array_source;
		};
		static clear			 = function(_array_source, _clear_value = undefined) {
			for (var _i = 0, _len = array_length(_array_source); _i < _len; _i++) {
				_array_source[_i] = _clear_value;	
			};
			return _array_source;
		};
		static compare			 = function(_array_1, _array_2) {};
		static compare_item		 = function(_array_source, _item, _compare_function = undefined) {
			// @credit: GlebTsereteli
		    static _compare_function_default = function(_item1, _item2) {
		        return (_item1 == _item2);    
		    };
		    _compare_function ??= _compare_function_default;
		    for (var _i = 0, _n = array_length(_array_source); _i < _n; _i++) {
		        if (_compare_function(_item, _array_source[_i])) {
		            return true;    
		        }
		    }
		    return false;
		};
		static contains			 = function(_array_source /* item_1, ..., item_n */) {
			var _count  = 0;
			var _size   = array_length(_array_source);
			for (var _i = 1; _i < argument_count; _i++) {
				var _item = argument[_i];
				for (var _j = 0; _j < _size; _j++) {
					if (_array_source[_j] == _item) {
						_count++;
						if (_count >= argument_count - 1) {
							return true;	
						}
					}
				};
			};
			return false;
		};
		static copy				 = function(_array_source) {
			var _size = array_length(_array_source);
			var _new  = array_create(_size);
			for (var _i = 0, _len = _size; _i < _len; _i++) {
				_new[_i] = _array_source[_i];
			};
			return _new;
		};
		static create			 = function(_size, _default_value = 0) {
			return array_create(_size, _default_value);
		};
		static create_nd		 = function(/* size_1, ..., size_n */) {
			if (argument_count == 0) {
				return undefined;
			}
			var _array = array_create(argument[0],		  undefined);
			var _args  = array_create(argument_count - 1, undefined);
			var _i	   = 0;
        
			repeat (argument_count - 1) {
				_args[_i] = argument[_i + 1];
				_i++;
			}
			_i = 0; 
				
			repeat (argument[0]) {
				var _create_nd = method_get_index(iceberg.array.create_nd);
				_array[@ _i]   = script_execute_ext(_create_nd, _args);
				_i++;
			}
			return _array;
		};
		static deserialize		 = function(_array_source, _string) {};
		static extract			 = function(_array_source /* value_1, ..., value_n */) {
			var _extracted = [];
			var _size	   = array_length(_array_source);
			for (var _i = 1; _i < argument_count; _i++) {
				var _value = argument[_i];
				for (var _j = 0; _j < _size; _j++) {
					var _item  = _array_source[_j];
					if (_item == _value) {
						array_push(_extracted, _item);	
						array_delete(_array_source, _j, 1);
					   _size--;
					   _j--;
					}
				}
			};
			return _extracted;
		};
		static find_delete		 = function(_array_source, _item) {
			var _deleted = false;
			for (var _i = array_length(_array_source) - 1; _i >= 0; _i--) {
				if (_array_source[_i] == _item) {
					array_delete(_array_source, _i, 1);	
					_deleted = true;
				}
			};
			return _deleted;
		};
		static find_delete_first = function(_array_source, _item) {
			for (var _i = array_length(_array_source) - 1; _i >= 0; _i--) {
				if (_array_source[_i] == _item) {
					array_delete(_array_source, _i, 1);	
					return true;
				}
			};	
			return false;
		};
		static find_index		 = function(_array_source, _item) {
			for (var _i = 0, _len = array_length(_array_source); _i < _len; _i++) {
				if (_array_source[_i] == _item) {
					return _i;	
				}
			};
			return -1;
		};
		static for_each			 = function(_array, _callback, _data) {
			for (var _i = 0, _len = array_length(_array); _i < _len; _i++) {
				_callback(_array[_i], _data);
			};
		};
		static get_random		 = function(_array_source) {
			var _size  = array_length(_array_source);
			if (_size <= 0) {
				return undefined;	
			}
			var _index =  irandom(_size - 1);
			var _item  = _array_source[_index];
			return _item;
		};
		static get_random_weight = function(_options) {
			//	options is an array of structs containing: {
			//		item:	<item>, 
			//		weight: <real>
			//	}
			//	weight values do not need to be out of a sum value.
			//	weights are added up and measured relatively.
		
			// calculate weights sum
			var _weights = [];
			for (var _i = 0, _len = array_length(_options); _i < _len; _i++) {
				_weights[_i] = _options[_i].weight;
				if (_i > 0) {
					_weights[_i] += _weights[_i - 1];	
				}
			};
		
			// pick random
			var _random = random(1) * _weights[_len - 1];
			for (var _i = 0; _i < _len; _i++) {
				if (_weights[_i] > _random) {
					break;	
				}
			};
			return _options[_i].item;
		};
		static in_bounds		 = function(_array_source, _index) {
			var _size  = array_length(_array_source);
			if (_size == 0) {
				return false;	
			}
			return _index >= 0 && _index <= _size - 1;
		};
		static is_empty			 = function(_array_source) {
			return array_length(_array_source) == 0;
		};
		static join				 = function(_array_source, _delineator = " ") {
			var _string = "";
			var _size   = array_length(_array_source);
			for (var _i = 0; _i < _size; _i++) {
				var _entry = _array_source[_i];
				if (_i < _size - 1) {
					_entry += _delineator;	
				}
				_string += _entry;
			};					
			return _string;
		};
		static peek_bottom		 = function(_array_source) {
			var _size  = array_length(_array_source);
			if (_size <= 0) {
				return undefined;	
			}
			return _array_source[_size - 1];
		};
		static pop_top			 = function(_array_source) {
			if (array_length(_array_source) == 0) {
				return undefined;	
			}
			var _item = _array_source[0];
			array_delete(_array_source, 0, 1);
			return _item;
		};
		static reverse			 = function(_array_source) {
			var _size	  = array_length(_array_source);
			var _reversed = array_create(_size, undefined);
			for (var _i = _size - 1; _i >= 0; _i--) {
				_reversed[_i] = _array_source[_i];
			};
			return _reversed;
		};
		static serialize		 = function(_array_source) {};
		static shuffle			 = function(_array_source) {};
		static sort				 = function(_array_source) {};
		static sort_ascending	 = function(_array) {
			array_sort(_array, function(_item_1, _item_2) {
				return _item_1 - _item_2;	
			});	
		};
		static sort_descending	 = function(_array) {
			array_sort(_array, function(_item_1, _item_2) {
				return _item_2 - _item_1;	
			});	
		};
	};
