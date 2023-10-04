
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______  ______   ______   ______  __   __       ______    //
	// /\  == \/\  == \ /\  __ \ /\  ___\/\ \ /\ \     /\  ___\   //
	// \ \  _-/\ \  __< \ \ \/\ \\ \  __\\ \ \\ \ \____\ \  __\   //
	//  \ \_\   \ \_\ \_\\ \_____\\ \_\   \ \_\\ \_____\\ \_____\ //
	//   \/_/    \/_/ /_/ \/_____/ \/_/    \/_/ \/_____/ \/_____/ //
	//                                                            //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function __IB_System_Input_Profile(_config = {}) : IB_Base(_config) constructor {
	
		var _self = self;
	
		// = PUBLIC ================
		static delete_from_disk = function() {
			iceberg.file.delete_from_disk(__get_save_path());
			return self;
		};
		static get_deadzone		= function() {
			return __.gamepad_deadzone;	
		};
		static get_keybindings	= function() {
			return __.keybindings;	
		};
		static load_from_disk	= function(_name = get_name()) {
			
			var _path = __get_save_path(_name);
			var _data = iceberg.file.load_from_disk(_path);
			
			__.cursor_accel		= _data.cursor.accel;
			__.cursor_fric		= _data.cursor.fric;
			__.cursor_sense		= _data.cursor.sense;
			__.gamepad_deadzone = _data.gamepad.deadzone;
			
			return self;
		};
		static rename			= function(_name) {
			delete_from_disk();
			set_name(_name);	
			save_to_disk();
			return self;
		};
		static set_deadzone		= function(_deadzone) {
			__.gamepad_deadzone = _deadzone;
			return self;
		};
		static set_keybindings	= function(_keybindings_struct) {
			__.keybindings.set_keybindings(_keybindings_struct);
			return self;
		};
		static save_to_disk		= function() {
			iceberg.file.save_to_disk({
				cursor:  {
					accel: __.cursor_accel,
					fric:  __.cursor_fric,
					sense: __.cursor_sense,
				},
				gamepad: {
					deadzone: __.gamepad_deadzone,
				},
			}, 
			__get_save_path(get_name()));
			return self;
		};
		
		// = PRIVATE ===============
		with (__) {
			static __get_save_path = function(_name = get_name()) {
				return iceberg.input.__save_path + "profiles/" 
					 + _name
					 + iceberg.input.__save_file_type;
			};
			
			cursor_accel	 = _config[$ "cursor_accel"	   ] ?? iceberg.input.__cursor_accel_default;
			cursor_fric		 = _config[$ "cursor_fric"	   ] ?? iceberg.input.__cursor_fric_default;
			cursor_sense	 = _config[$ "cursor_sense"	   ] ?? iceberg.input.__cursor_sense_default;
			gamepad_deadzone = _config[$ "gamepad_deadzone"] ?? iceberg.input.__gamepad_deadzone_default;
			port_index		 = _config[$ "port_index"	   ] ?? undefined;
			keybindings		 =  new __IB_System_Input_Keybindings({
				keybindings: iceberg.input.__keybindings
			});
		};
			
		// = EVENTS ================
		on_initialize(function() {
			__.keybindings.initialize();
		});
		on_cleanup   (function() {
			__.keybindings.cleanup();
		});
	};

