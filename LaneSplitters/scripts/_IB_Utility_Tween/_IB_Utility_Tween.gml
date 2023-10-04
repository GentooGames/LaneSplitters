
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______  __     __   ______   ______   __   __    //
	// /\__  _\/\ \  _ \ \ /\  ___\ /\  ___\ /\ "-.\ \   //
	// \/_/\ \/\ \ \/ ".\ \\ \  __\ \ \  __\ \ \ \-.  \  //
	//    \ \_\ \ \__/".~\_\\ \_____\\ \_____\\ \_\\"\_\ //
	//     \/_/  \/_/   \/_/ \/_____/ \/_____/ \/_/ \/_/ //
	//                                                   //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function _IB_Utility_Tween() constructor {
	
		static DIR_LEFT   = "left";
		static DIR_RIGHT  = "right";
		static DIR_TOP	  = "top";
		static DIR_BOTTOM = "bottom";
	
		static approach		= function(_start, _end, _shift) {
			if (_start < _end) {
			    return min(_start + _shift, _end); 
			}
			return max(_start - _shift, _end);	
		};
		static lerp_angle	= function(_angle_from, _angle_to, _amount) {
		    return _angle_from - angle_difference(_angle_from, _angle_to) * _amount;
		};
		static lerp_inverse	= function(_min, _max, _value) {
			return (_value - _min) / (_max - _min);
		};
		static lerp_radians = function(_from, _to, _amount) {
			var _sin = ((1 - _amount) * sin(_from)) + (_amount * sin(_to));
			var _cos = ((1 - _amount) * cos(_from)) + (_amount * cos(_to));
			var _val = arctan2(_sin, _cos);
			return _val;
		};
		static wave			= function(_from, _to, _duration, _offset = 0) { 
			var _a4 = (_to - _from) * 0.5;
			return _from + _a4 + sin((((current_time * 0.001) + _duration * _offset) / _duration) * (pi * 2)) * _a4;
		};
	};
