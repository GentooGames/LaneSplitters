
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   ______  ______   __  __   ______   ______  //
	// /\  ___\ /\__  _\/\  == \ /\ \/\ \ /\  ___\ /\__  _\ //
	// \ \___  \\/_/\ \/\ \  __< \ \ \_\ \\ \ \____\/_/\ \/ //
	//  \/\_____\  \ \_\ \ \_\ \_\\ \_____\\ \_____\  \ \_\ //
	//   \/_____/   \/_/  \/_/ /_/ \/_____/ \/_____/   \/_/ //
	//                                                      //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function _IB_Utility_Struct() constructor {
		
		static append			= function(_struct /* struct_1, ..., struct_n */) {
			for (var _i = 1; _i < argument_count; _i++) {
				var _struct_in = argument[_i];
				var _names	   = variable_struct_get_names(_struct_in);
				var _size	   = array_length(_names);
		
				for (var _j = 0; _j < _size; _j++) {
					var _name = _names[_j];
					var _item = _struct_in[$ _name];
					_struct[$ _name] = _item;
				};
			};
			return _struct;
		};
		static assign_to		= function(_struct_source, _struct_target) {
			var _names = variable_struct_get_names(_struct_source);
			var _size  = variable_struct_names_count(_struct_source);
			for (var _i = 0; _i < _size; _i++) {
				var _name = _names[_i];
				var _item = _struct_source[$ _name];
				variable_struct_set(_struct_target, _name, _item);
			};
			return _struct_source;
		};
		static clear			= function(_struct) {
			return {};
		};
		static compare			= function(_struct_1, _struct_2) {};
		static contains			= function(_struct /* name_1, ..., name_n */) {
			for (var _i = 1; _i < argument_count; _i++) {
				var _name = argument[_i];
				if (_struct[$ _name] == undefined) {
					return false;
				}
			};
			return true;
		};
		static copy_lazy		= function(_struct) {
			// will deep copy values, but will not preserve class instances.
			// THIS IS SLOW! DO NOT USE IN A STEP EVENT IF POSSIBLE
			return json_parse(json_stringify(_struct));
		};
		static create			= function() {
			return {};
		};
		static default_value	= function(_struct, _member_name, _default_value) {
			_struct[$ _member_name] ??= _default_value;
			return _struct;
		};
		static default_values	= function(_struct /* member_name_1, default_value_1, ..., member_name_n, default_value_n*/) {
			
			// argument count is odd
			if ((argument_count - 1) % 2 == 1) exit;	
		
			for (var _i = 1; _i < argument_count; _i += 2) {
				var _name  = argument[_i];
				var _value = argument[_i + 1];
				default_value(_struct, _name, _value);
			};
			return _struct;
		};
		static deserialize		= function(_struct, _string) {};
		static destroy			= function(_context = other, _name, _run_cleanup = false) {
			if (_run_cleanup) {
				_context[$ _name].cleanup();
			}
			_context[$ _name] = undefined;
		};
		static extract			= function(_struct /* value_1, ..., value_n */) {
			var _names	   = variable_struct_get_names(_struct);
			var _size	   = variable_struct_names_count(_struct);
			var _extracted = {};
		
			for (var _i = 1; _i < argument_count; _i++) {
				var _value  = argument[_i];
				for (var _j = 0; _j < _size; _j++) {
					var _name  = _names[_j];
					var _item  = _struct[$ _name];
					if (_item == _value) {
						_extracted[$ _name] = _item;	
						variable_struct_remove(_struct, _name);
					}
				};
			};
			return _extracted;
		};
		static extract_to_array	= function(_struct /* value_1, ..., value_n */) {
			var _names	   = variable_struct_get_names(_struct);
			var _size	   = variable_struct_names_count(_struct);
			var _extracted = array_create(_size, 0);
		
			for (var _i = 1; _i < argument_count; _i++) {
				var _value  = argument[_i];
				for (var _j = 0; _j < _size; _j++) {
					var _name  = _names[_j];
					var _item  = _struct[$ _name];
					if (_item == _value) {
						_extracted[_j] = _item;	
						variable_struct_remove(_struct, _name);
					}
				};
			};
			return _extracted;
		};
		static for_each			= function(_struct, _callback, _data = undefined) {
			/*
				callback = function(_struct_item, _data = undefined) {};
			*/
			var _names = variable_struct_get_names(_struct);
			var _count = array_length(_names);
			for (var _i = 0; _i < _count; _i++) {
				var _name = _names[_i];
				var _item = _struct[$ _name];
				_callback(_item, _data);
			};
		};
		static for_each_ext		= function(_struct, _callback, _data = undefined) {
			/*
				callback = function(_struct, _struct_item_name, _struct_item, _data = undefined) {};
			*/
			var _names = variable_struct_get_names(_struct);
			var _count = array_length(_names);
			for (var _i = 0; _i < _count; _i++) {
				var _name = _names[_i];
				var _item = _struct[$ _name];
				_callback(_struct, _name, _item, _data);
			};
		};
		static generate_name	= function(_struct) {
			var _prefix = instanceof(_struct);
			var _suffix = string(ptr(_struct));
			return _prefix + "_" + _suffix;
		};
		static get_random		= function(_struct) {
			var _name = get_key_random(_struct);
			return _struct[$ _name];
		};
		static get_key			= function(_struct, _value) {
			var _names = variable_struct_get_names(_struct);
			var _count = variable_struct_names_count(_struct);
			for (var _i = 0; _i < _count; _i++) {
				var _name = _names[_i];
				if (_struct[$ _name] == _value) {
					return _name;	
				}
			}
			return "";
		};
		static get_key_random	= function(_struct) {
			var _size  = variable_struct_names_count(_struct);
			if (_size == undefined) {
				return "";
			}
			var _names = variable_struct_get_names(_struct);
			return iceberg.array.get_random(_names);
		};
		static is_empty			= function(_struct) {
			return variable_struct_names_count(_struct) == 0;
		};
		static is_child_of		= function(_struct, _parent_class_name_string) {
			
			var _parent_name = _parent_class_name_string;
			var _child_name  =  instanceof(_struct);
		
			if (_child_name == undefined 
			||	_child_name == "instance" 
			||	_child_name == "struct" 
			||	_child_name == "weakref"
			) {
				return false;	
			}
			return iceberg.text.contains(_parent_name, _child_name);
		};
		static names_match		= function(_struct, _struct_compare) {
			var _struct_1_vars = variable_struct_get_names(_struct);
			var _struct_2_vars = variable_struct_get_names(_struct_compare);
			var _struct_1_size = variable_struct_names_count(_struct);
			var _struct_2_size = variable_struct_names_count(_struct_2_vars);
			for (var _i = 0; _i < _struct_1_size; _i++) {
				var _struct_1_var = _struct_1_vars[_i];	
				var _found_match  =  false;
				for (var _j = 0; _j < _struct_2_size; _j++) {
					var _struct_2_var  = _struct_2_vars[_j];
					if (_struct_2_var == _struct_1_var) {
						_found_match  = true;
						break;
					}
				}
				if (!_found_match) return false;
			}
			return true;
		};
		static serialize		= function(_struct) {};
		static to_array			= function(_struct, _sub_key = "") {
			var _names  = variable_struct_get_names(_struct);
			var _size   = variable_struct_names_count(_struct);
			var _array  = array_create(_size, 0);
			for (var _i = 0; _i < _size; _i++) {
				var _name  = _names[_i];
				var _item  = _struct[$ _name];
				if (_sub_key != "") {
					_item = _item[$ _sub_key];
				}
				_array[_i] = _item;
			};
			return _array;
		};
		static names_to_array	= function(_struct) {
			var _names  = variable_struct_get_names(_struct);
			var _size   = variable_struct_names_count(_struct);
			var _array  = array_create(_size, 0);
			for (var _i = 0; _i < _size; _i++) {
				_array[_i] = _names[_i];
			};
			return _array;
		};
		static validate_members	= function(_struct, _member_name, _member_value /*, ..., member_value_n */) {
			static _error_msg = "ERROR : {0} does not contain valid member {1}";
		
			// struct doesnt even contain member
			//if (_struct[$ _member_name] == undefined) {
			//	//iceberg.system.error(_error_msg, instanceof(_struct), _member_name);	
			//	exit;
			//}
		
			// check if member is one of the acceptable values
			var _valid = false;
			for (var _i = 2; _i < argument_count; _i++) {
				if (_struct[$ _member_name] == argument[_i]) {
					_valid = true;
					break;
				}
			};
		
			//if (!_valid) {
			//	//iceberg.system.error(_error_msg, instanceof(_struct), "");	
			//	exit;
			//}
			return _struct[$ _member_name];
		};
	};
