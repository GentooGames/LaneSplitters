
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  __  __   ______   __  __   ______   __   __   __   _____    //
	// /\ \/ /  /\  ___\ /\ \_\ \ /\  == \ /\ \ /\ "-.\ \ /\  __-.  //
	// \ \  _"-.\ \  __\ \ \____ \\ \  __< \ \ \\ \ \-.  \\ \ \/\ \ //
	//  \ \_\ \_\\ \_____\\/\_____\\ \_____\\ \_\\ \_\\"\_\\ \____- //
	//   \/_/\/_/ \/_____/ \/_____/ \/_____/ \/_/ \/_/ \/_/ \/____/ //
	//                                                              //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function __IB_System_Input_Keybind(_config = {}) : IB_Base(_config) constructor {
	
		var _self = self;
		
		// = PRIVATE ===============
		with (__) {
			static __check_operator = function(_check_result, _operator = __.operator, _value = __.value) {
				switch (_operator) {
					case "=":  return _check_result == _value;
					case "!=": return _check_result != _value;
					case "<":  return _check_result <  _value;
					case "<=": return _check_result <= _value;
					case ">":  return _check_result >  _value;
					case ">=": return _check_result >= _value;
				};
				return false;
			};
			static __key_is_axis	= function(_key) {
				static _axis_keys = [ 
					gp_axislh, 
					gp_axislv, 
					gp_axisrh, 
					gp_axisrv 
				];
				for (var _i = 0; _i < 4; _i++) {
					if (_key == _axis_keys[_i]) {
						return true;	
					}
				};
				return false;
			};
			
			keys		= _config[$ "keys"	  ] ?? [];
			operator	= _config[$ "operator"] ?? "=";
			type		= _config[$ "type"	  ] ?? undefined;
			value		= _config[$ "value"   ] ?? 1;
			verb		= _config.verb;
			keybindings =  owner;
			keys_count	=  array_length(keys);
		};
	};
	
	
	