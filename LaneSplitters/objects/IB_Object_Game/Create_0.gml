
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   ______   __    __   ______    //
	// /\  ___\ /\  __ \ /\ "-./  \ /\  ___\   //
	// \ \ \__ \\ \  __ \\ \ \-./\ \\ \  __\   //
	//  \ \_____\\ \_\ \_\\ \_\ \ \_\\ \_____\ //
	//   \/_____/ \/_/\/_/ \/_/  \/_/ \/_____/ //
	//                                         //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	// IB_Object_Game.create //
	iceberg_create();
	event_inherited();
	event_user(15);
	
	///////////////////////////
	
	var _self = self;
	
	#region state .............|
	
		// private
		with (__) {
			state = {};
			with (state) {
				fsm = new SnowState("idle", false, {
					owner: _self,	
				})
				fsm.add("__", _self.state_base());
				fsm.add_child("__", "idle");
			};
		};
			
		// events
		on_update	 (function() {
			__.state.fsm.step();
		});
		on_render_gui(function() {
			__.state.fsm.draw_gui();
		});
	
	#endregion
	#region input .............|
		
		// private
		with (__) {
			port_activated_event	  = method(_self, function(_data) {
				var _port_index = _data.payload;
				player_create(_port_index,,false);
				__.log("player_created on port: " + string(_port_index));
			});
			port_deactivated_event	  = method(_self, function(_data) {
				var _port_index = _data.payload;
				player_remove(_port_index);
			});
			port_activated_listener	  = undefined;
			port_deactivated_listener = undefined;
		};
			
		// events
		on_initialize(function() {
			__.port_activated_listener	 = iceberg.input.subscribe("port_activated",   __.port_activated_event	);
			__.port_deactivated_listener = iceberg.input.subscribe("port_deactivated", __.port_deactivated_event);
		
		});	
		on_cleanup   (function() {
			// should call this, but iceberg gets cleaned up 
			// beforehand so this will crash
			// -- iceberg.input.unsubscribe(__.port_activated_listener  );
			// -- iceberg.input.unsubscribe(__.port_deactivated_listener);
			// -- __.port_activated_listener   = undefined;
			// -- __.port_deactivated_listener = undefined;
		});
	
	#endregion
	#region player ............|
	
		// public
		player_create			= function(_port_index, _config = {}, _initialize = true) {
		
			_config[$ "active"			]   =  false;
			_config[$ "input_port_index"] ??= _port_index;
		
			var _player = instance_create_depth(0, 0, 0, PLAYER_OBJECT_INDEX, _config);
			if (_initialize) _player.initialize();
			
			__.players.set(_port_index, _player);
			__.log("player created on port index: " + string(_port_index), IB_LOG_FLAG.GAME);
		
			return _player;
		};
		player_remove			= function(_port_index, _destroy = true) {
			// removing a player will cause issues with how player
			// index assigned. since player_index is just the struct 
			// count, removing player 0 will result in the next 
			// player_create() assigning an id that already exists, 
			// overridding existing player_index.
		
			var _player = __.players.get_items(_port_index);
			__.players.remove(_port_index);
		
			if (_destroy) _player.destroy();
			__.log("player removed from port index: " + string(_port_index), IB_LOG_FLAG.GAME);
		
			return _player;
		};
		player_get				= function(_port_index) {
			return __.players.get(_port_index);
		};
		player_get_active_count = function() {
			var _count = 0;
			for (var _i = 0, _len = player_get_count(); _i < _len; _i++) {
				var _player = player_get(_i);
				if (_player.is_active()) {
					_count++;	
				}
			};
			return _count;
		};
		player_get_count		= function() {
			return __.players.get_size();
		};
		player_for_each			= function(_callback, _data = undefined) {
			__.players.for_each(_callback, _data);	
			return self;
		};
		player_is_active		= function(_port_index) {
			var _player  = player_get(_port_index);
			if (_player != undefined) {
				return _player.is_active();
			}
			return false;
		};
	
		// private
		with (__) {
			players	= new IB_Collection_Struct();
		};
			
		// events
		on_initialize(function() {});
		on_cleanup	 (function() {
			__.players.cleanup();	
		});
	
	#endregion
	#region iceberg ...........|
	
		// events
		on_initialize(function() {
			iceberg_initialize();
			iceberg_activate();
		});
	
	#endregion
	
	