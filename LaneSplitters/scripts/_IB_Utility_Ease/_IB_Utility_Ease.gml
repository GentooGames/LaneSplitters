
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   ______   ______   ______    //
	// /\  ___\ /\  __ \ /\  ___\ /\  ___\   //
	// \ \  __\ \ \  __ \\ \___  \\ \  __\   //
	//  \ \_____\\ \_\ \_\\/\_____\\ \_____\ //
	//   \/_____/ \/_/\/_/ \/_____/ \/_____/ //
	//                                       //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function _IB_Utility_Ease() constructor {

		// t is calculate as the numerator over duration. 
		// so if duration is 60 frames, then t should be 
		// between 0 - 60. duration defaults to 1 so that
		// t can default between 0 - 1.

		static _BOUNCE = 1.70158;
		static _PI	   = pi;
		static _2PI	   = pi * 2;

		static back_in		  = function(_start, _end, _t, _duration = 1) {
			var _v = _t / _duration;
			return _end * _v * _v * ((_BOUNCE + 1) * _v - _BOUNCE) + _start;
		};
		static back_in_out    = function(_start, _end, _t, _duration = 1) {
			var _v =  _t / _duration * 2;
			var _b = _BOUNCE * 1.525;
			if (_v < 1) {
				return _end * 0.5 * (((_b + 1) * _v - _b) * _v * _v) + _start;
			}
			_v -= 2;
			return _end * 0.5 * (((_b + 1) * _v + _b) * _v * _v + 2) + _start;
		};
		static back_out		  = function(_start, _end, _t, _duration = 1) {
			var _v = _t / _duration - 1;
			return _end * (_v * _v * ((_BOUNCE + 1) * _v + _BOUNCE) + 1) + _start;
		};
		static bounce_in	  = function(_start, _end, _t, _duration = 1) {
			return _end - bounce_out(_duration - _t, 0, _end, _duration) + _start;
		};
		static bounce_in_out  = function(_start, _end, _t, _duration = 1) {
			if (_t < _duration * 0.5) {
			    return (bounce_in(_t * 2, 0, _end, _duration) * 0.5 + _start);
			}
			return (bounce_out(_t * 2 - _duration, 0, _end, _duration) * 0.5 + _end * 0.5 + _start);
		};
		static bounce_out	  = function(_start, _end, _t, _duration = 1) {
		
			static _t1 = (1.000 / 2.750);
			static _t2 = (2.000 / 2.750);
			static _t3 = (1.500 / 2.750);
			static _t4 = (2.250 / 2.750);
			static _t5 = (2.500 / 2.750);
			static _t6 = (2.625 / 2.750);
		
			static _c1 = 7.562500;
			static _c2 = 0.750000;
			static _c3 = 0.937500;
			static _c4 = 0.984375;
		
			var _v = _t / _duration;
		
			if (_v < _t1) {
			    return _end * _c1 * _v * _v + _start;
			}
			if (_v < _t2) {
			    _v -= _t3;
			    return _end * (_c1 * _v * _v + _c2) + _start;
			}
			if (_v < _t5) {
			    _v -= _t4;
			    return _end * (_c1 * _v * _v + _c3) + _start;
			}
		
			_v -= _t6;
			return _end * (_c1 * _v * _v + _c4) + _start;
		};
		static circ_in		  = function(_start, _end, _t, _duration = 1) {
			var _v = _t / _duration;
			return _end * (1 - sqrt(1 - _v * _v)) + _start;
		};
		static circ_in_out    = function(_start, _end, _t, _duration = 1) {
			var _v = 2 * _t / _duration;
			if (_v < 1) { 
				return _end * 0.5 * (1 - sqrt(abs(1 - _v * _v))) + _start; 
			}
			_v -= 2;
			return _end * 0.5 * (sqrt(abs(1 - _v * _v)) + 1) + _start;
		};
		static circ_out		  = function(_start, _end, _t, _duration = 1) {
			var _v = _t / _duration - 1;
			return _end * sqrt(abs(1 - _v * _v)) + _start;
		};
		static cubic_in		  = function(_start, _end, _t, _duration = 1) {
			return _end * power(_t / _duration, 3) + _start;
		};
		static cubic_in_out   = function(_start, _end, _t, _duration = 1) {
			var _v = 2 * _t / _duration;
			if (_v < 1) { 
				return _end * 0.5 * power(_v, 3) + _start; 
			}
			return _end * 0.5 * (power(_v - 2, 3) + 2) + _start;
		};
		static cubic_out	  = function(_start, _end, _t, _duration = 1) {
			return _end * (power(_t / _duration - 1, 3) + 1) + _start;
		};
		static cubic_out_in	  = function(_start, _end, _t, _duration = 1) {
			if (_t < _duration / 2) {
				return cubic_out(_t * 2, _start, _end / 2, _duration);
			} 
			return cubic_in((_t * 2) - _duration, _start + _end / 2, _end / 2, _duration);
		};
		static elastic_in	  = function(_start, _end, _t, _duration = 1) {
	
			if (_t == 0 || _a == 0) return _start;

			_t /= _duration;
			if (_t == 1) return _start + _end;
		
			var _s = _BOUNCE;
			var _a =  _end;
			var _p =   0;

			if (_p == 0) { 
				_p = _duration * 0.3; 
			}
			if (_a < abs(_end)) { 
			    _a = _end; 
			    _s = _p * 0.25; 
			}
			else {
			    _s = _p / _2PI * arcsin(_end / _a);
			}
			return -(_a * power(2,10 * (--_t)) * sin((_t * _duration - _s) * _2PI / _p)) + _start;
		};
		static elastic_in_out = function(_start, _end, _t, _duration = 1) {
		
			if (_t == 0 || _end == 0) return _start;

			_t /= _duration * 0.5;
			if (_t == 2) return _start + _end;

			var _s = _BOUNCE;
			var _a =  _end;
			var _p =   0;

			if (_p == 0) { 
				_p = _duration * (0.3 * 1.5); 
			}
			if (_a < abs(_end)) { 
			    _a = _end;
			    _s = _p * 0.25;
			}
			else {
			    _s = _p / _2PI * arcsin(_end / _a);
			}

			if (_t < 1) { 
				return -0.5 * (_a * power(2, 10 * (--_t)) * sin((_t * _duration - _s) * _2PI / _p)) + _start; 
			}
			return _a * power(2, -10 * (--_t)) * sin((_t * _duration - _s) * _2PI / _p) * 0.5 + _end + _start;
		};
		static elastic_out	  = function(_start, _end, _t, _duration = 1) {
		
			if (_t == 0 || _a == 0) return _start;

			_t /= _duration;
			if (_t == 1) return _start + _end;
		
			var _s = _BOUNCE;
			var _a =  _end;
			var _p =   0;

			if (_p == 0) { 
				_p = _duration * 0.3; 
			}
			if (_a < abs(_end)) { 
			    _a = _end;
			    _s = _p * 0.25; 
			}
			else {
			    _s = _p / _2PI * arcsin(_end / _a);
			}
			return _a * power(2, -10 * _t) * sin((_t * _duration - _s) * _2PI / _p ) + _end + _start;
		};
		static expo_in		  = function(_start, _end, _t, _duration = 1) {
			return _end * power(2, 10 * (_t / _duration - 1)) + _start;
		};
		static expo_in_out    = function(_start, _end, _t, _duration = 1) {
			var _v = 2 * _t / _duration;
			if (_v < 1) { 
				return _end * 0.5 * power(2, 10 * --_v) + _start; 
			}
			return _end * 0.5 * (-power(2, -10 * --_v) + 2) + _start;
		};
		static expo_out		  = function(_start, _end, _t, _duration = 1) {
			return _end * (-power(2, -10 * _t / _duration) + 1) + _start;
		};
		static linear		  = function(_start, _end, _t, _duration = 1) {
			return _end * _t / _duration + _start;
		};	
		static sine_in		  = function(_start, _end, _t, _duration = 1) {
			return _end * (1 - cos(_t / _duration * _2PI)) + _start;
		};
		static sine_in_out    = function(_start, _end, _t, _duration = 1) {
			return _end * 0.5 * (1 - cos(_PI * _t / _duration)) + _start;
		};
		static sine_out		  = function(_start, _end, _t, _duration = 1) {
			return _end * sin(_t / _duration * _2PI) + _start;
		};
		static quad_in		  = function(_start, _end, _t, _duration = 1) {
			var _v = _t / _duration;
			return _end * _v * _v + _start;   
		};
		static quad_in_out    = function(_start, _end, _t, _duration = 1) {
			var _v = 2 * _t / _duration;
			if (_v < 1) {
			    return _end * 0.5 * _v * _v + _start;
			}
			return _end * -0.5 * ((_v - 1) * (_v - 3) - 1) + _start;
		};
		static quad_out		  = function(_start, _end, _t, _duration = 1) {
			var _v = _t / _duration;
			return -_end * _v * (_v - 2) + _start;
		};
		static quart_in		  = function(_start, _end, _t, _duration = 1) {
			return _end * power(_t / _duration, 4) + _start;
		};
		static quart_in_out   = function(_start, _end, _t, _duration = 1) {
			var _v = 2 * _t / _duration;
			if (_v < 1) { 
				return _end * 0.5 * power(_v, 4) + _start; 
			}
			return _end * -0.5 * (power(_v - 2, 4) - 2) + _start;
		};
		static quart_out	  = function(_start, _end, _t, _duration = 1) {
			return -_end * (power(_t / _duration - 1, 4) - 1) + _start;
		};
		static quint_in		  = function(_start, _end, _t, _duration = 1) {
			return _end * power(_t / _duration, 5) + _start;
		};
		static quint_in_out   = function(_start, _end, _t, _duration = 1) {
			var _v = 2 * _t / _duration;
			if (_v < 1) { 
				return _end * 0.5 * power(_v, 5) + _start;
			}
			return _end * 0.5 * (power(_v - 2, 5) + 2) + _start;
		};
		static quint_out	  = function(_start, _end, _t, _duration = 1) {
			return _end * (power(_t / _duration - 1, 5) + 1) + _start;
		};
		static quint_pop	  = function(_start, _end, _t, _duration = 1) {
		
			_duration    =  round(_duration / 2);
		
			var _startOg = _start;
			var _endOg	 = _end;
	
			if (_t <= _duration) {
				return _end * (power(_t / _duration - 1, 5) + 1) + _start;	
			} 
			else {
				_start = _endOg;
				_end   = _startOg;
				_t -= _duration;
		
				var _output			= _end * (power(_t / _duration - 1, 5) + 1) + _start;	
				var _output_reverse = _end - _output;
		
				return _end + _output_reverse;
			}
		};
	};
