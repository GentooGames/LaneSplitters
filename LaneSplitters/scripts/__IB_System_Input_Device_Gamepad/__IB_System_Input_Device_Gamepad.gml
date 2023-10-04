
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   ______   __    __   ______   ______  ______   _____    //
	// /\  ___\ /\  __ \ /\ "-./  \ /\  ___\ /\  == \/\  __ \ /\  __-.  //
	// \ \ \__ \\ \  __ \\ \ \-./\ \\ \  __\ \ \  _-/\ \  __ \\ \ \/\ \ //
	//  \ \_____\\ \_\ \_\\ \_\ \ \_\\ \_____\\ \_\   \ \_\ \_\\ \____- //
	//   \/_____/ \/_/\/_/ \/_/  \/_/ \/_____/ \/_/    \/_/\/_/ \/____/ //
	//                                                                  //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function __IB_System_Input_Device_Gamepad(_config = {}) : __IB_System_Input_Device(_config) constructor {
	
		var _self = self;
		
		// public
		static get_axis_value  = function(_axis_code) {
			return gamepad_axis_value(__.device_index, _axis_code);
		};
		static get_description = function() {
			return gamepad_get_description(get_device_index());
		};
		static set_deadzone    = function(_deadzone) {
			gamepad_set_axis_deadzone(__.device_index, _deadzone);
			return self;
		};
		
		// private
		with (__) {
			static __update_axis_all	 = function() {
			  __update_axislh_left();
			  __update_axislh_right();
			  __update_axislv_up();
			  __update_axislv_down();
			  __update_axisrh_left(); 
			  __update_axisrh_right();
			  __update_axisrv_up();
			  __update_axisrv_down();
			};
			static __update_axis_flags	 = function(_gp_axis, _sign, _data_struct) {
				if (_gp_axis != gp_axislh && _gp_axis != gp_axislv) exit;
			
				var _joystick_raw	= gamepad_axis_value(__.device_index, _gp_axis);
				var _joystick_input = sign(_joystick_raw) == _sign;
			
				// pressed flag : 1 frame only
				if (!_data_struct.pressed && _joystick_input && !_data_struct.down) {
					 _data_struct.pressed = true;
				}
				else if (_data_struct.pressed) {
					_data_struct.pressed = false;	
				}
			
				// released flag : 1 frame only
				else if (_data_struct.down && !_joystick_input) {
					_data_struct.released = true;	
				}
				else if (_data_struct.released) {
					_data_struct.released = false;	
				}
			
				// down flag
				_data_struct.down = _joystick_input;
			};
			static __update_axislh_left  = function() {
				__update_axis_flags(gp_axislh, -1, __.joystick.left.horizontal.left);
			};
			static __update_axislh_right = function() {
				__update_axis_flags(gp_axislh, 1, __.joystick.left.horizontal.right);
			};
			static __update_axislv_down  = function() {
				__update_axis_flags(gp_axislv, 1, __.joystick.left.vertical.down);
			};
			static __update_axislv_up	 = function() {
				__update_axis_flags(gp_axislv, -1, __.joystick.left.vertical.up);
			};
			static __update_axisrh_left	 = function() {
				__update_axis_flags(gp_axisrh, -1, __.joystick.right.horizontal.left);
			};
			static __update_axisrh_right = function() {
				__update_axis_flags(gp_axisrh, 1, __.joystick.right.horizontal.right);
			};
			static __update_axisrv_down  = function() {
				__update_axis_flags(gp_axisrv, -1, __.joystick.left.vertical.up);
			};
			static __update_axisrv_up	 = function() {
				__update_axis_flags(gp_axisrv, -1, __.joystick.left.vertical.up);
			};
			
			type	 = "gamepad";	
			deadzone = _config[$ "deadzone"] ?? iceberg.input.__gamepad_deadzone_default;
			joystick = { // flags for joystick "pressed"
				left:  {
					horizontal: {
						left:   {
							pressed:  false,
							down:	  false,
							released: false,
						},
						right:  {
							pressed:  false,
							down:	  false,
							released: false,
						},
					},
					vertical:   {
						up:   {
							pressed:  false,
							down:	  false,
							released: false,
						},
						down: {
							pressed:  false,
							down:	  false,
							released: false,
						},
					},
				}, 
				right: {
					horizontal: {
						left:   {
							pressed:  false,
							down:	  false,
							released: false,
						},
						right:  {
							pressed:  false,
							down:	  false,
							released: false,
						},
					},
					vertical:   {
						up:   {
							pressed:  false,
							down:	  false,
							released: false,
						},
						down: {
							pressed:  false,
							down:	  false,
							released: false,
						},
					},
				},
			};
		};
		
		// events
		on_initialize(function() {
			set_deadzone(__.deadzone);
		});
		on_update	 (function() {
			__update_axis_all();
		});
	};
