
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   ______   __   _____    //
	// /\  ___\ /\  == \ /\ \ /\  __-.  //
	// \ \ \__ \\ \  __< \ \ \\ \ \/\ \ //
	//  \ \_____\\ \_\ \_\\ \_\\ \____- //
	//   \/_____/ \/_/ /_/ \/_/ \/____/ //
	//                                  //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function IB_Grid(_config = {}) : IB_Base(_config) constructor {
		
		// = PUBLIC ================
		static clear		 = function(_value = undefined) {
			ds_grid_clear(__.grid, _value);
			return self;
		};
		static get_cell_size = function() {
			return __.cell_size;	
		};
		static get_grid		 = function() {
			return __.grid;	
		};
		static size_get_height	 = function() {
			return __.height;	
		};
		static get_value	 = function(_i, _j) {
			return __.grid[# _i, _j];
		};
		static size_get_width	 = function() {
			return __.width;	
		};
		static render_grid	 = function(_x, _y, _cell_size = __.cell_size, _line_width = 1, _line_color = c_white) {
			for (var _i = 0, _len_i = __.width; _i <= _len_i; _i++) {
				draw_line_width_color(
					_x + (_i * _cell_size),
					_y,
					_x + (_i * _cell_size),
					_y + (__.height * _cell_size),
					_line_width, 
					_line_color,
					_line_color,
				);
			};
			for (var _j = 0, _len_j = __.height; _j <= _len_j; _j++) {
				draw_line_width_color(
					_x,
					_y + (_j * _cell_size),
					_x + (__.width * _cell_size),
					_y + (_j * _cell_size),
					_line_width, 
					_line_color,
					_line_color,
				);
			};
			return self;
		};
		static resize		 = function(_width = __.width, _height = __.height) {
			__.width  = _width;
			__.height = _height;
			ds_grid_resize(__.grid, _width, _height);
			return self;
		};
		static set_cell_size = function(_cell_size) {
			__.cell_size = _cell_size;
			return self;
		};
		static set_height	 = function(_height) {
			resize(,_height);
			return self;
		};
		static set_value	 = function(_i, _j, _value) {
			__.grid[# _i, _j] = _value;
			return self;
		};
		static size_set_width	 = function(_width) {
			resize(_width);
			return self;
		};
		
		// = PRIVATE ===============
		with (__) {
			cell_size = _config[$ "cell_size"] ?? 16;
			width	  = _config[$ "width"	 ] ?? 1;
			height	  = _config[$ "height"	 ] ?? 1;
			grid	  =  ds_grid_create(width, height);	
		};
		
		// = EVENTS ================
		on_cleanup(function() {
			ds_grid_destroy(__.grid);
			__.grid = undefined;
		});
	};
	