
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______  __   __    __   ______    //
	// /\__  _\/\ \ /\ "-./  \ /\  ___\   //
	// \/_/\ \/\ \ \\ \ \-./\ \\ \  __\   //
	//    \ \_\ \ \_\\ \_\ \ \_\\ \_____\ //
	//     \/_/  \/_/ \/_/  \/_/ \/_____/ //
	//                                    //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function _IB_Utility_Time(_config = {}) constructor {
	
		static __second = room_speed;
		static __minute = __second * 60;
		
		static do_every_frame	   = function(_interval) {
			
			// this will crash, system util no longer exists and
			// the incremented frame should be accounted for 
			// inside of the obj_iceberg object itself.
			return (iceberg.__.system.frame % _interval == 0);
		};
		static get_clock		   = function(_clock_name) {
			return __.clocks.get(_clock_name);
		};
		static new_clock		   = function(_clock_name, _update_frequency = iceberg.clock_get_tick_rate()) {
			var _clock = new iota_clock();
			_clock.set_update_frequency(_update_frequency);
			return _clock;
		};
		static remove_clock		   = function(_clock_name) {};
		static seconds			   = function(_count) {
			return __second * _count;
		};
		static draw_frames_as_time = function(_frames, _x, _y, _scale = 1, _angle = 0) {
			
			var _seconds_total	= _frames / SECOND;
			var _minutes		=  string_format(_seconds_total div SECOND, 1, 0);
			var _seconds_remain	= _seconds_total % SECOND;
					
			// dont ever show 60 seconds. either 59 or 0 seconds
			if (_seconds_remain < 1) {
				if ( _seconds_remain > 0.5) {
					 _seconds_remain = 1;
				}
				else _seconds_remain = 0;
			}
			if (_seconds_remain > 59.5) {
				_seconds_remain = 0;
			}
			_seconds_remain = string_format(_seconds_remain, 1, 0);
					
			// add leading 0 to seconds if below 10 seconds
			if (_seconds_remain < 10) {
				 var _time = _minutes + ":0" + _seconds_remain;
			}
			else var _time = _minutes + ":"  + _seconds_remain;
					
			draw_text_transformed(_x, _y, _time, _scale, _scale, _angle);
		};
	};


