

	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  __    __   ______   __  __   ______   ______    //
	// /\ "-./  \ /\  __ \ /\ \/\ \ /\  ___\ /\  ___\   //
	// \ \ \-./\ \\ \ \/\ \\ \ \_\ \\ \___  \\ \  __\   //
	//  \ \_\ \ \_\\ \_____\\ \_____\\/\_____\\ \_____\ //
	//   \/_/  \/_/ \/_____/ \/_____/ \/_____/ \/_____/ //
	//                                                  //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function __IB_System_Input_Keybind_Mouse(_config = {}) : __IB_System_Input_Keybind(_config) constructor {

		var _self = self;
		
		// need to add ability to check for mouse_wheel_up() & mouse_wheel_down()
		// also add ability to check for double click on mouse buttons.
		
		// public
		static check_pressed  = function(_device_index) {
			if (is_active()) {
				return __check(device_mouse_check_button_pressed, _device_index);
			}
			return false;
		};
		static check_down	  = function(_device_index) {
			if (is_active()) {
				return __check(device_mouse_check_button, _device_index);
			}
			return false;
		};
		static check_released = function(_device_index) {
			if (is_active()) {
				return __check(device_mouse_check_button_released, _device_index);
			}
			return false;
		};
		
		// private
		with (__) {
			static __check = function(_button_function, _device_index) {
				for (var _i = 0; _i < __.keys_count; _i++) {
					var _key    = __.keys[_i];
					var _result = _button_function(_device_index, _key);
					if (__check_operator(_result)) {
						return true;	
					}
				};
				return false;
			};
			
			type = "mouse";
		};
	};