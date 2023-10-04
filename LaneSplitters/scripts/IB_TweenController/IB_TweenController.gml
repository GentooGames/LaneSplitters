
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______  __     __   ______   ______   __   __    //
	// /\__  _\/\ \  _ \ \ /\  ___\ /\  ___\ /\ "-.\ \   //
	// \/_/\ \/\ \ \/ ".\ \\ \  __\ \ \  __\ \ \ \-.  \  //
	//    \ \_\ \ \__/".~\_\\ \_____\\ \_____\\ \_\\"\_\ //
	//     \/_/  \/_/   \/_/ \/_____/ \/_____/ \/_/ \/_/ //
	//                                                   //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //	
	function IB_TweenController(_config = {}) : IB_Base(_config) constructor {

		#region docs
		/*
			// instantiate tween
			tween = new IB_TweenController().initialize();
	
			// defined first custom curve
			tween.create("my_tween_1", {
				value_begin:	0,
				value_end:		5,
				curve_index:	IB_TweenController_Curves,
				curve_channel: "linear",
				duration:		SECOND * 1,
			});
		
			// assigned curve callbacks
			tween.on_start("my_tween_1", function(_tween) {
				show_debug_message("tween start: " + _tween.get_name());	
			});
		
			// make sure to call update on tween
			on_update(function() {
				tween.update();
			});
		*/
		#endregion

		// public
		static create	  = function(_curve_name, _curve_config = {}, _auto_destroy = false) {
			
			_curve_config[$ "name"		  ]   = _curve_name;
			_curve_config[$ "running"	  ] ??= __.start_running;
			_curve_config[$ "value_begin" ] ??= 0;
			_curve_config[$ "value_end"   ] ??= 1;
			_curve_config[$ "auto_destroy"] ??= _auto_destroy;
			
			var _curve = new IB_TweenCurve(_curve_config).initialize();
			
			__.curves.set(_curve_name, _curve);
			
			return _curve;
		};
		static destroy	  = function(_curve_name) {
			var _curve = __.curves.get(_curve_name);
			if (_curve != undefined) {
			
				// remove curve from stack
				__.curves.remove(_curve_name);
			
				// cleanup curve class instance
				_curve.cleanup();
			}
			return self;
		};
		static start	  = function(_curve_name, _t = 0, _on_stop_callback = undefined) {
			var _curve  = __.curves.get(_curve_name);
			if (_curve != undefined) {
				_curve.start(_t, _on_stop_callback);
			}
			return self;
		};
		static stop		  = function(_curve_name, _execute_callbacks = true) {
			var _curve  = __.curves.get(_curve_name);
			if (_curve != undefined) {
				_curve.stop(_execute_callbacks);
			}
			return self;
		};
		static pause	  = function(_curve_name) {
			var _curve  = __.curves.get(_curve_name);
			if (_curve != undefined) {
				_curve.pause();
			}
			return self;
		};
		static get_value  = function(_curve_name) {
			var _curve  = __.curves.get(_curve_name);
			if (_curve != undefined) {
				return _curve.get_value_curve();
			}
			return 0;
		};
		static is_running = function(_curve_name) {
			var _curve  = __.curves.get(_curve_name);
			if (_curve != undefined) {
				return _curve.is_running();	
			}
			return false;
		};
		static on_start	  = function(_curve_name, _callback) {
			var _curve  = __.curves.get(_curve_name);
			if (_curve != undefined) {
				_curve.on_start(_callback);	
			}
			return self;
		};
		static on_stop	  = function(_curve_name, _callback) {
			var _curve  = __.curves.get(_curve_name);
			if (_curve != undefined) {
				_curve.on_stop(_callback);	
			}
			return self;
		};
		
		// private
		with (__) {
			start_running	   = _config[$ "start_running"] ?? false;
			curves			   = new IB_Collection_Struct();
			on_start_callbacks = array_create(0);
			on_stop_callbacks  = array_create(0);
		};
		
		// events
		on_update (function() {
			__.curves.for_each(function(_curve) {
				_curve.update();
			});
		});
		on_cleanup(function() {
			__.curves.for_each(function(_curve) {
				_curve.cleanup();
			});
		});
	};
	function IB_TweenCurve(_config = {}) : IB_Base(_config) constructor {
			
		// public
		static start				= function(_t = 0, _on_stop_callback = undefined) {
			__.running				 =  true;
			__.t					 = _t;
			__.on_stop_temp_callback = _on_stop_callback;
			__on_start();	
			return self;
		};
		static stop					= function(_execute_callbacks = true) {
			__.running = false;
			__.t	   = 0;
			if (_execute_callbacks) __on_stop();	
			if (__.auto_destroy) __.owner.destroy(get_name());	
			return self;
		};
		static pause				= function() {
			__.running = false;
			return self;
		};
		static is_running			= function() {
			return __.running;	
		};
		static on_start				= function(_callback) {
			array_push(__.on_start_callbacks, _callback);
			return self;
		};
		static on_stop				= function(_callback) {
			array_push(__.on_stop_callbacks, _callback);
			return self;
		};
		static get_value_curve		= function() {
			var _channel = animcurve_get_channel(__.curve_index, __.curve_channel);
			var _value	 = animcurve_channel_evaluate(_channel, __.t)
			return iceberg.math.remap(0, 1, __.value_begin, __.value_end, _value);
		};
		static set_value_begin		= function(_value_begin) {
			__.value_begin = _value_begin;
			return self;
		};
		static set_value_end		= function(_value_end) {
			__.value_end = _value_end;
			return self;
		};
		static set_curve_index		= function(_curve_index) {
			__.curve_index = _curve_index;
			return self;
		};
		static set_curve_channel	= function(_channel_index) {
			__.curve_channel = _channel_index;
			return self;
		};
		static set_duration			= function(_duration) {
			__.duration = _duration;
			__.speed	= 1 / __.duration;
			return self;
		};
		static set_on_stop_behavior = function(_on_stop_behavior) {
			__.on_stop_behavior = _on_stop_behavior;
			return self;
		};
		
		// private
		with (__) {
			static __update_t  = function() {
				__.t = min(__.t + __.speed, 1);
				if (__.t >= 1) stop(true); 
			}; 
			static __on_start  = function() {
				iceberg.array.for_each(__.on_start_callbacks, function(_callback) {
					_callback(self);
				});
			};
			static __on_stop   = function() {
				iceberg.array.for_each(__.on_stop_callbacks, function(_callback) {
					_callback(self);
				});
				if (__.on_stop_temp_callback != undefined) {
					__.on_stop_temp_callback(self);	
				}
			};
			
			value_begin			  = _config[$ "value_begin"  ] ?? 0;
			value_end			  = _config[$ "value_end"	 ] ?? 1;
			curve_index			  = _config[$ "curve_index"  ] ?? IB_TweenController_Curves;
			curve_channel		  = _config[$ "curve_channel"] ?? "linear";
			duration			  = _config[$ "duration"	 ] ?? room_speed;
			running				  = _config[$ "running"		 ] ?? true;
			auto_destroy		  = _config[$ "auto_destroy" ] ?? false;
			on_start_callbacks	  = [];
			on_stop_callbacks	  = [];
			on_stop_temp_callback = undefined;
			speed				  = 1 / duration;
			t					  = 0;
		};
		
		// events
		on_update(function() {
			if (__.running) {
				__update_t();
			}
		});
	};
	
	