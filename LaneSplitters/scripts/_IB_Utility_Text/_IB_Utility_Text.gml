
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______  ______  __  __   ______  //
	// /\__  _\/\  ___\/\_\_\_\ /\__  _\ //
	// \/_/\ \/\ \  __\\/_/\_\/_\/_/\ \/ //
	//    \ \_\ \ \_____\/\_\/\_\  \ \_\ //
	//     \/_/  \/_____/\/_/\/_/   \/_/ //
	//                                   //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function _IB_Utility_Text() constructor {
		
		static build			= function(_format /* param_1, ..., param_n */) {
			static _paramIDs = [
				"{0}", "{1}", "{2}", "{3}", "{4}", "{5}", "{6}", "{7}", "{8}", "{9}",
				"{10}", "{11}", "{12}", "{13}", "{14}", "{15}", "{16}", "{17}", "{18}", "{19}"
			];
			var _output = _format;
			var _count =   argument_count - 1;
			repeat (_count) {
				var _argument = argument[_count];
				var _argumentString = is_string(_argument) ? _argument : string(_argument);
				_output = string_replace_all(_output, _paramIDs[--_count], _argumentString);
			}
			return _output;
		};
		static contains			= function(_string, _substring) {
			return (string_pos(_substring, _string) != 0);
		};
		static delete_last		= function(_string) {
			var _index = string_length(_string);
			return string_delete(_string, _index, 1);
		};
		static get_alphanumeric = function(_index) {
			
			static __alpha_numeric = [
				"a", "b", "c", "d", "e", "f", "g",
				"h", "i", "j", "k", "l", "m", "n",
				"o", "p", "q", "r", "s", "t", "u",
				"v", "w", "x", "y", "z", "1", "2",
				"3", "4", "5", "6", "7", "8", "9",
				"0",
			];
			
			return __alpha_numeric[_index];
		};
		static get_letter		= function(_index) {
			
			static __alphabet = [
				"a", "b", "c", "d", "e", "f", "g",
				"h", "i", "j", "k", "l", "m", "n",
				"o", "p", "q", "r", "s", "t", "u",
				"v", "w", "x", "y", "z",
			];
			
			return __alphabet[_index];
		};
		static get_number		= function(_index) {
			
			static __numbers = [
				"1", "2", "3", 
				"4", "5", "6", 
				"7", "8", "9",
				"0",
			];
			
			return __numbers[_index];	
		};
		static split			= function(_string, _delineator = " ") {
			var _array	= [];
			var _entry	= "";
			for (var _i = 1, _len = string_length(_string); _i <= _len; _i++) {
				var _char  = string_char_at(_string, _i);	
				if (_char != _delineator) {	
					_entry += _char;	
				}
				if (_char == _delineator || _i == _len) {
					array_push(_array, _entry);
					_entry = "";
				}
			}
			return _array;
		};
		static to_struct		= function(_string, _keys_array, _delineator = " ") {
			var _struct = {};
			var _value  = "";
			var _index  = 0;
			for (var _i = 1, _len = string_length(_string) + 1; _i <= _len; _i++) {
				var _char = string_char_at(_string, _i);
			
				if (_char == _delineator || _i == _len) {
					_struct[$ _keys_array[_index]] = _value;
					_value = "";
					_index++;
				}
				else {
					_value += _char;
				}
			}
			return _struct;		
		};
	};