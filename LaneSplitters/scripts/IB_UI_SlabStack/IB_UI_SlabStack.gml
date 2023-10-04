
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   __       ______   ______    //
	// /\  ___\ /\ \     /\  __ \ /\  == \   //
	// \ \___  \\ \ \____\ \  __ \\ \  __<   //
	//  \/\_____\\ \_____\\ \_\ \_\\ \_____\ //
	//   \/_____/ \/_____/ \/_/\/_/ \/_____/ //
	//                                       //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function IB_UI_SlabStack(_config = {}) : IB_Entity(_config) constructor {
		
		var _self = self;
		
		// public
		static new_slab		   = function(_text, _callback, _config = {}) {
			
			var _index = __.slabs.get_size();
			
			_config[$ "index"	]	= _index;
			_config[$ "text"	]	= _text;
			_config[$ "callback"]	= _callback;
			_config[$ "x"		] ??= position_get_x();
			
			var _slab = new IB_UI_Slab(_config).initialize();
			__.slabs.set(_index, _slab);
			
			return _slab;
		};
		static on_index_change = function(_callback, _data = undefined) {
			array_push(__.on_index_change_callbacks, {
				callback: _callback, 
				data:	  _data,
			});
			return self;
		};
		static on_select	   = function(_callback, _data = undefined) {
			array_push(__.on_select_callbacks, {
				callback: _callback,
				data:	  _data,
			});
			return self;
		};
		static select_current  = function() {
			var _slab = __.slabs.get(__.index);
			_slab.select();
			__on_select();
		};
		static set_index	   = function(_index) {
			if (__index_changed()) {
				__on_index_change();
			}
			__.index_previous = __.index;
			__.index		  = _index;
			return self;
		};
		
		// private
		with (__) {
			static __index_changed	 = function() {
				return __.index != __.index_previous;
			};
			static __move_index_down = function() {
				var _index = iceberg.math.wrap(
					__.index + 1,
					0,
					__.slabs.get_size() - 1,
				);
				set_index(_index);
			};
			static __move_index_up   = function() {
				var _index = iceberg.math.wrap(
					__.index - 1,
					0,
					__.slabs.get_size() - 1,
				);
				set_index(_index);
			};
			static __on_index_change = function() {
				iceberg.array.for_each(__.on_index_change_callbacks, function(_callback) {
					_callback.callback(_callback.data);
				});
			};
			static __on_select		 = function() {
				iceberg.array.for_each(__.on_select_callbacks, function(_callback) {
					_callback.callback(_callback.data);
				});
			};
			
			indentation_per			  = _config[$ "indentation_per"   ] ?? 0;
			select_indentation		  = _config[$ "select_indentation"] ?? 20;
			select_color			  = _config[$ "select_color"	  ] ?? c_white;
			unselect_color			  = _config[$ "unselect_color"	  ] ?? c_white;
			y_space					  = _config[$ "y_space"			  ] ?? 10;
			index					  = -1;
			index_previous			  =  index;
			on_index_change_callbacks = [];
			on_select_callbacks		  = [];
			slabs					  = new IB_Collection_Struct();
		};
		
		// events
		on_initialize(function() {
			set_index(0);
		});
		on_activate  (function() {
			set_index(0);
		});
		on_update	 (function() {
			__.slabs.for_each(function(_slab) {
				_slab.update();
			});
			
			// player button interactions
			for (var _i = 0, _len = objc_game.player_get_count(); _i < _len; _i++) {
				var _player = objc_game.player_get(_i);	
					
				if (_player.input_down_pressed	()) __move_index_down();
				if (_player.input_up_pressed	()) __move_index_up();
				if (_player.input_select_pressed()
				||  _player.input_start_pressed ()
				) {
					select_current();
				}
			};
		});
		on_render_gui(function() {
			draw_set_valign(fa_center);
			var _y	   = position_get_y();
			var _count = __.slabs.get_size();
			
			for (var _i = 0; _i < _count; _i++) {
				var _slab		 = __.slabs.get_by_index(_i);
				var _indentation = __.indentation_per * _i;
				var _color		 = __.unselect_color;
				if (_i == __.index) _indentation += __.select_indentation;
				if (_i == __.index) _color		  = __.select_color;
				
				var _x = position_get_x();
				_slab.set_x_lerp(_x + _indentation);
				_slab.position_set_y(_y);
				_slab.color_set(_color);
				_slab.render_gui();
									
				_y += _slab.size_get_height() + __.y_space;
			};	
			draw_set_valign(fa_top);
		});
	};
	function IB_UI_Slab(_config = {}) : IB_Entity(_config) constructor {
	
		var _self = self;
		
		// public
		static select	  = function() {
			__execute_callback();
		};
		static set_x_lerp = function(_x_lerp) {
			__.x_lerp = _x_lerp;
			return self;
		};
		
		// private
		with (__) {
			static __execute_callback = function() {
				if (__.callback != undefined) {
					__.callback();	
				}	
			};
			static __set_stack_index  = function() {
				var _stack = get_owner();
				_stack.set_index(__.index);
			};
			static __mouse_touching   = function() {
				var _mx = device_mouse_x_to_gui(0);
				var _my = device_mouse_y_to_gui(0);
				return intersecting_point(_mx, _my);
			};
			static __mouse_moved	  = function() {
				return iceberg.input.mouse_did_move();
			};
			static __mouse_clicked    = function() {
				return device_mouse_check_button_pressed(0, mb_left);
			};
			static __update_lerp	  = function() {
				position_set_x(lerp(position_get_x(), __.x_lerp, __.lerp_speed));
			};
			
			index		 = _config[$ "index"	   ];
			callback	 = _config[$ "callback"    ] ?? undefined;
			text		 = _config[$ "text"		   ] ?? "";
			text_color	 = _config[$ "text_color"  ] ?? c_white;
			text_scale	 = _config[$ "text_scale"  ] ?? 1;
			text_padding = _config[$ "text_padding"] ?? 0 * text_scale;
			x_lerp		 = _config[$ "x"		   ] ?? _self.position_get_x();
			lerp_speed	 =  0.1;
		};
		
		// events
		on_update	 (function() {
			if (__mouse_touching()) {
			//	if (__mouse_clicked()) select();
			//	if (__mouse_moved()) __set_stack_index();
			}
			__update_lerp();
		});
		on_render_gui(function() {
			
			render_bbox(,false);
			draw_text_transformed_color(
				position_get_x() + __.text_padding,
				position_get_center_v(), 
				__.text, 
				__.text_scale,
				__.text_scale,
				0,
				__.text_color,
				__.text_color,
				__.text_color,
				__.text_color,
				1,
			);
			
		});
	};
	