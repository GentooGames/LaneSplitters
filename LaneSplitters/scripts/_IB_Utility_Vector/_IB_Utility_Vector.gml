
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  __   __ ______   ______   ______  ______   ______    //
	// /\ \ / //\  ___\ /\  ___\ /\__  _\/\  __ \ /\  == \   //
	// \ \ \'/ \ \  __\ \ \ \____\/_/\ \/\ \ \/\ \\ \  __<   //
	//  \ \__|  \ \_____\\ \_____\  \ \_\ \ \_____\\ \_\ \_\ //
	//   \/_/    \/_____/ \/_____/   \/_/  \/_____/ \/_/ /_/ //
	//                                                       //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function _IB_Utility_Vector() constructor {
	
		static ZERO		= { x:  0, y:  0 }  
		static ONE		= { x:  1, y:  1 } 
		static NEGATIVE = { x: -1, y: -1 } 
		static LEFT		= { x: -1, y:  0 }
		static RIGHT	= { x:  1, y:  0 }
		static UP		= { x:  0, y: -1 }
		static DOWN		= { x:  0, y:  1 }
		
		static create			= function(_x = 0, _y = 0) {
			return new XD_Vector2(_x, _y);
		};
		static distance			= function(_vector_1, _vector_2) {
			return point_distance(_vector_1.x, _vector_1.y, _vector_2.x, _vector_2.y);
		};
		static distance_squared = function(_vector_1, _vector_2) {
			var _dx = _vector_1.x - _vector_2.x;
			var _dy = _vector_1.y - _vector_2.y;
			return _dx * _dx + _dy * _dy;
		};
		static dot				= function(_vector_1, _vector_2) {
			return dot_product(_vector_1.x, _vector_1.y, _vector_2.x, _vector_2.y);
		};
	};

