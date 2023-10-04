
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  _____    ______   __   __ __   ______   ______    //
	// /\  __-. /\  ___\ /\ \ / //\ \ /\  ___\ /\  ___\   //
	// \ \ \/\ \\ \  __\ \ \ \'/ \ \ \\ \ \____\ \  __\   //
	//  \ \____- \ \_____\\ \__|  \ \_\\ \_____\\ \_____\ //
	//   \/____/  \/_____/ \/_/    \/_/ \/_____/ \/_____/ //
	//                                                    //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function __IB_System_Input_Device(_config = {}) : IB_Base(_config) constructor {
	
		var _self = self;
	
		// = PUBLIC ================
		static check_pressed	= function(_verb, _keybindings = __.keybindings) {
			if (is_active()) {
				return _keybindings.check_pressed(_verb, __.device_index, __.type);	
			}
			return false;
		};
		static check_down		= function(_verb, _keybindings = __.keybindings) {
			if (is_active()) {
				return _keybindings.check_down(_verb, __.device_index, __.type);	
			}
			return false;
		};
		static check_released	= function(_verb, _keybindings = __.keybindings) {
			if (is_active()) {
				return _keybindings.check_released(_verb, __.device_index, __.type);	
			}
			return false;
		};
		static get_description	= function() {
			return get_name();	
		};
		static get_device_index = function() {
			return __.device_index;	
		};
		static get_type			= function() {
			return __.type;	
		};
		
		// = PRIVATE ===============
		with (__) {
			description  = _config[$ "description" ] ?? "";
			device_index = _config[$ "device_index"] ?? undefined;
			guid		 = _config[$ "guid"		   ] ?? "";
			type		 = _config[$ "type"		   ] ?? undefined;
			keybindings  =  new __IB_System_Input_Keybindings({
				device:		_self,
				keybindings: iceberg.input.__keybindings,
			});
		};
		
		// = EVENTS ================
		on_initialize(function() {
			__.keybindings.__[$ "device"] = self;
			__.keybindings.initialize();
		});
		on_cleanup   (function() {
			__.keybindings.cleanup();
		});
	};
	