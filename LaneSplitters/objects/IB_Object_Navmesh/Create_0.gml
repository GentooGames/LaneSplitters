
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  __   __   ______   __   __ __    __   ______   ______   __  __    //
	// /\ "-.\ \ /\  __ \ /\ \ / //\ "-./  \ /\  ___\ /\  ___\ /\ \_\ \   //
	// \ \ \-.  \\ \  __ \\ \ \'/ \ \ \-./\ \\ \  __\ \ \___  \\ \  __ \  //
	//  \ \_\\"\_\\ \_\ \_\\ \__|  \ \_\ \ \_\\ \_____\\/\_____\\ \_\ \_\ //
	//   \/_/ \/_/ \/_/\/_/ \/_/    \/_/  \/_/ \/_____/ \/_____/ \/_/\/_/ //
	//                                                                    //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	// IB_Object_Navmesh.create //
	event_inherited();
	var _self = self;
	var _data = self[$ "data"] ?? self;
	
	// public
	get_mp_grid	  = function() {
		return __.mp_grid;	
	};
	add_instances = function(_object_index, _precise = false) {
		mp_grid_add_instances(__.mp_grid, _object_index, _precise);
		return self;
	};
	
	// private 
	with (__) {
		generate	=  method(_self, function() {
			if (__.mp_grid != undefined) mp_grid_destroy(__.mp_grid);	
			
			var _hcells = (sprite_width  div __.cell_width );
			var _vcells = (sprite_height div __.cell_height);
			
			__.mp_grid = mp_grid_create(x, y, _hcells, _vcells,
				__.cell_width, __.cell_height);
		});
		render		=  method(_self, function() {
			if (__.mp_grid != undefined) {
				if (__.alpha != 1) draw_set_alpha(__.alpha);	
			
				mp_grid_draw(__.mp_grid);
			
				if (__.alpha != 1) draw_set_alpha(1);	
			}
		});
		cell_width	= _data[$ "cell_width" ] ?? 8;
		cell_height = _data[$ "cell_height"] ?? 8;
		alpha		= _data[$ "alpha"	   ] ?? 0.1;
		mp_grid		=  undefined;
	};
	
	// events
	on_initialize(function() {
		__.generate();
	});
	on_render	 (function() {
		__.render();
	});
	on_cleanup	 (function() {
		mp_grid_destroy(__.mp_grid);	
	});
	