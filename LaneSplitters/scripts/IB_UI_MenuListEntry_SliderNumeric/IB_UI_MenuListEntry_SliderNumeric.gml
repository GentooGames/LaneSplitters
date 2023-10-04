
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   __       __   _____    ______   ______    //
	// /\  ___\ /\ \     /\ \ /\  __-. /\  ___\ /\  == \   //
	// \ \___  \\ \ \____\ \ \\ \ \/\ \\ \  __\ \ \  __<   //
	//  \/\_____\\ \_____\\ \_\\ \____- \ \_____\\ \_\ \_\ //
	//   \/_____/ \/_____/ \/_/ \/____/  \/_____/ \/_/ /_/ //
	//                                                     //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function IB_UI_MenuListEntry_SliderNumeric(_config = {}) : IB_UI_MenuListEntry(_config) constructor {
		
		var _self = self;
		
		// = PUBLIC ================
		static increment	= function(_amount = __.value_adjust) {
			var _value = __get_value() + _amount;
				_value = clamp(_value, __.value_min, __.value_max);
			__set_value(_value);
			__adjust();
			return self;
		};
		static decrement	= function(_amount = __.value_adjust) {
			var _value = __get_value() - _amount;
				_value = clamp(_value, __.value_min, __.value_max);
			__set_value(_value);
			__adjust();
			return self;
		};
		static set_variable = function(_context = __.variable_context, _get_name = __.variable_name_get, _set_name = __.variable_name_set) {
			__.variable_context  = _context;
			__.variable_name_get = _get_name;
			__.variable_name_set = _set_name;
			return self;
		};
		
		// = PRIVATE ===============
		with (__) {
			static __adjust			   = function() {
				if (__.callback_adjust != undefined) {
					__.callback_adjust(__.callback_adjust_data);	
				}
			};
			static __get_slider_left   = function(_apply_padding = true) {
				return (size_get_width() * (1 - __.slider_width_ratio)) + (__.slider_padding_x * _apply_padding);
			};
			static __get_slider_right  = function(_apply_padding = true) {
				return (get_right() - (__.slider_padding_x * _apply_padding));
			};
			static __get_slider_top    = function() {
				return position_get_center_v() - (__.slider_height * 0.5);
			};
			static __get_slider_bottom = function() {
				return __get_slider_top() + __.slider_height;
			};
			static __get_knob_x		   = function() {
				
				var _value = __get_value();
					_value ??= 0;
					
				return iceberg.math.remap(
					__.value_min, 
					__.value_max, 
					__get_slider_left(true),
					__get_slider_right(true),
					_value
				);
			};
			static __get_knob_y		   = function() {
				return __get_slider_top() + (__.slider_height * 0.5);
			};
			static __get_label_x	   = function(_apply_padding = true) {
				return get_left() + (__.label_padding_x * _apply_padding);
			};
			static __get_label_y	   = function() {
				return position_get_center_v() - (string_height("A") * 0.5);
			};
			static __get_value		   = function() {
				if (__.variable_name_get != "" && __.variable_context != undefined) {
					var _variable = __.variable_context[$ __.variable_name_get];
					if (is_method(_variable)) {
						var _method = method(__.variable_context, _variable);
						return _method();
					}
					return _variable;
				}
				return undefined;
			};
			static __set_value		   = function(_value) {
				if (__.variable_name_set != "" && __.variable_context != undefined) {
					var _variable = __.variable_context[$ __.variable_name_set];
					if (is_method(_variable)) {
						var _method = method(__.variable_context, _variable);
						_method(_value);
					}
					else {
						__.variable_context[$ __.variable_name_set] = _value;	
					}
				}
			};
									   
			slider_width_ratio		   = _config[$ "slider_width_ratio"		] ?? 0.3;
			slider_height			   = _config[$ "slider_height"			] ?? 2;
			slider_padding_x		   = _config[$ "slider_padding_x"		] ?? 10;
			slider_color_hover		   = _config[$ "slider_color_hover"		] ?? c_gray;
			slider_color_no_hover	   = _config[$ "slider_color"			] ?? c_dkgray;
			slider_knob_radius		   = _config[$ "slider_knob_radius"		] ?? 6;
			slider_knob_color_hover	   = _config[$ "slider_knob_color_hover"] ?? c_white;
			slider_knob_color_no_hover = _config[$ "slider_knob_color"		] ?? c_gray;
			label					   = _config[$ "label"					] ?? "";
			label_color_hover		   = _config[$ "label_color_hover"		] ?? c_white;
			label_color_no_hover	   = _config[$ "label_color"			] ?? c_dkgray;
			label_padding_x			   = _config[$ "label_padding_x"		] ?? slider_padding_x;
			variable_context		   = _config[$ "variable_context"		] ?? undefined;
			variable_name_get		   = _config[$ "variable_name_get"		] ?? "";
			variable_name_set		   = _config[$ "variable_name_set"		] ?? variable_name_get;
			value_min				   = _config[$ "value_min"				] ?? 0;
			value_max				   = _config[$ "value_max"				] ?? 1;
			value_adjust			   = _config[$ "value_adjust"			] ?? 0.01;
			callback_adjust			   = _config[$ "callback_adjust"		] ?? undefined;
			callback_adjust_data	   = _config[$ "callback_adjust_data"	] ?? undefined;
			
			////////////////////////
			
			slider_color	  = slider_color_no_hover;
			slider_knob_color = slider_knob_color_no_hover;
			label_color		  = label_color_no_hover;
			height			  = string_height("A");
		};
		
		// = EVENTS ================
		on_initialize (function() {
			size_set_height(__.height);
		});
		on_render	  (function() {
			
			// var label & value
			var _text   = __.label;
			var _value  = __get_value();
			if (_value != undefined) {
				_text  += string_format(_value, 1, 2);	
			}
			
			draw_text_color(
				__get_label_x(),
				__get_label_y(),
				 _text,
				__.label_color,
				__.label_color,
				__.label_color,
				__.label_color,
				1.0,
			);
			
			// slider bar
			draw_rectangle_color(
				__get_slider_left(true),
				__get_slider_top(),
				__get_slider_right(true),
				__get_slider_bottom(),
				__.slider_color,
				__.slider_color,
				__.slider_color,
				__.slider_color,
				false,
			);
			
			// slider knob
			draw_circle_color(
				__get_knob_x(),
				__get_knob_y(),
				__.slider_knob_radius,
				__.slider_knob_color,
				__.slider_knob_color,
				false,
			);
		});
		on_hover_start(function() {
			__.slider_color		 = __.slider_color_hover;
			__.slider_knob_color = __.slider_knob_color_hover;
			__.label_color		 = __.label_color_hover;
		});
		on_hover_stop (function() {
			__.slider_color		 = __.slider_color_no_hover;
			__.slider_knob_color = __.slider_knob_color_no_hover;
			__.label_color		 = __.label_color_no_hover;
		});
	};
	
	