
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ // 
	//  __   ______   ______   ______   ______   ______   ______    // 
	// /\ \ /\  ___\ /\  ___\ /\  == \ /\  ___\ /\  == \ /\  ___\   // 
	// \ \ \\ \ \____\ \  __\ \ \  __< \ \  __\ \ \  __< \ \ \__ \  // 
	//  \ \_\\ \_____\\ \_____\\ \_____\\ \_____\\ \_\ \_\\ \_____\ // 
	//   \/_/ \/_____/ \/_____/ \/_____/ \/_____/ \/_/ /_/ \/_____/ // 
	//																//
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	// obj_iceberg.create //     ~	
	event_user(15);		  //    (º\>	
	var _self = self;	  //    /, ).
	
	__ = {};
	
	#region logging
	
		// public
		log = function(_message, _flags = undefined) {
			
			var _prefix = string(current_time) + ") ";
			var _suffix = "";
			
			if (IB_LOG_LEVEL == IB_LOG_FLAG.NONE) exit;
			
			if (IB_LOG_LEVEL == IB_LOG_FLAG.ALL 
			||	_flags == undefined 
			|| (_flags & IB_LOG_LEVEL) != 0
			) {
				show_debug_message(_prefix + _message + _suffix);		
			}
			
			return self;
		};
	
	#endregion
	#region utilities
	
		// private
		__[$ "util"] ??= {};
		with (__.util) {
			array	   = new _IB_Utility_Array();
			asset_tree = new _IB_Utility_AssetTree();
			buffer	   = new _IB_Utility_Buffer();
			collision  = new _IB_Utility_Collision();
			draw	   = new _IB_Utility_Draw();
			ease	   = new _IB_Utility_Ease();
			gui		   = new _IB_Utility_Gui();
			instance   = new _IB_Utility_Instance();
			isometric  = new _IB_Utility_Isometric();
			list	   = new _IB_Utility_List();
			math	   = new _IB_Utility_Math();
	self[$ "method"]   = new _IB_Utility_Method();
			object	   = new _IB_Utility_Object();
			path	   = new _IB_Utility_Path();
			physics	   = new _IB_Utility_Physics();
			sprite	   = new _IB_Utility_Sprite();
			struct	   = new _IB_Utility_Struct();
			surface	   = new _IB_Utility_Surface();
			time	   = new _IB_Utility_Time();
			text	   = new _IB_Utility_Text();
			tween	   = new _IB_Utility_Tween();
			unit_test  = new _IB_Utility_UnitTest();
			vector	   = new _IB_Utility_Vector();
		}
			
		util = __.util;
		
		array		= util.array;
		asset_tree	= util.asset_tree;
		buffer		= util.buffer;
		collision	= util.collision;
		draw		= util.draw;
		ease		= util.ease;
		gui			= util.gui;
		instance	= util.instance;
		isometric	= util.isometric;
		list		= util.list;
		math		= util.math;
self[$ "method"]	= util.method;
		object		= util.object;
		path		= util.path;
		physics		= util.physics;
		sprite		= util.sprite;
		struct		= util.struct;
		surface		= util.surface;
		time		= util.time;
		text		= util.text;
		tween		= util.tween;
		unit_test	= util.unit_test;
		vector		= util.vector;
		
	#endregion
	#region radio
		
		// public
		subscribe	= function(_event_name, _callback, _weak_ref = true) {
			return __.radio.subscribe(_event_name, _callback, _weak_ref);	
		};
		unsubscribe = function(_subscriber, _force = true) {
			__.radio.unsubscribe(_subscriber, _force);
			return self;
		};
			
		// private
		__[$ "radio"] ??= new IB_Radio();
		__[$ "radio"].register(
			"systems_initializing",
			"systems_initialized",
			"systems_starting",
			"systems_ready",
			"controller_created",
		);
	
	#endregion
	#region clock
	
		// public
		clock_create		= function(_tick_rate = __.clock.tick_rate) {
			var _clock = new iota_clock();
			_clock.set_update_frequency(_tick_rate);
			array_push(__.clock.clocks, _clock);
			return _clock;
		};
		clock_destroy		= function(_clock) {
			iceberg.array.find_delete(__.clock.clocks, _clock);
			return self;
		};
		clock_get_tick_rate = function(_clock = undefined) {
			if (_clock != undefined) {
				return _clock.get_update_frequency();	
			}
			return __.clock.tick_rate;
		};
		
		// private
		__[$ "clock"] ??= {};
		with (__.clock) {
			tick_rate = 60;
			clocks	  = array_create(0);
			main	  = _self.clock_create();
			ticker	  = new IB_TimeSource({
				parent:		  time_source_global,
				period:		  1,
				repetitions: -1,
				callback:	  method(_self, function() {
					iceberg.array.for_each(__.clock.clocks, function(_clock) {
						_clock.tick();
					});
				}),
			});
		};
		
	#endregion
	#region systems
		
		// private
		__[$ "system"] ??= {};
		with (__.system) {
			input = new _IB_System_Input({
				owner: _self,
			});
			frame = 0;
		};
		
		system = __.system;
		input  = __.system.input;
		
	#endregion
	#region state
		
		// private
		__[$ "state"] ??= {};
		with (__.state) {
			fsm = new SnowState("__", false, {
				owner: _self,
			});
			fsm.add("__", _self.state_base());
			fsm.add_child("__", "initialize_systems", _self.state_systems_initialize());
			fsm.add_child("__", "start_systems",	  _self.state_systems_start());
			fsm.add_child("__", "running",			  _self.state_running());
		};
		
	#endregion
	#region controllers
	
		// public
		controller_create = function(_object_index, _depth = 0, _config = {}, _initialize = true) {
			var _controller = instance_create_depth(0, 0, _depth, _object_index, _config);	
			if (_initialize) {
				if (_controller[$ "initialize"] != undefined) {
					_controller.initialize();
				}
			}
			__.radio.broadcast("controller_created", _controller);
			return _controller;
		};
	
	#endregion
	
	////////////////////
	
	active = false;
	event_inherited();
	
	////////////////////
	
	// events
	on_initialize(function() {
		__.radio.initialize();
		__.clock.ticker.initialize();
		__.clock.ticker.start();
		if (__.state.fsm.state_is("__")) {
			__.state.fsm.change("initialize_systems");
		}
	});
	
	__.clock.main.add_cycle_method(function() {
		if (is_initialized() && is_active()) {
			__.state.fsm.step();
		}
	});
	__.clock.main.add_begin_method(function() {
		__.system.frame++;
		if (is_initialized() && is_active()) {
			__.state.fsm.begin_step();
		}
	});
	__.clock.main.add_end_method  (function() {
		if (is_initialized() && is_active()) {
			__.state.fsm.end_step();
		}
	});
	
	