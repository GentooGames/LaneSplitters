
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   __  __   ______   ______  ______   ______   ______    //
	// /\  ___\ /\ \/\ \ /\  == \ /\  ___\/\  __ \ /\  ___\ /\  ___\   //
	// \ \___  \\ \ \_\ \\ \  __< \ \  __\\ \  __ \\ \ \____\ \  __\   //
	//  \/\_____\\ \_____\\ \_\ \_\\ \_\   \ \_\ \_\\ \_____\\ \_____\ //
	//   \/_____/ \/_____/ \/_/ /_/ \/_/    \/_/\/_/ \/_____/ \/_____/ //
	//                                                                 //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function IB_Surface(_config = {}) : IB_Base(_config) constructor {
		
		// = PUBLIC ================
		static clear	   = function(_color = c_black, _alpha = 0.0) {
			draw_clear_alpha(_color, _alpha);
			return self;
		};
		static draw		   = function(_x, _y) {
			draw_surface(__.surface, _x, _y);
			return self;
		};
		static draw_ext	   = function(_x, _y, _xscale = 1, _yscale = _xscale, _rot = 0, _color = c_white, _alpha = 1.0) {
			draw_surface_ext(__.surface, _x, _y, _xscale, _yscale, _rot, _color, _alpha);	
			return self;
		};
		static ensure	   = function(_width = __.width, _height = __.height) {
			if (!surface_exists(__.surface)) {
				__.surface = surface_create(_width, _height);		
			}
			return self;
		};
		static exists	   = function() {
			return surface_exists(__.surface);	
		};
		static focus	   = function() {
			surface_set_target(__.surface);
			return self;
		};
		static get_height  = function() {
			return __.height;	
		};
		static get_surface = function() {
			return __.surface;
		};
		static get_width   = function() {
			return __.width;	
		};
		static is_focused  = function() {
			return surface_get_target() == __.surface;	
		};
		static resize	   = function(_width = __.width, _height = __.height) {
			__.width  = _width;
			__.height = _height;
			surface_resize(__.surface, _width, _height);
			return self;
		};
		static set_height  = function(_height) {
			__.height = _height;
			surface_resize(__.surface, __.width, _height);
			return self;
		};
		static set_width   = function(_width) {
			__.width = _width;
			surface_resize(__.surface, _width, __.height);
			return self;
		};
		static unfocus	   = function() {
			if (is_focused()) {
				surface_reset_target();	
			}
			return self;
		};
		
		// = PRIVATE ===============
		with (__) {
			width		   = _config[$ "width" ] ?? 1;
			height		   = _config[$ "height"] ?? 1;
			surface		   =  surface_create(width, height);
			window_resized =  false; // used for surface preservation on window adjustments
		};
		
		// = EVENTS ================
		on_cleanup(function() {
			if (__.surface != undefined
			&&  surface_exists(__.surface)
			){ 
				surface_free(__.surface);
				__.surface = undefined;
			}
		});
	};
	