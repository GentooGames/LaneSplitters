
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______  ______  __  __   ______  //
	// /\__  _\/\  ___\/\_\_\_\ /\__  _\ //
	// \/_/\ \/\ \  __\\/_/\_\/_\/_/\ \/ //
	//    \ \_\ \ \_____\/\_\/\_\  \ \_\ //
	//     \/_/  \/_____/\/_/\/_/   \/_/ //
	//                                   //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function IB_UI_MenuListEntry_Text(_config = {}) : IB_UI_MenuListEntry(_config) constructor {
		
		var _self = self;
		
		// = PRIVATE ===============
		with (__) {
			text_color_hover	= _config[$ "text_color_hover"] ?? c_white;
			text_color_no_hover	= _config[$ "text_color"	  ] ?? c_dkgray;
			text_color			=  text_color_no_hover;
			height				=  string_height("A");
		};
		
		// = EVENTS ================
		on_initialize (function() {
			size_set_height(__.height);
		});
		on_render	  (function() {
			draw_set_halign(fa_center);
			draw_set_valign(fa_center);
				draw_text_transformed_color(
					position_get_center_h(),
					position_get_center_v(),
					__.text,
					scale_get_x(),
					scale_get_y(),
					angle_get(),
					__.text_color,
					__.text_color,
					__.text_color,
					__.text_color,
				    alpha_get(),
				);
			draw_set_halign(fa_left);
			draw_set_valign(fa_top );
		});
		on_hover_start(function() {
			__.text_color = __.text_color_hover;
		});
		on_hover_stop (function() {
			__.text_color = __.text_color_no_hover;
		});
	};
	