
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  __  __   ______   __  __       __    __   ______   __  __   ______   ______    //
	// /\ \/ /  /\  ___\ /\ \_\ \     /\ "-./  \ /\  __ \ /\ \/\ \ /\  ___\ /\  ___\   //
	// \ \  _"-.\ \  __\ \ \____ \    \ \ \-./\ \\ \ \/\ \\ \ \_\ \\ \___  \\ \  __\   //
	//  \ \_\ \_\\ \_____\\/\_____\    \ \_\ \ \_\\ \_____\\ \_____\\/\_____\\ \_____\ //
	//   \/_/\/_/ \/_____/ \/_____/     \/_/  \/_/ \/_____/ \/_____/ \/_____/ \/_____/ //
	//                                                                                 //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function __IB_System_Input_Keybind_KeyboardMouse(_config = {}) : __IB_System_Input_Keybind(_config) constructor {
	
		var _self = self;
	
		// public
		static check_pressed  = function(_device_index) {
			if (is_active()) {
				return __check("pressed", _device_index);
			}
			return false;
		};
		static check_down	  = function(_device_index) {
			if (is_active()) {
				return __check("down", _device_index);
			}
			return false;
		};
		static check_released = function(_device_index) {
			if (is_active()) {
				return __check("released", _device_index);
			}
			return false;
		};
		
		// private
		with (__) {
			static __key_is_mouse = function(_key) {
				return (_key == mb_any
					||	_key == mb_left
					||	_key == mb_right
					||	_key == mb_middle
					||	_key == mb_none
					||	_key == mb_side1
					||	_key == mb_side2
				);
			};
			static __check		  = function(_button_action, _device_index) {
				for (var _i = 0; _i < __.keys_count; _i++) {
					var _key	  = __.keys[_i];
					var _is_mouse = __key_is_mouse(_key);
					
					switch (_button_action) {
						case "pressed":
							var _result = (_is_mouse)
								? device_mouse_check_button_pressed(_device_index, _key)
								: keyboard_check_pressed(_key);	
							break;
							
						case "down":
							var _result = (_is_mouse)
								? device_mouse_check_button(_device_index, _key)
								: keyboard_check(_key);	
							break;
							
						case "released":
							var _result = (_is_mouse)
								? device_mouse_check_button_released(_device_index, _key)
								: keyboard_check_released(_key);	
							break;
					};
					
					
					if (__check_operator(_result)) {
						return true;	
					}
				};
				return false;
			};
			
			type = "keyboard_mouse";
		};
	};
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	