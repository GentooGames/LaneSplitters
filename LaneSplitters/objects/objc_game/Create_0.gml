
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   ______   __    __   ______    //
	// /\  ___\ /\  __ \ /\ "-./  \ /\  ___\   //
	// \ \ \__ \\ \  __ \\ \ \-./\ \\ \  __\   //
	//  \ \_____\\ \_\ \_\\ \_\ \ \_\\ \_____\ //
	//   \/_____/ \/_/\/_/ \/_/  \/_/ \/_____/ //
	//                                         //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	// objc_game.create //
	event_inherited();
	var _self = self;
	var _data = self[$ "data"] ?? self;
	
	#region seed ..........|
	
		// events
		on_initialize(function() {
			randomize();
		});
	
	#endregion
	#region input .........|
	
		// private 
		__[$ "input"] ??= {};
		with (__.input) {
			auto_assign_gamepad_event	 = method(_self, function(_data) {
				var _device_data	= _data.payload;
				var _device_index	= _device_data.index;
				var _gamepad_device =  iceberg.input.device_get_gamepad(_device_index);
				for (var _i = 0; _i <  iceberg.input.__port_count; _i++) {
					var  _player = player_get(_i);
					if (!_player.input_has_gamepad()) {
						_player.input_add_device(_gamepad_device);
						iceberg.input.port_set_devices(_i, _player.input_get_devices());
						break;
					}
				};
			});
			auto_assign_gamepad_listener = undefined;
		};
		
		// events
		on_initialize(function() {
			
			__.input.auto_assign_gamepad_listener = iceberg.input.subscribe("gamepad_device_created", __.input.auto_assign_gamepad_event);
			
			// whenever an input port is activated, a player controller 
			// object is automatically created and assigned to that port 
			// index. by default, the IB_System_Input system activates 
			// port 0 on start, and assigns the keyboard and mouse as 
			// starting input_devices. this means that a port and/or player 
			// does not need to be manually created, as it is done so for 
			// us by the input system. if we wish to have more input ports 
			// and/or players in the game, then this can be done simply 
			// by invoking iceberg.input.port_activate(<port_index>);
			//
			// iceberg.input.port_activate(0); <-- automatically handled
			for (var _i = 1; _i < iceberg.input.__port_count; _i++) {
			   iceberg.input.port_activate(_i);
			};
		});
	
	#endregion
	#region players .......|
	
		// events
		on_initialize(function() {
			player_for_each(function(_player) {
				_player.initialize();
			});
		});
	
	#endregion
	#region controllers ...|
	
		// private
		__[$ "controller"] ??= {};
		with (__.controller) {
			radio  = iceberg.controller_create(objc_radio,,,  false);
			camera = iceberg.controller_create(objc_camera,,, false);
			menu   = iceberg.controller_create(objc_menu,,,	  false);
			world  = iceberg.controller_create(objc_world,,,  false);
			time   = iceberg.controller_create(objc_time,,,   false);
			points = iceberg.controller_create(objc_points,,, false);
			veil   = iceberg.controller_create(objc_veil,,,   false);
			bonus  = iceberg.controller_create(objc_bonus_zones,,,false);
		};
		
		// events
		on_initialize(function() {
			__.controller.radio.initialize();
			__.controller.camera.initialize();
			__.controller.menu.initialize();
			__.controller.world.initialize();
			__.controller.time.initialize();
			__.controller.points.initialize();
			__.controller.veil.initialize();
			__.controller.bonus.initialize();
		});
	
	#endregion
	#region font ..........|
		
		// public
		font_reset = function() {
			draw_set_font(fnt_timer);
			return self;
		};
		
		// events
		on_initialize(function() {
			font_reset();
		});
	
	#endregion

	initialize();
	room_goto_next();
	
	
	