
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  __    __   ______   ______  __  __    //
	// /\ "-./  \ /\  __ \ /\__  _\/\ \_\ \   //
	// \ \ \-./\ \\ \  __ \\/_/\ \/\ \  __ \  //
	//  \ \_\ \ \_\\ \_\ \_\  \ \_\ \ \_\ \_\ //
	//   \/_/  \/_/ \/_/\/_/   \/_/  \/_/\/_/ //
	//                                        //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function _IB_Utility_Math() constructor {

		static angle_perpendicular = function(_x1, _y1, _x2, _y2) {
			var _dir	  = point_direction(_x1, _y1, _x2, _y2);
			var _perp_dir = (_dir + 90) % 360;
			//if (_perp_dir < _dir) {
			//	_perp_dir += 180;
			//}
			return _perp_dir;
		};
		static avg				   = function(/* val_1, ..., val_n*/) {
			var _n   = argument_count;
			var _avg = 0;
	
			for (var _i = 0; _i < _n; _i++) {
				_avg += argument[_i];
			}
			return (_avg / _n);
		};
		static bresenham_line	   = function(_i1, _j1, _i2, _j2, _cb, _cb_data) {
		    var _dist_x		= _i2 - _i1; 
			var _dist_y		= _j2 - _j1; 
		    var _step_x		= sign(_dist_x);
		    var _step_y		= sign(_dist_y);
		    _dist_x			= abs(_dist_x);
		    _dist_y			= abs(_dist_y);
		    var _dist		= max(_dist_x, _dist_y);
		    var _remainder	= _dist / 2;
	
		    if (_dist_x > _dist_y) {
		        for (var _i = 0; _i <= _dist; _i++) {
		            _cb(_i1, _j1, _cb_data);
            
					_i1 += _step_x;
		            _remainder += _dist_y;
			
		            if (_remainder >= _dist_x) {
		                _j1 += _step_y;
		                _remainder -= _dist_x;
		            }
		        }
		    }
		    else for (var _i = 0; _i <= _dist; _i++) {
		        _cb(_i1, _j1, _cb_data);
		
		        _j1 += _step_y;
		        _remainder += _dist_x;
		
		        if (_remainder >= _dist_y) {
		            _i1 += _step_x;
		            _remainder -= _dist_y;
		        }
		    }
		};
		static dist_thresh		   = function(_value1, _value2, _thresh, _abs = true) {
			if (_abs) {
				return abs(_value1 - _value2) <= _thresh;
			}
			return (_value1 - _value2) <= _thresh;
		};
		static is_even			   = function(_value) {
			return !is_odd(_value);
		};
		static is_odd			   = function(_value) {
			return (_value mod 2);
		};
		static percent			   = function(_percent) {
			return (random(1) < _percent);
		};
		static plot_line		   = function(_i1, _j1, _i2, _j2) {
			var _di  = abs(_i2 - _i1);
			var _si  = _i1 < _i2 ? 1 : -1;
			var _dj  = -abs(_j2 - _j1);
			var _sj  = _j1 < _j2 ? 1 : -1;
			var _err = _di + _dj;
			var _coords = [];

			while (true) {
				array_push(_coords, { i: _i1, j: _j1 });
				if (_i1 == _i2 && _j1 == _j2) break;
		
				var _e2  = _err * 2;
				if (_e2 >= _dj) {
					_err += _dj;
					_i1  += _si;
				}
				if (_e2 <= _di) {
					_err += _di;
					_j1  += _sj;
				}
			}
			return _coords;
		};
		static remap			   = function(_input_min, _input_max, _output_min, _output_max, _value) {
			var _t = iceberg.tween.lerp_inverse(_input_min, _input_max, _value);
			return lerp(_output_min, _output_max, _t);
		};
		static rotate_around	   = function(_rot, _amount, _max) {
			var _target = _rot + _amount;
			while (_target < 0) {
				_target += 360;
			}
			return _target % _max;
		};
		static wrap				   = function(_val, _min, _max) {
			return ((_val > _max) ? _min : (_val < _min ? _max : _val));
		};
	};
