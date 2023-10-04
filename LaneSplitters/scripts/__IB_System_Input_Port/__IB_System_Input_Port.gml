
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______  ______   ______  ______  //
	// /\  == \/\  __ \ /\  == \/\__  _\ //
	// \ \  _-/\ \ \/\ \\ \  __<\/_/\ \/ //
	//  \ \_\   \ \_____\\ \_\ \_\ \ \_\ //
	//   \/_/    \/_____/ \/_/ /_/  \/_/ //
	//                                   //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function __IB_System_Input_Port(_config = {}) : IB_Base(_config) constructor {
	
		var _self = self;
		
		// = PUBLIC ================
		static check_pressed	   = function(_verb) {
			if (is_active()) {
				return __input_devices_check_pressed(_verb);
			}
			return false;
		};
		static check_down		   = function(_verb) {
			if (is_active()) {
				return __input_devices_check_down(_verb);
			}
			return false;
		};
		static check_released	   = function(_verb) {
			if (is_active()) {
				return __input_devices_check_released(_verb);
			}
			return false;
		};
		static clear_input_devices = function() {
			__.input_devices = array_create(0);
			return self;
		};
		static get_input_devices   = function() {
			return __.input_devices;	
		};
		static profile_get		   = function() {
			return __.profile;	
		};
		static set_input_devices   = function(_input_devices) {
			__.input_devices = _input_devices;
			return self;
		};
		static set_profile		   = function(_profile) {
			__.profile = _profile;
			return self;
		};
		
		// = PRIVATE ===============
		with (__) {
			static __activate_base				  = activate;
			static __input_devices_check_pressed  = function(_verb) {
				if (__.input_devices != undefined) {
					for (var _i = 0, _len = array_length(__.input_devices); _i < _len; _i++) {
						var _device  = __.input_devices[_i];
						if (__.profile != undefined) {
							if (_device.check_pressed(_verb, __.profile.get_keybindings())) {
								return true;	
							}
						}
						else {
							if (_device.check_pressed(_verb)) {
								return true;	
							}
						}
					};
				}
				return false;
			};
			static __input_devices_check_down	  = function(_verb) {
				if (__.input_devices != undefined) {
					for (var _i = 0, _len = array_length(__.input_devices); _i < _len; _i++) {
						var _device  = __.input_devices[_i];
						if (__.profile != undefined) {
							if (_device.check_down(_verb, __.profile.get_keybindings())) {
								return true;	
							}
						}
						else {
							if (_device.check_down(_verb)) {
								return true;	
							}
						}
					};
				}
				return false;
			};
			static __input_devices_check_released = function(_verb) {
				if (__.input_devices != undefined) {
					for (var _i = 0, _len = array_length(__.input_devices); _i < _len; _i++) {
						var _device  = __.input_devices[_i];
						if (__.profile != undefined) {
							if (_device.check_released(_verb, __.profile.get_keybindings())) {
								return true;	
							}
						}
						else {
							if (_device.check_released(_verb)) {
								return true;	
							}
						}
					};
				}
				return false;
			};
			
			input_devices = _config[$ "input_devices"] ?? undefined;
			port_index	  = _config[$ "port_index"   ] ?? iceberg.input.this.__ports.get_size();
			profile		  = _config[$ "profile"      ] ?? undefined;
		};
		
		// = EVENTS ================
		on_deactivate(function() {
			__.input_devices = undefined;
			__.profile		 = undefined;
		});
	};

	