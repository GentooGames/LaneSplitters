
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   __  __   ______  ______  ______   __   __    //
	// /\  == \ /\ \/\ \ /\__  _\/\__  _\/\  __ \ /\ "-.\ \   //
	// \ \  __< \ \ \_\ \\/_/\ \/\/_/\ \/\ \ \/\ \\ \ \-.  \  //
	//  \ \_____\\ \_____\  \ \_\   \ \_\ \ \_____\\ \_\\"\_\ //
	//   \/_____/ \/_____/   \/_/    \/_/  \/_____/ \/_/ \/_/ //
	//                                                        //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function IB_UI_MenuListEntry_Button(_config = {}) : IB_UI_MenuListEntry(_config) constructor {
		
		var _self = self;
		
		// = PRIVATE ===================
		with (__) {
			static __get_button_left   = function(_apply_padding = true) {
				return (size_get_width() * (1 - __.button_width_ratio)) + (__.button_padding_x * _apply_padding);
			};
			static __get_button_right  = function(_apply_padding = true) {
				return (get_right() - (__.button_padding_x * _apply_padding));
			};
			static __get_button_top    = function() {
				return position_get_center_v() - (__.button_height * 0.5);
			};
			static __get_button_bottom = function() {
				return __get_button_top() + __.button_height;
			};
			static __get_button_text_x = function() {
				return (__get_button_right(true) + __get_button_left(true)) * 0.5;
			};
			static __get_button_text_y = function() {
				return __get_label_y();
			};
			static __get_label_x	   = function(_apply_padding = true) {
				return get_left() + (__get_button_left() - get_left()) * 0.5;
			};
			static __get_label_y	   = function() {
				return position_get_center_v();
			};
			
			button_outline_color_hover	  = _config[$ "button_outline_color_hover"] ?? c_white;
			button_outline_color_no_hover = _config[$ "button_outline_color"	  ] ?? c_dkgray;
			button_fill_color_hover		  = _config[$ "button_fill_color_hover"	  ] ?? merge_color(button_outline_color_hover,	  c_black, 0.8);
			button_fill_color_no_hover	  = _config[$ "button_fill_color"		  ] ?? merge_color(button_outline_color_no_hover, c_black, 0.8);
			button_width_ratio			  = _config[$ "button_width_ratio"		  ] ?? 0.6;
			button_height				  = _config[$ "button_height"			  ] ?? string_height("A");
			button_padding_x			  = _config[$ "button_padding_x"		  ] ?? 10;
			button_text					  = _config[$ "button_text"				  ] ?? "button";
			button_text_color_hover		  = _config[$ "button_text_color_hover"	  ] ?? c_white;
			button_text_color_no_hover	  = _config[$ "button_text_color"		  ] ?? c_dkgray;
			label						  = _config[$ "label"					  ] ?? button_text;
			label_color_hover			  = _config[$ "label_color_hover"		  ] ?? button_text_color_hover;
			label_color_no_hover		  = _config[$ "label_color"				  ] ?? button_text_color_no_hover;
			label_padding_x				  = _config[$ "label_padding_x"			  ] ?? button_padding_x;
			
			button_outline_color = button_outline_color_no_hover;
			button_fill_color	 = button_fill_color_no_hover;
			button_text_color	 = button_text_color_no_hover;
			label_color			 = label_color_no_hover;
			height				 = string_height("A") * 2;
		};
		
		// = EVENTS ====================
		on_initialize (function() {
			size_set_height(__.height);
		});
		on_render	  (function() {
			
			draw_set_halign(fa_center);
			draw_set_valign(fa_center);
			
			// label :::::::::::::::::::::::
			draw_text_transformed_color(
				__get_label_x(),
				__get_label_y(),
				__.label,
				scale_get_x(),
				scale_get_y(),
				angle_get(),
				__.label_color,
				__.label_color,
				__.label_color,
				__.label_color,
				alpha_get(),
			);
			
			// button fill :::::::::::::::::
			var _bx1 = __get_button_left();
			var _by1 = __get_button_top();
			var _bx2 = __get_button_right();
			var _by2 = __get_button_bottom();
			
			draw_rectangle_color(_bx1, _by1, _bx2, _by2,
				__.button_fill_color,
				__.button_fill_color,
				__.button_fill_color,
				__.button_fill_color,
				false
			);
			
			// button outline ::::::::::::::
			draw_rectangle_color(_bx1, _by1, _bx2, _by2,
				__.button_outline_color,
				__.button_outline_color,
				__.button_outline_color,
				__.button_outline_color,
				true
			);
			
			// button text :::::::::::::::::
			draw_text_transformed_color(
				__get_button_text_x(),
				__get_button_text_y(),
				__.button_text,
				scale_get_x(),
				scale_get_y(),
				angle_get(),
				__.button_text_color,
				__.button_text_color,
				__.button_text_color,
				__.button_text_color,
				alpha_get(),
			);
				
			draw_set_halign(fa_left);
			draw_set_valign(fa_top );
		});
		on_hover_start(function() {
			__.label_color			= __.label_color_hover;
			__.button_outline_color = __.button_outline_color_hover;
			__.button_fill_color	= __.button_fill_color_hover;
			__.button_text_color	= __.button_text_color_hover;
		});
		on_hover_stop (function() {
			__.label_color			= __.label_color_no_hover;
			__.button_outline_color = __.button_outline_color_no_hover;
			__.button_fill_color	= __.button_fill_color_no_hover;
			__.button_text_color	= __.button_text_color_no_hover;
		});
	};
	
	