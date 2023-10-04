
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______  __   __    __   ______    //
	// /\__  _\/\ \ /\ "-./  \ /\  ___\   //
	// \/_/\ \/\ \ \\ \ \-./\ \\ \  __\   //
	//    \ \_\ \ \_\\ \_\ \ \_\\ \_____\ //
	//     \/_/  \/_/ \/_/  \/_/ \/_____/ //
	//                                    //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	global._IB_Time_Sources = array_create(0);

	function IB_TimeSource(_config = {}) : IB_Base(_config) constructor {
	
		var _self = self;
	
		// = PUBLIC ====================
		static advance_to			 = function(_period, _start = true) {
			__.period_advanced =  get_period();
			__.period		   = _period;
			reconfigure(,_start);
			return self;
		};
		static execute_callback		 = function() {
			return __.callback();	
		};
		static pause				 = function() {
			time_source_pause(__.source);
			return self;
		};
		static reconfigure			 = function(_data = {}, _start = false) {
			// if parent changed, then we cannot simply reconfigure, 
			// we must destroy and re-create the time source. 
			if (_data[$ "parent"] == get_parent()) {
			
				if (_data[$ "period"	 ] != undefined) __.period		= _data[$ "period"	   ];
				if (_data[$ "units"		 ] != undefined) __.units		= _data[$ "units"	   ];
				if (_data[$ "callback"	 ] != undefined) __.callback	= _data[$ "callback"   ];
				if (_data[$ "args"		 ] != undefined) __.args		= _data[$ "args"	   ];
				if (_data[$ "repetitions"] != undefined) __.repetitions = _data[$ "repetitions"];
				if (_data[$ "expiry_type"] != undefined) __.expiry_type = _data[$ "expiry_type"];
			
				time_source_reconfigure(
					__.source,
					get_period(),
					get_units(),
					function() {
						__execute_callback();
						__reset_period_advanced();
					},
					get_args(),
					get_repetitions(),
					get_expiry_type(),
				);
			}
			else __create_time_source(_data);	
			if (_start) start();
			return self;
		};
		static reset				 = function(_start = false) {
			time_source_reset(__.source);
			if (_start) start();	
			return self;
		};
		static resume				 = function() {
			time_source_resume(__.source);
			return self;
		};
		static start				 = function() {
			time_source_start(__.source);
			return self;
		};
		static stop					 = function() {
			time_source_stop(__.source);
			return self;
		};
			
		static get_args				 = function() {
			return __.args;
		};
		static get_callback			 = function() {
			return __.callback;
		};
		static get_children			 = function() {
			return time_source_get_children(__.source);
		};
		static get_expiry_type		 = function() {
			return __.expiry_type;
		};
		static get_parent			 = function() {
			return __.parent;
		};
		static get_percent_completed = function() {
			if (is_active()) {
				return get_time_remaining() / get_period();	
			}
			return 0;	
		};
		static get_period			 = function() {
			return __.period;
		};
		static get_repetitions		 = function() {
			return __.repetitions;
		};
		static get_reps_completed	 = function() {
			return time_source_get_reps_completed(__.source);
		};
		static get_reps_remaining	 = function() {
			return time_source_get_reps_remaining(__.source);
		};
		static get_source			 = function() {
			return __.source;
		};
		static get_state			 = function() {
			return time_source_get_state(__.source);
		};
		static get_time_remaining	 = function() {
			return time_source_get_time_remaining(__.source);
		};
		static get_units			 = function() {
			return __.units;
		};
			
		static is_complete			 = function() {
			return get_reps_remaining() == 0;	
		};
		static is_paused			 = function() {
			return get_state() == time_source_state_paused;	
		};
		static is_running			 = function() {
			return get_state() == time_source_state_active;	
		};
		static is_stopped			 = function() {
			return get_state() == time_source_state_stopped;	
		};
		static is_uninitialized		 = function() {
			return get_state() == time_source_state_initial;	
		};
		
		static set_args				 = function(_args, _start = false) {
			__.args = _args;
			reconfigure(,_start);
			return self;
		};
		static set_callback			 = function(_callback, _start = false) {
			__.callback = _callback;
			reconfigure(,_start);
			return self;
		};
		static set_destroy_tree		 = function(_destroy_tree) {
			__.destroy_tree = _destroy_tree;
			return self;
		};
		static set_expiry_type		 = function(_expiry_type, _start = false) {
			__.expiry_type = _expiry_type;
			reconfigure(,_start);
			return self;
		};
		static set_parent			 = function(_parent, _start = false) {
			__.parent = _parent;
			reconfigure(,_start);
			return self;
		};
		static set_period			 = function(_period, _start = false) {
			if (__.period != _period) {
				__.period  = _period;
				reconfigure(,_start);
			}
			else if (_start) {
				start();
			}
			return self;
		};
		static set_repetitions		 = function(_repetitions, _start = false) {
			__.repetitions = _repetitions;
			reconfigure(,_start);
			return self;
		};
		static set_units			 = function(_units, _start = false) {
			__.units = _units;
			reconfigure(,_start);
			return self;
		};
		
		// = PRIVATE ===================
		with (__) {
		
			static __create_time_source	   = function(_data = {}) {

				if (_data[$ "parent"	 ] != undefined) __.parent		= _data[$ "parent"	   ];
				if (_data[$ "period"	 ] != undefined) __.period		= _data[$ "period"	   ];
				if (_data[$ "units"		 ] != undefined) __.units		= _data[$ "units"	   ];
				if (_data[$ "callback"	 ] != undefined) __.callback	= _data[$ "callback"   ];
				if (_data[$ "args"		 ] != undefined) __.args		= _data[$ "args"	   ];
				if (_data[$ "repetitions"] != undefined) __.repetitions = _data[$ "repetitions"];
				if (_data[$ "expiry_type"] != undefined) __.expiry_type = _data[$ "expiry_type"];
			
				var _new_source = time_source_create(
					get_parent(), 
					get_period(), 
					get_units(),
					function() {
						__execute_callback();
						__reset_period_advanced();
					},
					get_args(), 
					get_repetitions(), 
					get_expiry_type()
				);
			
				if (__.source != undefined) {
					__redistribute_children(,_new_source);
				}
				__.source = _new_source;
				return __.source;
			};
			static __execute_callback	   = function() {
				var _callback  = get_callback();
				if (_callback != undefined) {
					_callback();	
				}
			};
			static __redistribute_children = function(_old_source = __.source, _new_source) {
			
				var _children = time_source_get_children(_old_source);
				if (!is_array(_children)) _children = [ _children ];
			
				for (var _i = 0, _len_i = array_length(_children); _i < _len_i; _i++) {
					var _child = _children[_i];
				
					for (var _j = 0, _len_j = array_length(global._IB_Time_Sources); _j < _len_j; _j++) {
						var _ibTimeSource = global._IB_Time_Sources[_j];
						if (_ibTimeSource.get_source() == _child) {
							_ibTimeSource.set_parent(_new_source);
							 break;
						}
					};
				};
			};
			static __reset_period_advanced = function() {
				if (__.period_advanced != undefined) {
					set_period(__.period_advanced);	
				}
			};
		
			source			=  undefined;
			args			= _config[$ "args"		  ] ?? array_create(0);
			callback		= _config[$ "callback"	  ] ?? function() {};
			destroy_tree	= _config[$ "destroy_tree"] ?? false;
			expiry_type		= _config[$ "expiry_type" ] ?? time_source_expire_after;
			parent			= _config[$ "parent"	  ] ?? time_source_global;
			period			= _config[$ "period"	  ] ?? 0;
			repetitions		= _config[$ "repetitions" ] ?? 1;
			units			= _config[$ "units"		  ] ?? time_source_units_frames;
			period_advanced =  undefined;
		};
			
		// = EVENTS ====================
		on_initialize(function() {
			__create_time_source();
			array_push(global._IB_Time_Sources, self);	
		});
		on_cleanup   (function() {
			time_source_destroy(__.source, __.destroy_tree);	
			iceberg.array.find_delete(global._IB_Time_Sources, self);
		});
	};
	
	