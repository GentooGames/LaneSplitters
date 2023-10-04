
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  _____    ______   ______   __     __    //
	// /\  __-. /\  == \ /\  __ \ /\ \  _ \ \   //
	// \ \ \/\ \\ \  __< \ \  __ \\ \ \/ ".\ \  //
	//  \ \____- \ \_\ \_\\ \_\ \_\\ \__/".~\_\ //
	//   \/____/  \/_/ /_/ \/_/\/_/ \/_/   \/_/ //
	//                                          //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function _IB_Utility_Draw() constructor {
		
		static __sprite_pixel = IB_Sprite_Pixel_1x1_White;
	
		static circle_curve						= function(_x, _y, _radius, _precision, _angle_start, _angle_end, _thickness, _outline, _alpha = 1.0) {
			static _precision_min = 3;
			_precision = max(_precision_min, _precision);
	
			var _angle_iter	   = _angle_end / _precision;
			var _angle_final   = _angle_start + _angle_end;
			var _len_middle	   = _radius - (_thickness * 0.5);
			var _len_perimeter = _radius + (_thickness * 0.5);
			var _dir_iter_current, _dir_iter_previous;
	
			if (_alpha < 1) draw_set_alpha(_alpha);
	
			if (_outline) {
			
				draw_primitive_begin(pr_trianglestrip);
				draw_vertex(_x + lengthdir_x(_len_middle, _angle_start), _y + lengthdir_y(_len_middle, _angle_start));

				for (var i = 1; i <= _precision; i++) {
					_dir_iter_current  = _angle_start      + _angle_iter * i;
					_dir_iter_previous = _dir_iter_current - _angle_iter;
					draw_vertex(_x + lengthdir_x(_len_perimeter, _dir_iter_previous), _y + lengthdir_y(_len_perimeter, _dir_iter_previous));
					draw_vertex(_x + lengthdir_x(_len_middle,	 _dir_iter_current ), _y + lengthdir_y(_len_middle,	   _dir_iter_current));
				}
				draw_vertex(_x + lengthdir_x(_len_perimeter, _angle_final), _y + lengthdir_y(_len_perimeter, _angle_final));
				draw_vertex(_x + lengthdir_x(_len_middle,    _angle_final), _y + lengthdir_y(_len_middle,    _angle_final));
			}
			else {
				draw_primitive_begin(pr_trianglefan);
				draw_vertex(_x, _y);

				for (i = 1; i <= _precision; i++) {
					_dir_iter_current  = _angle_start      + _angle_iter * i;
					_dir_iter_previous = _dir_iter_current - _angle_iter;
					draw_vertex(_x + lengthdir_x(_len_perimeter, _dir_iter_previous), _y + lengthdir_y(_len_perimeter, _dir_iter_previous));
				}
				draw_vertex(_x + lengthdir_x(_len_perimeter, _angle_final), _y + lengthdir_y(_len_perimeter, _angle_final));
			}	
			draw_primitive_end();
	
			if (_alpha < 1) draw_set_alpha(1.0);
		};
		static circle_strip_horizontal_centered	= function(_x_center, _y, _count, _radius, _space, _outline, _color = c_white) {
			var _diameter = _radius * 2;
			var _x_space  = _diameter + _space;
			var _width	  = _count * _x_space;
			var _x_start  = _x_center - (_width * 0.5) + _radius;
		
			for (var _i = 0; _i < _count; _i++) {
				draw_circle_color(_x_start + (_x_space * _i), _y, _radius, _color, _color, _outline);
			};
		};
		static circle_strip_horizontal			= function(_x, _y, _count, _radius, _space, _outline, _color = c_white) {
			var _diameter = _radius * 2;
			var _x_space  = _diameter + _space;
		
			for (var _i = 0; _i < _count; _i++) {
				draw_circle_color(_x + (_x_space * _i), _y, _radius, _color, _color, _outline);
			};
		};
		static colors_merge						= function(_color1, _color2, _amount) {
			return merge_color(_color1, _color2, _amount);	
		};
		static colors_pulse						= function(_color1, _color2, _duration, _offset = 0) {
			return merge_color(_color1, _color2,
				iceberg.math.wave(0, 1, _duration, _offset),
			);
		};
		static line_arrow						= function(_x1, _y1, _x2, _y2, _width, _color, _leg_length, _leg_dir = 30, _draw_stem = true) {
			if (_draw_stem) {
				draw_line_width_color(_x1, _y1, _x2, _y2, _width, _color, _color);
			}
			var _line_dir  =  point_direction(_x1, _y1, _x2, _y2);
			var _leg_1_dir = _line_dir + 180 + _leg_dir;
			var _leg_2_dir = _line_dir + 180 - _leg_dir;
	
			/// Leg 1
			draw_line_width_color(
				_x2, _y2, 
				_x2 + lengthdir_x(_leg_length, _leg_1_dir), 
				_y2 + lengthdir_y(_leg_length, _leg_1_dir),
				_width,
				_color, _color,
			);
	
			/// Leg 2
			draw_line_width_color(
				_x2, _y2, 
				_x2 + lengthdir_x(_leg_length, _leg_2_dir), 
				_y2 + lengthdir_y(_leg_length, _leg_2_dir),
				_width,
				_color, _color,
			);
		};
		static rectangle						= function(_x, _y, _width, _height, _rot, _col, _alpha) {
			draw_sprite_ext(__sprite_pixel, 0, _x, _y, _width, _height, _rot, _col, _alpha);
		};
		static rectangle_cooldown				= function(_x1, _y1, _x2, _y2, _percent, _color = c_white, _alpha = 1) {
		
			static __draw_corners = function(_x1, _y1, _x2, _y2, _percent, _color, _alpha) {
				if (_percent >= 0.125) draw_vertex_color(_x2, _y1, _color, _alpha)
				if (_percent >= 0.375) draw_vertex_color(_x2, _y2, _color, _alpha)
				if (_percent >= 0.625) draw_vertex_color(_x1, _y2, _color, _alpha)
				if (_percent >= 0.875) draw_vertex_color(_x1, _y1, _color, _alpha)
			};
			static __get_vector	  = function(_percent) {
			
				static __normalize = function(_vec) {
					var _length = max(abs(_vec.x), abs(_vec.y))
					if (_length < 1) {
						_vec.x /= _length;
						_vec.y /= _length;
					}
				};
		
				var _angle = pi * (_percent * 2 - 0.5)
				var _xy	   = { 
					x: cos(_angle), 
					y: sin(_angle),
				};
			
				__normalize(_xy);
				return _xy;
			};
	
			if (_percent <= 0) return;
	
			draw_primitive_begin(pr_trianglefan);
		
				var _center	= { x: (_x1 + _x2) / 2, y: (_y1 + _y2) / 2 };
				draw_vertex_color(_center.x, _center.y, _color, _alpha); 
				draw_vertex_color(_center.x, _y1, _color, _alpha);
				__draw_corners(_x1, _y1, _x2, _y2, _percent, _color, _alpha);
			
				var _vec = __get_vector(_percent);
				var _vx	 = _center.x + _vec.x * (_x2 - _x1) / 2;
				var _vy	 = _center.y + _vec.y * (_y2 - _y1) / 2;
				draw_vertex_color(_vx, _vy, _color, _alpha);
			
			draw_primitive_end();
		};
		static rectangle_outline				= function(_x1, _y1, _x2, _y2, _width, _color) {
			// replace draw_line_width() with rectangle()
			draw_set_color(_color);
			draw_line_width(_x1, _y1, _x2, _y1, _width);
			draw_line_width(_x2, _y1, _x2, _y2, _width);
			draw_line_width(_x1, _y2, _x2, _y2, _width);
			draw_line_width(_x1, _y1, _x1, _y2, _width);
			draw_set_color(c_white);
		};
		static text_halign_right				= function(_x, _y, _string, _xscale, _yscale, _angle = 0, _color = c_white, _alpha = 1) {
			var _width = string_width(_string) * _xscale;
				_x	  -= _width;
			
			draw_text_transformed_color(
				_x, 
				_y,
				_string,
				_xscale,
				_yscale,
				_angle,
				_color, 
				_color, 
				_color, 
				_color, 
				_alpha, 
			);
		};
		static text_halign_centered				= function(_x, _y, _string, _xscale, _yscale, _angle = 0, _color = c_white, _alpha = 1) {
			var _width =  string_width(_string) * _xscale;
				_x	  -= _width * 0.5;
		
			draw_text_transformed_color(
				_x, 
				_y,
				_string,
				_xscale,
				_yscale,
				_angle,
				_color, 
				_color, 
				_color, 
				_color, 
				_alpha, 
			);
		};
		static text_valign_bottom				= function() {};
		static text_valign_centered				= function() {};
		static text_centered					= function() {};
	};

