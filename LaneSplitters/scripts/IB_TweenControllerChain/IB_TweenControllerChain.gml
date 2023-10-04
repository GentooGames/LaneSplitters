
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   __  __   ______   __   __   __    //
	// /\  ___\ /\ \_\ \ /\  __ \ /\ \ /\ "-.\ \   //
	// \ \ \____\ \  __ \\ \  __ \\ \ \\ \ \-.  \  //
	//  \ \_____\\ \_\ \_\\ \_\ \_\\ \_\\ \_\\"\_\ //
	//   \/_____/ \/_/\/_/ \/_/\/_/ \/_/ \/_/ \/_/ //
	//											   //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	
	// the curveChainStack is designed to work in tendem with
	// the curveStack class. the idea is that instead of 
	// manually decidnig when the curveStack should move on to 
	// the next curve, a chain (or sequence) of curves could be
	// defined and then passed into the curveChainStack. then,
	// simply, a chain could be defined, and started, and the 
	// defined sequence of curves would execute linearly.
	
	function IB_TweenControllerChain(_config = {}) : IB_Base(_config) constructor {
	
		// = PUBLIC ============
		static on_start				 = function(_callback) {
			array_push(__.on_start, _callback);
			return self;
		};
		static on_stop				 = function(_callback) {
			array_push(__.on_stop, _callback);
			return self;
		};
		static chain_create			 = function(_chain_name, _chain_array, _chain_config = {}) {
			
			// assign config struct params
			_chain_config[$ "name"		 ]	 = _chain_name;
			_chain_config[$ "curve_stack"] ??= __.curve_stack;
			_chain_config[$ "names"		 ]   = _chain_array;
			_chain_config[$ "running"	 ]	 = __.running_on_create;
			
			// create chain instance
			var _chain = new IB_CurveChain(_chain_config).initialize();
			
			// store chain instance in stack
			__.chains.set(_chain_name, _chain);
			
			return _chain;
		};
		static chain_destroy		 = function(_chain_name) {
			
			// get chain from stack
			var _chain  = __.chains.get(_chain_name);
			if (_chain != undefined) {
			
				// remove chain from stack
				__.chains.remove(_chain_name);
			}
			return self;
		};
		static chain_is_running		 = function(_chain_name) {
			var _chain  = __.chains.get(_chain_name);
			if (_chain != undefined) {
				return _chain.is_running();
			}
			return false;
		};
		static chain_on_start		 = function(_chain_name, _callback) {
			var _chain  = __.chains.get(_chain_name);
			if (_chain != undefined) {
				_chain.on_start(_callback);	
			}
			return self;
		};
		static chain_on_stop		 = function(_chain_name, _callback) {
			var _chain  = __.chains.get(_chain_name);
			if (_chain != undefined) {
				_chain.on_stop(_callback);	
			}
			return self;
		};
		static chain_pause			 = function(_chain_name) {
			var _chain  = __.chains.get(_chain_name);
			if (_chain != undefined) {
				_chain.pause();
			}
			return self;
		};
		static chain_start			 = function(_chain_name, _chain_index = 0) {
			var _chain  = __.chains.get(_chain_name);
			if (_chain != undefined) {
				_chain.start(_chain_index);	
				__on_start_callbacks(_chain);
			}
			return self;
		};
		static chain_stop			 = function(_chain_name) {
			var _chain  = __.chains.get(_chain_name);
			if (_chain != undefined) {
				_chain.stop();	
				__on_stop_callbacks(_chain);
			}
			return self;
		};
		static chain_curve_get_value = function(_chain_name) {
			var _chain  = __.chains.get(_chain_name);
			if (_chain != undefined) {
				return _chain.curve_get_value();	
			}
			return undefined;
		};
		
		// = PRIVATE ===========
		with (__) {
			static __on_start_callbacks = function(_chain) {
				iceberg.array.for_each(
					__.on_start_callbacks,
					function(_callback, _chain) {
						_callback(_chain);
					},
					_chain,
				);
			};
			static __on_stop_callbacks	= function(_chain) {
				iceberg.array.for_each(
					__.on_stop_callbacks,
					function(_callback, _chain) {
						_callback(_chain);
					},
					_chain,
				);
			};
			
			running_on_create  = _config[$ "running_on_create"] ?? false;
			curve_stack		   = _config[$ "curve_stack"	  ] ?? undefined;
			chains			   = new IB_Collection_Struct();
			on_start_callbacks = array_create(0);
			on_stop_callbacks  = array_create(0);
		};
		
		// = EVENTS ============
		on_update (function() {
			__.chains.for_each(function(_chain) {
				_chain.update();
			});
		});
		on_cleanup(function() {
			__.chains.for_each(function(_chain) {
				_chain.cleanup();
			});
			__.chains.cleanup();
		});
	};
	
	////////////////////////////////////////////////////////////////////////////
	
	function IB_CurveChain(_config = {}) : IB_Base(_config) constructor {
	
		// = PUBLIC ============
		static start		   = function(_index = 0, _execute_callbacks = true) {
			__.running		= true;
			__.index		= _index;
			__.name_current = __.names[__.index];
			__.curve_stack.curve_start(__.name_current);
			if (_execute_callbacks) __on_start_callbacks();	
			return self;
		};
		static stop			   = function(_execute_callbacks = true) {
			__.curve_stack.curve_stop(__.name_current);
			__.running		= false;
			__.index		= 0;
			__.name_current = "";
			if (_execute_callbacks) __on_stop_callbacks();	
			return self;
		};
		static pause		   = function() {
			__.running = false;
			__.curve_stack.curve_pause(__.name_current);
			return self;
		};
		static next			   = function(_stop_current = true, _execute_callbacks = true) {
			
			if (_stop_current) __.curve_stack.curve_stop(__.name_current);
			
			var _index = __.index + 1;
			if (_index < array_length(__.names)) {
				start(_index);
			}
			else stop();
			
			if (_execute_callbacks) __on_next_callbacks();
			
			return self;
		};
		static is_running	   = function() {
			return __.running;
		};
		static on_start		   = function(_callback) {
			array_push(__.on_start_callbacks, _callback);
			return self;
		};
		static on_stop		   = function(_callback) {
			array_push(__.on_stop_callbacks, _callback);
			return self;
		};
		static on_next		   = function(_callback) {
			array_push(__.on_next_callbacks, _callback);
			return self;
		};
		static curve_get_value = function() {
			return __.curve_stack.curve_get_value(__.name_current);
		};
		
		// = PRIVATE ===========
		with (__) {
			static __check_for_next		= function() {
				if (__.name_current != "") {
					if (!__.curve_stack.curve_is_running(__.name_current)) 
					{
						if (__.delay_timer == -1) {
							__.delay_timer = __.delay_time;
						}
					}
				}
			};
			static __update_delay_timer = function() {
				
				if (__.delay_timer == 0) {
					next();
					__.delay_timer = -1;
				}
				else if (__.delay_timer > -1) {
					__.delay_timer--;	
				}
			};
			static __on_start_callbacks = function() {
				iceberg.array.for_each(
					__.on_start_callbacks, 
					function(_callback) {
						_callback(self);
					},
				);
			};
			static __on_stop_callbacks	= function() {
				iceberg.array.for_each(
					__.on_stop_callbacks, 
					function(_callback) {
						_callback(self);
					},
				);
			};
			static __on_next_callbacks	= function() {
				iceberg.array.for_each(
					__.on_next_callbacks, 
					function(_callback) {
						_callback(self);
					},
				);
			};
			
			curve_stack		   = _config[$ "curve_stack"] ?? owner.__.curve_stack;
			names			   = _config[$ "names"		] ?? array_create(0);	
			index			   = _config[$ "index"		] ?? 0;
			running			   = _config[$ "running"	] ?? false;
			delay_time		   = _config[$ "delay_time" ] ?? 0;
			delay_timer		   = -1;
			name_current	   = "";
			on_stop_callbacks  = array_create(0);
			on_start_callbacks = array_create(0);
			on_next_callbacks  = array_create(0);
		};
		
		// = PUBLIC ============
		on_update(function() {
			__check_for_next();
			__update_delay_timer();						
		});
	};
	
	