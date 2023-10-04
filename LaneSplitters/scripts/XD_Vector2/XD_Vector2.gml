
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  __   __ ______   ______   ______  ______   ______    //
	// /\ \ / //\  ___\ /\  ___\ /\__  _\/\  __ \ /\  == \   //
	// \ \ \'/ \ \  __\ \ \ \____\/_/\ \/\ \ \/\ \\ \  __<   //
	//  \ \__|  \ \_____\\ \_____\  \ \_\ \ \_____\\ \_\ \_\ //
	//   \/_/    \/_____/ \/_____/   \/_/  \/_____/ \/_/ /_/ //
	//                                                       //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function XD_Vector2(_x = 0, _y = 0) constructor {
	
		x = _x;
		y = _y;
	
		static get_magnitude		 = function() {
			return point_distance(0, 0, x, y);
		};
		static get_magnitude_squared = function() {
			return x * x + y * y;
		};
		static get_direction		 = function() {
			return point_direction(0, 0, x, y);
		};
		static set_magnitude		 = function(_magnitude) {
			var _dir = get_direction();
			x = lengthdir_x(_magnitude, _dir);
			y = lengthdir_y(_magnitude, _dir);
			return self;
		};
		static set_direction		 = function(_dir) {
			var _len = get_magnitude();
			x = lengthdir_x(_len, _dir);
			y = lengthdir_y(_len, _dir);
			return self;
		};
		static set_magnitude_dir	 = function(_magnitude, _dir) {
			x = lengthdir_x(_magnitude, _dir);
			y = lengthdir_y(_magnitude, _dir);
			return self;
		};
		static is_equals			 = function(_vect) {
			return x == _vect.x && y == _vect.y;
		};
		static has_magnitude		 = function() {
			return get_magnitude() != 0;
		};
		static draw					 = function(_x, _y, _length = 1, _width = 1, _color = c_white) {
			var _dir	 = get_direction();
				_length *= get_magnitude();
			draw_line_width_color(
				_x,
				_y,
				_x + lengthdir_x(_length, _dir),
				_y + lengthdir_y(_length, _dir),
				_width,
				_color,
				_color,
			);
		};
	
		// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	
		// operations
		static normalize	   = function() {
			var _dir = get_direction();
			x = lengthdir_x(1, _dir);
			y = lengthdir_y(1, _dir);
			return self;
		};
		static interpolate_to  = function(_dest_vector, _amount) {
			x = lerp(x, _dest_vector.x, _amount);
			y = lerp(y, _dest_vector.y, _amount);
			return self;
		};
		static interpolate_dir = function(_dir, _amount) {
			set_direction(
				iceberg.tween.lerp_angle(get_direction(), _dir, _amount)
			);
			return self;
		};
		static assign_to	   = function(_vect) {
			x = _vect.x; 
			y = _vect.y;
			return self;
		};
		static limit_to		   = function(_max_vector) {
			x = min(x, _max_vector.x);
			y = min(y, _max_vector.y);
			return self;
		};
		static limit_magnitude = function(_amount) {
			if (get_magnitude() > _amount) {
				set_magnitude(_amount);
			}
			return self;
		};
		static clamp_to		   = function(_min_vector, _max_vector) {
			x = clamp(x, _min_vector.x, _max_vector.x);
			y = clamp(y, _min_vector.y, _max_vector.y);
			return self;
		};
		static clamp_by		   = function(_min, _max) {
			x = clamp(x, _min, _max);
			y = clamp(y, _min, _max);
			return self;
		};
		static clamp_x_by	   = function(_min, _max) {
			x = clamp(x, _min, _max);
			return self;
		};
		static clamp_y_by	   = function(_min, _max) {
			y = clamp(y, _min, _max);
			return self;
		};
		static reflect_over	   = function(_normal_vector) {
			var _dot	= dot_product(x, y, _normal_vector.x, _normal_vector.y);
			var _factor = 2.0 * _dot;
			x = x - _factor * _normal_vector.x;
			y = y - _factor * _normal_vector.y;
			return self;
		};
		static negate		   = function() {
			x = -x;
			y = -y;
			return self;
		};
		static copy_to_array   = function(_array, _index = 0) {
			_array[@ _index	   ] = x;
			_array[@ _index + 1] = y;
			return self;
		};
		static copy			   = function() {
			return new XD_Vector2(x, y);
		};
		static zero			   = function() {
			x = 0;
			y = 0;
			return self;
		};
		static dot			   = function(_vector) {
			return dot_product(x, y, _vector.x, _vector.y);
		};
		static rotate		   = function(_degrees) {
			var _radians = degtorad(_degrees);
			x = ((x * cos(_radians)) - (y * sin(_radians)));
			y = ((x * sin(_radians)) + (y * cos(_radians)));
			return self;
		};
						   
		// math 			   
		static absolute_value  = function() {
			x = abs(x);
			y = abs(y);
			return self;
		};
		static add			   = function(_vect) {
			x += _vect.x;
			y += _vect.y;
			return self;
		};
		static add_by		   = function(_x, _y = _x) {
			x += _x;
			y += _y;
			return self;
		};
		static subtract		   = function(_vect) {
			x -= _vect.x;
			y -= _vect.y;
			return self;
		};
		static subtract_by	   = function(_x, _y = _x) {
			x -= _x;
			y -= _y;
			return self;
		};
		static multiply		   = function(_vect) {
			x *= _vect.x;
			y *= _vect.y;
			return self;
		};
		static multiply_by	   = function(_x, _y = _x) {
			x *= _x;
			y *= _y;
			return self;
		};
		static divide		   = function(_vect) {
			x /= _vect.x;
			y /= _vect.y;
			return self;
		};
		static divide_by	   = function(_x, _y = _x) {
			x /= _x;
			y /= _y;
			return self;
		};
		static scale		   = function(_vect) {
			var _dot	= dot(self, _vect);
			var _scalar = _dot / get_magnitude_squared();
			multiply_by(_scalar);
			return self;
		};
	};
