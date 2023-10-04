
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   __  __   ______  ______   __    __   ______   ______  ______    //
	// /\  __ \ /\ \/\ \ /\__  _\/\  __ \ /\ "-./  \ /\  __ \ /\__  _\/\  __ \   //
	// \ \  __ \\ \ \_\ \\/_/\ \/\ \ \/\ \\ \ \-./\ \\ \  __ \\/_/\ \/\ \  __ \  //
	//  \ \_\ \_\\ \_____\  \ \_\ \ \_____\\ \_\ \ \_\\ \_\ \_\  \ \_\ \ \_\ \_\ //
	//   \/_/\/_/ \/_____/   \/_/  \/_____/ \/_/  \/_/ \/_/\/_/   \/_/  \/_/\/_/ //
	//                                                                           //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function IB_CellularAutomata(_config = {}) : IB_Base(_config) constructor {
				
		// original code written by: SamSpadeGameDev
		// https://www.youtube.com/watch?v=PJUFwqs1qMg
		// converted to iceberg conventions by gentoo
		
		static cell_is_empty	 = function(_i, _j) {
			return __.map[_i][_j] == false;
		};
		static cell_is_filled	 = function(_i, _j) {
			return __.map[_i][_j] == true;
		};
		static draw				 = function(_x, _y, _cell_size, _fill_color = c_white) {
			for (var _i = 0; _i < __.width; _i++) {
				for (var _j = 0; _j < __.height; _j++) {
					if (__.map[_i][_j]) {
						var _x1 = _x  + (_i * _cell_size);
						var _y1 = _y  + (_j * _cell_size);
						var _x2 = _x1 + _cell_size;
						var _y2 = _y1 + _cell_size;
						draw_rectangle_color(
							_x1, 
							_y1,
							_x2, 
							_y2,
							_fill_color,
							_fill_color,
							_fill_color,
							_fill_color,
							 false,
						);
					}
				};
			};
		};
		static generate			 = function(_spawn_chance = __.spawn_chance) {
			__.map = [];
			for (var _i = __.width - 1; _i >= 0; _i--) {
				for (var _j = __.height - 1; _j >= 0; _j--) {
					__.map[_i][_j] = (random(1) <= _spawn_chance);
				};
			};
			return __.map;
		};
		static iterate			 = function(_iterations = __.iterations) {
			repeat (_iterations) {
				
				// create new map as to not override previous map values
				var _new_map = [];
				
				// create next generation of cells
				for (var _i = 0; _i < __.width; _i++) {
					for (var _j = 0; _j < __.height; _j++) {
						
						// get neighbors count
						var _count = 0;
						for (var _i_offset = -1; _i_offset < 2; _i_offset++) {
							for (var _j_offset = -1; _j_offset < 2; _j_offset++) {
								
								var _i_diff = _i + _i_offset;
								var _j_diff = _j + _j_offset;
								
								// check for out-of-bounds
								if (_i_diff < 0
								||	_j_diff < 0
								||	_i_diff >= __.width
								||	_j_diff >= __.height
								) {
									_count++;	
								}
								else if (_i_diff == 0 && _j_diff == 0) {
									continue;	
								}
								else if (__.map[_i_diff][_j_diff]) {
									_count++;	
								}
							};
						};
						
						// apply rules for changing cells
						if (__.map[_i][_j]) {
							_new_map[_i][_j] = (_count > __.limit_create);	
						}
						else {
							_new_map[_i][_j] = (_count > __.limit_destroy);	
						}
					};
				};
				
				// replace old map with new map
				__.map = _new_map;
			};
			return self;
		};
		static size_get_height		 = function() {
			return __.height;
		};
		static get_limit_create  = function() {
			return __.limit_create;
		};
		static get_limit_destroy = function() {
			return __.limit_destroy;
		};
		static get_map_array	 = function() {
			return __.map;	
		};
		static get_spawn_chance	 = function() {
			return __.spawn_chance;	
		};
		static size_get_width		 = function() {
			return __.width;
		};
		static set_limit_create	 = function(_limit_create) {
			__.limit_create = _limit_create;
			return self;
		};
		static set_limit_destroy = function(_limit_destroy) {
			__.limit_destroy = _limit_destroy;
			return self;
		};
		static set_spawn_chance	 = function(_spawn_chance) {
			__.spawn_chance = _spawn_chance;
			return self;
		};
		
		// = PRIVATE ===============
		with (__) {
			limit_create  = _config[$ "limit_create" ] ?? 5; // counts neighbors (max: 8)
			limit_destroy = _config[$ "limit_destroy"] ?? 5; // counts neighbors (max: 8)
			iterations	  = _config[$ "iterations"	 ] ?? 6;
			spawn_chance  = _config[$ "spawn_chance" ] ?? 0.66;
			width		  = _config[$ "width"		 ] ?? 150;
			height		  = _config[$ "height"		 ] ?? 110;
			map			  =  [];
		};
		
		// = EVENTS ================
		on_initialize(function() {
			generate();
		});
	};
	
	