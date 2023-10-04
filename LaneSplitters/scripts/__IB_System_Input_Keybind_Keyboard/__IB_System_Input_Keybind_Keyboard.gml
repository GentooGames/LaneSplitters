
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  __  __   ______   __  __   ______   ______   ______   ______   _____    //
	// /\ \/ /  /\  ___\ /\ \_\ \ /\  == \ /\  __ \ /\  __ \ /\  == \ /\  __-.  //
	// \ \  _"-.\ \  __\ \ \____ \\ \  __< \ \ \/\ \\ \  __ \\ \  __< \ \ \/\ \ //
	//  \ \_\ \_\\ \_____\\/\_____\\ \_____\\ \_____\\ \_\ \_\\ \_\ \_\\ \____- //
	//   \/_/\/_/ \/_____/ \/_____/ \/_____/ \/_____/ \/_/\/_/ \/_/ /_/ \/____/ //
	//                                                                          //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function __IB_System_Input_Keybind_Keyboard(_config = {}) : __IB_System_Input_Keybind(_config) constructor {
	
		var _self = self;
		
		// public
		static check_pressed  = function() {
			if (is_active()) {
				return __check(keyboard_check_pressed);	
			}
			return false;
		};
		static check_down	  = function() {
			if (is_active()) {
				return __check(keyboard_check);
			}
			return false;
		};
		static check_released = function() {
			if (is_active()) {
				return __check(keyboard_check_released);
			}
			return false;
		};
		
		// private
		with (__) {
			static __check = function(_button_function) {
				for (var _i = 0; _i < __.keys_count; _i++) {
					var _key    = __.keys[_i];
					var _result = _button_function(_key);
					if (__check_operator(_result)) {
						return true;	
					}
				};
				return false;
			};
			
			type = "keyboard";
		};
	};