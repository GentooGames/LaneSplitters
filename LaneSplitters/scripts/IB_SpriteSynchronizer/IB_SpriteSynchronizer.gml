
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   __  __   __   __   ______   __  __   ______   ______   __   __   __   ______   ______   ______    //
	// /\  ___\ /\ \_\ \ /\ "-.\ \ /\  ___\ /\ \_\ \ /\  == \ /\  __ \ /\ "-.\ \ /\ \ /\___  \ /\  ___\ /\  == \   //
	// \ \___  \\ \____ \\ \ \-.  \\ \ \____\ \  __ \\ \  __< \ \ \/\ \\ \ \-.  \\ \ \\/_/  /__\ \  __\ \ \  __<   //
	//  \/\_____\\/\_____\\ \_\\"\_\\ \_____\\ \_\ \_\\ \_\ \_\\ \_____\\ \_\\"\_\\ \_\ /\_____\\ \_____\\ \_\ \_\ //
	//   \/_____/ \/_____/ \/_/ \/_/ \/_____/ \/_/\/_/ \/_/ /_/ \/_____/ \/_/ \/_/ \/_/ \/_____/ \/_____/ \/_/ /_/ //
	//                                                                                                             //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function  IB_SpriteSynchronizer(_config = {}) : IB_Base(_config) constructor { 

		var _self = self;
		
		// public
		static start  = function(_sprite_index = undefined, _image_index = 0, _speed_scale = __.speed_scale_start) {
			
			// load preset
			if (_sprite_index != undefined) {
				preset_load(_sprite_index);	
			}
			
			// store frame advance
			__.frame_advance = _image_index;
			
			// parse data from preset
			if (__.preset != undefined) {	
				__.image_index = __.preset.get_image_index();
				
				// set image_speed properties
				var _image_speed  = __.preset.get_image_speed();
					_image_speed *= _speed_scale;
				  __.image_speed  = __.preset.get_image_speed();
				  __.uses_speed	  = __.preset.get_uses_speed();
				
				// set duration properties
				var _duration  = __.preset.get_duration();
					_duration *= _speed_scale;
					_duration  =  max(_duration, __.preset.get_sprite_number());
				  __.duration  = _duration;
				
				// override duration if using speed
				if (__.uses_speed) {
					__.duration = __.preset.get_sprite_number() / __.image_speed;
				}
				
				// set timer properties
				__.repetitions = __.preset.get_repetitions();
				__.timer.set_repetitions(__.repetitions);
				__.timer.set_period(__.duration);
				__.timer.start();
				
				__.running = true;
				__.paused  = false;
			}
			__on_start(_sprite_index);
			
			return self;
		};
		static stop	  = function() {
			__.timer.stop();
			__.running = false;
			__.paused  = false;
			__on_stop(__.sprite_index);
			return self;
		};
		static pause  = function() {
			__.timer.pause();
			__.paused  = true;
			__.running = false;
			__on_pause(__.sprite_index);
			return self;
		};
		static resume = function() {
			__.timer.resume();
			__.paused  = false;
			__.running = true;
			__on_resume(__.sprite_index);
			return self;
		};
		
		static get_image_index	= function(_floored = false) {
			
			var _image_index = _floored ? floor(__.image_index) : __.image_index;
			
			// preset might have a static definition to always
			// start the sprite on a certain image_index, so 
			// we need to take this into account. almost always
			// this will be 0 though, as nearly every animation
			// binding should start at the beginning 0 index.
			if (__.preset != undefined) {
				return _image_index + __.preset.get_image_index();
			}
			return _image_index;
		};
		static get_image_speed  = function() {
			return __.image_speed;
		};
		static get_speed_scale	= function() {
			return __.speed_scale;
		};
		static get_sprite_index = function() {
			return __.sprite_index;	
		};
		static get_uses_speed	= function() {
			return __.uses_speed;	
		};
		
		static set_image_index	= function(_image_index) {
			__.image_index = _image_index;
			return self;
		};
		static set_speed_scale	= function(_scale) {
			__.speed_scale		 = _scale;
			__.speed_scale_start = _scale;
			return self;
		};
			
		static is_frame			= function(_frame_index) {
			//
			// the goal here is to check that a given frame_index has been
			// hit, but without having this event trigger more than once.
			// generally if we check for an image_index == x, this will 
			// return false if image_speed is a fractional value. the other
			// intuitive solution is to just check floor(image_index) == x,
			// but this also has problems, as it will return true multiple
			// times per frame if image_speed != 1. this implementation 
			// solves this problem by tracking the last frame we tried to 
			// check for, and the current_time that this check was done on.
			// this allows for the trigger to only return once, but will 
			// for that return value to be consistent if checked for multiple
			// times during the same "current_time" game-frame.
			//
			if (__.frame_current == _frame_index) {
				if (__.frame_last_checked	 != _frame_index
				||	__.frame_last_checked_on ==  current_time
				) {
					__.frame_last_checked	 = _frame_index;
					__.frame_last_checked_on =  current_time;
					return true;
				}
			}
			return false;
		};
		static is_paused		= function() {
			return __.paused;
		};	
		static is_running		= function() {
			return __.running;		
		};
		
		static on_complete		= function(_callback, _callback_data) {
			array_push(__.on_complete_callbacks, {
				callback: _callback,
				data:	  _callback_data,
			});
			return self;	
		};
		static on_pause			= function(_callback, _callback_data) {
			array_push(__.on_pause_callbacks, {
				callback: _callback,
				data:	  _callback_data,
			});
			return self;
		};
		static on_repetition	= function(_callback, _callback_data) {
			array_push(__.on_repetition_callbacks, {
				callback: _callback,
				data:	  _callback_data,
			});
			return self;
		};
		static on_resume		= function(_callback, _callback_data) {
			array_push(__.on_resume_callbacks, {
				callback: _callback,
				data:	  _callback_data,
			});
			return self;
		};
		static on_start			= function(_callback, _callback_data) {
			array_push(__.on_start_callbacks, {
				callback: _callback,
				data:	  _callback_data,
			});
			return self;
		};
		static on_stop			= function(_callback, _callback_data) {
			array_push(__.on_stop_callbacks, {
				callback: _callback,
				data:	  _callback_data,
			});
			return self;
		};
		
		static preset_create	= function(_sprite_index, _image_index = 0, _repetitions = 1, _duration, _image_speed = 0, _uses_speed = false) {
			var _preset = new _IB_SpriteSynchronizer_Preset({
				sprite_index: _sprite_index,
				image_index:  _image_index,
				repetitions:  _repetitions,
				duration:	  _duration,
				image_speed:  _image_speed,
				uses_speed:	  _uses_speed,
			}).initialize();
			__.presets.set(_sprite_index, _preset);
			return _preset;
		};
		static preset_delete	= function(_sprite_index) {
			__.presets.remove(_sprite_index);
			return self;
		};
		static preset_get		= function(_sprite_index) {
			return __.presets.get(_sprite_index);	
		};
		static preset_load		= function(_sprite_index) {
			__.preset		= __.presets.get(_sprite_index);
			__.sprite_index = __.preset.get_sprite_index();
			return __.preset;
		};
									
		static keyframe_create	= function(_sprite_index, _frame, _callback, _callback_data_1, _callback_data_2) {
			var _preset	  =  preset_get(_sprite_index);
			var _keyframe = _preset.keyframe_create(_frame, _callback, _callback_data_1, _callback_data_2);
			return _keyframe;
		};
		static keyframe_delete	= function(_sprite_index, _frame) {
			var _preset = preset_get(_sprite_index);
			_preset.keyframe_delete(_frame);
			return self;
		};
		static keyframe_get		= function(_sprite_index, _frame) {
			var _preset = preset_get(_sprite_index);
			return _preset.keyframe_get(_frame);
		};
		
		// private
		with (__) {
			static __on_callback		= function(_callback, _sprite_index) {
				_callback.callback({
					data:		  _callback.data,
					sprite_index: _sprite_index,
				});					
			};
			static __on_complete		= function(_sprite_index) {
				iceberg.array.for_each(
					__.on_complete_callbacks,
					__on_callback,
					_sprite_index,
				);
			};
			static __on_pause			= function(_sprite_index) {
				iceberg.array.for_each(
					__.on_pause_callbacks,
					__on_callback,
					_sprite_index,
				);
			};
			static __on_repetition		= function(_sprite_index) {
				iceberg.array.for_each(
					__.on_repetition_callbacks,
					__on_callback,
					_sprite_index,
				);
			};
			static __on_resume			= function(_sprite_index) {
				iceberg.array.for_each(
					__.on_resume_callbacks,
					__on_callback,
					_sprite_index,
				);
			};
			static __on_start			= function(_sprite_index) {
				iceberg.array.for_each(
					__.on_start_callbacks,
					__on_callback,
					_sprite_index,
				);
			};
			static __on_stop			= function(_sprite_index) {
				iceberg.array.for_each(
					__.on_stop_callbacks,
					__on_callback,
					_sprite_index,
				);
			};
			static __update_image_index	= function() {
				if ((__.running || __.paused) && __.preset != undefined) {
					var _time_base		= __.duration;
					var _time_remaining = __.timer.get_time_remaining();
					var _progress		= (_time_base - _time_remaining) / _time_base;
					__.image_index		= __.frame_advance + ((__.preset.get_sprite_number() - __.frame_advance) * _progress);	
				}
				else {
					__.image_index = 0;
				}
			};
			static __update_keyframe	= function() {
				if (__.preset != undefined) {
					
					static _floor	   = true;
					var _frame_current = get_image_index(_floor);
					
					// check current frame keyframe
					if (__.frame_last != _frame_current) {
						var _keyframe_this  = __.preset.keyframe_get(_frame_current);
						if (_keyframe_this != undefined) {
							_keyframe_this.execute();	
						}
						__.frame_current	  = _frame_current;
						__.frame_last_checked =  undefined;
					}
					__.frame_last = _frame_current;
					
					// -1 frame is executed every frame
					if (__.frame_last_every != _frame_current) {
						var _keyframe_every  = __.preset.keyframe_get(-1);
						if (_keyframe_every != undefined) {
							_keyframe_every.execute();	
						}
					}
					__.frame_last_every = _frame_current;
				}
			};
			
			speed_scale				= _config[$ "speed_scale"] ?? 1;
			speed_scale_start		= speed_scale;
			duration				= 0;
			frame_current			= 0;
			frame_last				= undefined;
			frame_last_every		= undefined;
			frame_last_checked		= undefined;
			frame_last_checked_on	= 0;
			image_index				= 0;
			image_speed				= 0;
			uses_speed				= false;
			on_complete_callbacks	= array_create(0);
			on_pause_callbacks		= array_create(0);
			on_repetition_callbacks	= array_create(0);
			on_resume_callbacks		= array_create(0);
			on_start_callbacks		= array_create(0);
			on_stop_callbacks		= array_create(0);
			preset					= undefined;
			presets					= new IB_Collection_Struct();
			repetitions				= 1;
			running					= false;
			paused					= false;
			sprite_index			= undefined;
			frame_advance			= 0;
			timer					= new IB_TimeSource({
				period:		 0,
				callback:    method(_self, function() {
					__on_repetition(__.sprite_index);	
					if (__.timer.is_complete()) {
						__on_complete(__.sprite_index);	
					}
				}),
				repetitions: 1,
			});
		};
			
		// events
		on_initialize(function() {
			__.timer.initialize();
		});
		on_update	 (function() {
			__update_image_index();
			__update_keyframe();
		});
		on_cleanup   (function() {
			// stop execution
			__.timer.stop();
			__.running = false;
			__.paused  = false;
				
			// wipe presets
			__.presets.for_each(function(_preset) {
				_preset.cleanup();
			});
			__.presets.clear();
		});
	};
	function _IB_SpriteSynchronizer_Preset(_config = {}) : IB_Base(_config) constructor {
		
		var _self = self;
		
		// public
		static get_duration		 = function() {
			return __.duration;
		};
		static get_image_index	 = function() {
			return __.image_index;
		};
		static get_image_speed	 = function() {
			return __.image_speed;	
		};
		static get_repetitions	 = function() {
			return __.repetitions;	
		};
		static get_sprite_index	 = function() {
			return __.sprite_index;
		};
		static get_sprite_number = function() {
			return __.sprite_number;
		};
		static get_uses_speed	 = function() {
			return __.uses_speed;	
		};
		
		static set_duration		 = function(_duration) {
			__.duration = _duration;
			return self;
		};
		static set_image_index	 = function(_image_index) {
			__.image_index = _image_index;
			return self;
		};
		static set_image_speed	 = function(_image_speed) {
			__.image_speed = _image_speed;
			return self;
		};
		static set_repetitions	 = function(_repetitions) {
			__.repetitions = _repetitions;
			return self;
		};
		static set_sprite_index  = function(_sprite_index) {
			__.sprite_index = _sprite_index;
			if (_sprite_index  != undefined) {
				__.sprite_number = sprite_get_number(_sprite_index);	
			}
			return self;
		};
		static set_uses_speed	 = function(_uses_speed) {
			__.uses_speed = _uses_speed;
			return self;
		};
		
		static keyframe_create	 = function(_frame, _callback, _callback_data_1, _callback_data_2) {
			var _keyframe = new _IB_SpriteSynchronizer_KeyFrame({
				frame:			 _frame,
				callback:		 _callback,
				callback_data_1: _callback_data_1,
				callback_data_2: _callback_data_2,
			}).initialize();
			__.keyframes.set(_frame, _keyframe);
			return _keyframe;
		};
		static keyframe_delete	 = function(_frame) {
			__.keyframes.remove(_frame);
			return self;
		};
		static keyframe_execute	 = function(_frame) {
			var _keyframe = __keyframes.get(_frame);
			_keyframe.execute();
			return self;
		};
		static keyframe_exists	 = function(_frame) {
			return __.keyframes.contains(_frame);	
		};
		static keyframe_get		 = function(_frame) {
			return __.keyframes.get(_frame);	
		};
		
		// private
		with (__) {
			image_index	  = _config[$ "image_index" ] ?? 0;
			image_speed	  = _config[$ "image_speed" ] ?? 0; // if uses_speed == true
			duration	  = _config[$ "duration"    ] ?? 0; // if uses_speed == false
			repetitions	  = _config[$ "repetitions" ] ?? 1;
			sprite_index  = _config[$ "sprite_index"] ?? undefined;
			uses_speed	  = _config[$ "uses_speed"  ] ?? false;
			
			sprite_number = sprite_index != undefined ? sprite_get_number(sprite_index) : 0;
			keyframes	  = new IB_Collection_Struct();
		};
		
		// events
		on_cleanup(function() {
			__.keyframes.for_each(function(_keyframe) {
				_keyframe.cleanup();
			});
		});
	};
	function _IB_SpriteSynchronizer_KeyFrame(_config = {}) : IB_Base(_config) constructor {
		
		var _self = self;
		
		// public
		static execute			   = function() {
			if (__.callback != undefined) {
				__.callback(__.callback_data_1, __.callback_data_2);	
			}
			return self;
		};
		static get_frame		   = function() {
			return __.frame
		};
		static get_callback		   = function() {
			return __.callback;
		};
		static get_callback_data_1 = function() {
			return __.callback_data_1;
		};
		static get_callback_data_2 = function() {
			return __.callback_data_2;
		};
		static set_frame		   = function(_frame) {
			__.frame = _frame;
			return self;
		};
		static set_callback		   = function(_callback) {
			__.callback = _callback;
			return self;
		};
		static set_callback_data_1 = function(_data) {
			__.callback_data_1 = _data;
			return self;
		};
		static set_callback_data_2 = function(_data) {
			__.callback_data_2 = _data;
			return self;
		};
		
		// private
		with (__) {
			frame			= _config[$ "frame"			 ];
			callback		= _config[$ "callback"		 ] ?? undefined;
			callback_data_1 = _config[$ "callback_data_1"] ?? undefined;
			callback_data_2 = _config[$ "callback_data_2"] ?? undefined;
		};
	};
	