
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______  ______   ______   ______  __   __       ______    //
	// /\  == \/\  == \ /\  __ \ /\  ___\/\ \ /\ \     /\  ___\   //
	// \ \  _-/\ \  __< \ \ \/\ \\ \  __\\ \ \\ \ \____\ \  __\   //
	//  \ \_\   \ \_\ \_\\ \_____\\ \_\   \ \_\\ \_____\\ \_____\ //
	//   \/_/    \/_/ /_/ \/_____/ \/_/    \/_/ \/_____/ \/_____/ //
	//                                                            //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function PlayerProfile(_config = {}) : IB_Base(_config) constructor {
		
		static VERSION = "0.1";
		
		// public
		static create			= function(_name, _port) {
			__.name			 =  _name;
			__.path			 = __generate_path(_name, _port);
			__.input.port	 =  _port;
			__.input.profile = __new_input_profile(_name, _port);
			save_to_disk();
			return self;
		};
		static rename			= function(_name) {
			delete_from_disk(false);
			__.name =  _name;
			__.path = __generate_path(_name);
			save_to_disk();
			__.input.profile.rename(_name);
			return self;
		};
		static save_to_disk		= function() {
			iceberg.file.save_to_disk({
				version: VERSION,
				color: __.color,
			}, 
			__.path);
			__.input.profile.save_to_disk();
			return self;
		};	
		static load_from_disk	= function(_name, _port) {
			
			__.name	= _name;
			__.path	= __generate_path(_name);
			
			// parse data
			var _data =  iceberg.file.load_from_disk(__.path);
			
			// check if version needs to be updated
			var _version  = _data[$ "version"];
			if (_version !=  VERSION) {
				create(_name, _port);
				load_from_disk();
				exit;
			}
			
			// load remaining data
			__.input.port	 = _port;
			__.input.profile = __new_input_profile(_name, _port);
			__.color		 = _data.color;
			
			__.input.profile.load_from_disk();
			
			return self;
		};
		static delete_from_disk	= function(_wipe_data = true) {
			iceberg.file.delete_from_disk(__.path);
			__.input.profile.delete_from_disk();
			if (_wipe_data) wipe_data();
			return self;
		};
		static wipe_data		= function() {
			__.name		  = "";
			__.path		  = "";
			__.input.port = undefined;
			__delete_input_profile();
			return self;
		};
		
		static get_name			= function() {
			return __.name;
		};
		static get_path			= function() {
			return __.path;
		};
		static color_get		= function() { // rename to get_color()
			return __.color;	
		};
			
		// private
		with (__) {
			static __generate_path		  = function(_name = get_name()) {
				__.path = 
					  GAME_DATA.save.player.profiles.path.prefix 
					+ _name 
					+ GAME_DATA.save.player.profiles.path.filetype;
					
				return __.path;
			};
			static __new_input_profile	  = function(_name, _port) {
				__.input.profile = iceberg.input.profile_new(_name, _port);
				return __.input.profile;
			};
			static __delete_input_profile = function() {
				if (__.input.profile != undefined) {
					__.input.profile.cleanup();
				}
				__.input.profile = undefined;
			};
			
			name  = "";
			path  = "";
			color = _config[$ "color"] ?? c_white;
			input = {
				port:	 undefined,
				profile: undefined,
			};
		};
		
		// events
		on_cleanup(function() {
			wipe_data();
		});
	};
	