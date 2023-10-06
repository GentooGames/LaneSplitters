
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ // 
	//  ______  __       ______   __  __   ______   ______    //
	// /\  == \/\ \     /\  __ \ /\ \_\ \ /\  ___\ /\  == \   //
	// \ \  _-/\ \ \____\ \  __ \\ \____ \\ \  __\ \ \  __<   //
	//  \ \_\   \ \_____\\ \_\ \_\\/\_____\\ \_____\\ \_\ \_\ //
	//   \/_/    \/_____/ \/_/\/_/ \/_____/ \/_____/ \/_/ /_/ //
	//                                                        //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ // 
	// objc_player.create //
	event_inherited();
	var _self = self;
	
	// [IB_DOC.player]
	// a player is a non-tangible, abstract entity, that represents
	// the user that is playing the game. a player does not have a 
	// sprite, or visual representation; instead, a player creates
	// x number of characters that it is responsible for controlling.
	// players have an associated input port, to hook into the input
	// system, and a player is automatically created and stored 
	// whenever a new input port is activated.
	
	#region input
	
		input_left_pressed		= function(_takes_input = true) {
			return _takes_input && iceberg.input.check_pressed(input_get_port__index(), "left");
		};
		input_left_down			= function(_takes_input = true) {
			return _takes_input && iceberg.input.check_down(input_get_port_index(), "left");
		};
		input_left_released		= function(_takes_input = true) {
			return _takes_input && iceberg.input.check_released(input_get_port_index(), "left");
		};
		input_right_pressed		= function(_takes_input = true) {
			return _takes_input && iceberg.input.check_pressed(input_get_port_index(), "right");
		};
		input_right_down		= function(_takes_input = true) {
			return _takes_input && iceberg.input.check_down(input_get_port_index(), "right");
		};
		input_right_released	= function(_takes_input = true) {
			return _takes_input && iceberg.input.check_released(input_get_port_index(), "right");
		};
		input_up_pressed		= function(_takes_input = true) {
			return _takes_input && iceberg.input.check_pressed(input_get_port_index(), "up");
		};
		input_up_down			= function(_takes_input = true) {
			return _takes_input && iceberg.input.check_down(input_get_port_index(), "up");
		};
		input_up_released		= function(_takes_input = true) {
			return _takes_input && iceberg.input.check_released(input_get_port_index(), "up");
		};
		input_down_pressed		= function(_takes_input = true) {
			return _takes_input && iceberg.input.check_pressed(input_get_port_index(), "down");
		};
		input_down_down			= function(_takes_input = true) {
			return _takes_input && iceberg.input.check_down(input_get_port_index(), "down");
		};
		input_down_released		= function(_takes_input = true) {
			return _takes_input && iceberg.input.check_released(input_get_port_index(), "down");
		};
		input_select_pressed	= function(_takes_input = true) {
			return _takes_input && iceberg.input.check_pressed(input_get_port_index(), "select");
		};
		input_select_down		= function(_takes_input = true) {
			return _takes_input && iceberg.input.check_down(input_get_port_index(), "select");
		};
		input_select_released	= function(_takes_input = true) {
			return _takes_input && iceberg.input.check_released(input_get_port_index(), "select");
		};
		input_back_pressed		= function(_takes_input = true) {
			return _takes_input && iceberg.input.check_pressed(input_get_port_index(), "back");
		};
		input_back_down			= function(_takes_input = true) {
			return _takes_input && iceberg.input.check_down(input_get_port_index(), "back");
		};
		input_back_released		= function(_takes_input = true) {
			return _takes_input && iceberg.input.check_released(input_get_port_index(), "back");
		};
		input_start_pressed		= function(_takes_input = true) {
			return _takes_input && iceberg.input.check_pressed(input_get_port_index(), "start");
		};
		input_start_down		= function(_takes_input = true) {
			return _takes_input && iceberg.input.check_down(input_get_port_index(), "start");
		};
		input_start_released	= function(_takes_input = true) {
			return _takes_input && iceberg.input.check_released(input_get_port_index(), "start");
		};
		input_options_pressed	= function(_takes_input = true) {
			return _takes_input && iceberg.input.check_pressed(input_get_port_index(), "options");
		};
		input_options_down		= function(_takes_input = true) {
			return _takes_input && iceberg.input.check_down(input_get_port_index(), "options");
		};
		input_options_released	= function(_takes_input = true) {
			return _takes_input && iceberg.input.check_released(input_get_port_index(), "options");
		};
		input_pause_pressed		= function(_takes_input = true) {
			return _takes_input && iceberg.input.check_pressed(input_get_port_index(), "pause");
		};
		input_pause_down		= function(_takes_input = true) {
			return _takes_input && iceberg.input.check_down(input_get_port_index(), "pause");
		};
		input_pause_released	= function(_takes_input = true) {
			return _takes_input && iceberg.input.check_released(input_get_port_index(), "pause");
		};
		input_next_pressed		= function(_takes_input = true) {
			return _takes_input && iceberg.input.check_pressed(input_get_port_index(), "next");
		};
		input_next_down			= function(_takes_input = true) {
			return _takes_input && iceberg.input.check_down(input_get_port_index(), "next");
		};
		input_next_released		= function(_takes_input = true) {
			return _takes_input && iceberg.input.check_released(input_get_port_index(), "next");
		};
		input_previous_pressed	= function(_takes_input = true) {
			return _takes_input && iceberg.input.check_pressed(input_get_port_index(), "previous");
		};
		input_previous_down		= function(_takes_input = true) {
			return _takes_input && iceberg.input.check_down(input_get_port_index(), "previous");
		};
		input_previous_released	= function(_takes_input = true) {
			return _takes_input && iceberg.input.check_released(input_get_port_index(), "previous");
		};
		
		input_gas_pressed		  = function(_takes_input = true) {
			return _takes_input && iceberg.input.check_pressed(input_get_port_index(), "gas");
		};
		input_gas_down			  = function(_takes_input = true) {
			return _takes_input && iceberg.input.check_down(input_get_port_index(), "gas");
		};
		input_gas_released		  = function(_takes_input = true) {
			return _takes_input && iceberg.input.check_released(input_get_port_index(), "gas");
		};
		input_hand_brake_pressed  = function(_takes_input = true) {
			return _takes_input && iceberg.input.check_pressed(input_get_port_index(), "hand_brake");
		};
		input_hand_brake_down	  = function(_takes_input = true) {
			return _takes_input && iceberg.input.check_down(input_get_port_index(), "hand_brake");
		};
		input_hand_brake_released = function(_takes_input = true) {
			return _takes_input && iceberg.input.check_released(input_get_port_index(), "hand_brake");
		};
			
	#endregion
	#region profile
	
		// public
		profile_create = function(_profile_name) {
			var _profile	= profile_get();
			var _port_index = input_get_port_index();
			_profile.create(_profile_name, _port_index);
			team_reset();
			__.log("profile created: " + _profile_name, IB_LOG_FLAG.PLAYER);
			return self;
		};
		profile_get    = function() {
			return __.profile;	
		};
		profile_load   = function(_profile_name) {
			var _profile = profile_get();
			_profile.load_from_disk(_profile_name);
			team_reset();
			__.log("profile loaded: " + _profile_name, IB_LOG_FLAG.PLAYER);
			return self;
		};
			
		// private
		with (__) {
			profile = new PlayerProfile({
				color: GAME_DATA.player.colors[_self.input_get_port_index()],
			});	
		};
	
	#endregion
	#region stats
	
		// public
		with (__) {
			stats = new PlayerStats();	
		};
		
		// private
		on_cleanup(function() {
			__.stats.cleanup();
		});
	
	#endregion
	#region car
		
		// public
		car_create = function(_x = 0, _y = 0, _config = {}) {
		
			// enforced params
			_config[$ "player"] ??= self;
		
			var _char = instance_create_depth(_x, _y, 0, obj_car, _config);
			__.car = _char;
			__.car.initialize();
			__.log("car created", IB_LOG_FLAG.PLAYER);
			
			return _char;
		};
		car_assign = function(_character) {
			__.car = _character;
			__.car.player_set(self);
			__.car.initialize();
			return _character;
		};
		car_get	   = function() {
			return __.car;
		};	
		
		// private
		with (__) {
			car = undefined;
		};
		
	#endregion
	
	