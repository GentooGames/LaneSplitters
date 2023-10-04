
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  __   ______   ______   __    __   ______  ______  ______   __   ______    //
	// /\ \ /\  ___\ /\  __ \ /\ "-./  \ /\  ___\/\__  _\/\  == \ /\ \ /\  ___\   //
	// \ \ \\ \___  \\ \ \/\ \\ \ \-./\ \\ \  __\\/_/\ \/\ \  __< \ \ \\ \ \____  //
	//  \ \_\\/\_____\\ \_____\\ \_\ \ \_\\ \_____\ \ \_\ \ \_\ \_\\ \_\\ \_____\ //
	//   \/_/ \/_____/ \/_____/ \/_/  \/_/ \/_____/  \/_/  \/_/ /_/ \/_/ \/_____/ //
	//                                                                            //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function _IB_Utility_Isometric() constructor {
	
		static __ISO_WIDTH  = 16;
		static __ISO_HEIGHT = 8;
	
		static ijk_to_x = function(_i, _j, _k, _iso_width = __ISO_WIDTH) {
			return (_i - _j) * (_iso_width * 0.5);
		};
		static ijk_to_y = function(_i, _j, _k, _iso_height = __ISO_HEIGHT) {
			var _y = (_i + _j) * (_iso_height * 0.5);
			var _z = _k * (_iso_height * 1.0);
			return _y - _z;
		};
		static xy_to_i  = function(_x, _y, _iso_width = __ISO_WIDTH, _iso_height = __ISO_HEIGHT) {
			return floor(((_x / (_iso_width * 0.5) + (_y / (_iso_height * 0.5))) * 0.5) + 0.5);
		};
		static xy_to_j  = function(_x, _y, _iso_width = __ISO_WIDTH, _iso_height = __ISO_HEIGHT) {
			return floor(((_y / (_iso_height * 0.5) - (_x / (_iso_width  * 0.5))) * 0.5) + 0.5);
		};
	};
	
