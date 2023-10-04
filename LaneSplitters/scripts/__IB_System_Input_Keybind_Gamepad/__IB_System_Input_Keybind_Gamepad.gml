

	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   ______   __    __   ______   ______  ______   _____    //
	// /\  ___\ /\  __ \ /\ "-./  \ /\  ___\ /\  == \/\  __ \ /\  __-.  //
	// \ \ \__ \\ \  __ \\ \ \-./\ \\ \  __\ \ \  _-/\ \  __ \\ \ \/\ \ //
	//  \ \_____\\ \_\ \_\\ \_\ \ \_\\ \_____\\ \_\   \ \_\ \_\\ \____- //
	//   \/_____/ \/_/\/_/ \/_/  \/_/ \/_____/ \/_/    \/_/\/_/ \/____/ //
	//                                                                  //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function __IB_System_Input_Keybind_Gamepad(_config = {}) : __IB_System_Input_Keybind(_config) constructor {

		var _self = self;
		
		// = PUBLIC ================
		static check_pressed  = function(_device_index) {
			if (is_active()) {
				return __check(gamepad_button_check_pressed, gamepad_axis_value, _device_index, "pressed");
			}
			return false;
		};
		static check_down	  = function(_device_index) {
			if (is_active()) {
				return __check(gamepad_button_check, gamepad_axis_value, _device_index, "down");
			}
			return false;
		};
		static check_released = function(_device_index) {
			if (is_active()) {
				return __check(gamepad_button_check_released, gamepad_axis_value, _device_index, "released");
			}
			return false;
		};
		
		// = PRIVATE ===============
		with (__) {
			static __check_axis_flag = function(_key, _result, _action_type) {
				switch (_key) {
					case gp_axislh: 
						var _device = __.keybindings.get_device();
						if (_result > 0) {
							 return _device.__.joystick.left.horizontal.right[$ _action_type];
						}
						else return _device.__.joystick.left.horizontal.left[$ _action_type];
						break;
					
					case gp_axislv: 
						var _device = __.keybindings.get_device();
						if (_result > 0) {
							 return _device.__.joystick.left.vertical.down[$ _action_type];
						}
						else return _device.__.joystick.left.vertical.up[$ _action_type];
						break;
						
					case gp_axisrh: 
						var _device = __.keybindings.get_device();
						if (_result > 0) {
							 return _device.__.joystick.right.horizontal.right[$ _action_type];
						}
						else return _device.__.joystick.right.horizontal.left[$ _action_type];
						break;
						
					case gp_axisrv: 
					var _device = __.keybindings.get_device();
						if (_result > 0) {
							 return _device.__.joystick.right.vertical.down[$ _action_type];
						}
						else return _device.__.joystick.right.vertical.up[$ _action_type];
						break;
				};
			};
			static __check			 = function(_button_function, _axis_function, _device_index, _action_type) {
				for (var _i = 0; _i < __.keys_count; _i++) {
					var _key = __.keys[_i];
								
					// gamepad axis check
					if (__key_is_axis(_key)) {
						var _result = _axis_function(_device_index, _key);
						if (__check_operator(_result)
						&&  __check_axis_flag(_key, _result, _action_type) 
						){
							return true;	
						}	
					}
					// gamepad button check
					else {
						var _result = _button_function(_device_index, _key);
						if (__check_operator(_result)) {
							return true;	
						}
					}
				};
				return false;
			};
			
			type = "gamepad";
		};
	};