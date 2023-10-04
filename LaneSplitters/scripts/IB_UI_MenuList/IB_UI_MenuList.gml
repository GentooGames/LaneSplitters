
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  __       __   ______   ______  //
	// /\ \     /\ \ /\  ___\ /\__  _\ //
	// \ \ \____\ \ \\ \___  \\/_/\ \/ //
	//  \ \_____\\ \_\\/\_____\  \ \_\ //
	//   \/_____/ \/_/ \/_____/   \/_/ //
	//								   //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function IB_UI_MenuList(_config = {}) : IB_Entity(_config) constructor {
		
		var _self = self;
		
		// = PUBLIC ====================
		static cursor_move_down		= function() {
			if (__.cursor.wrap_index) {
				var _index = iceberg.math.wrap(
					__.cursor.index + 1,
					0,
					item_get_count() - 1
				);
			}
			else {
				var _index = clamp(
					__.cursor.index + 1,
					0,
					item_get_count() - 1
				);
			}
			cursor_set_index(_index);
			return self;
		};
		static cursor_move_up		= function() {
			if (__.cursor.wrap_index) {
				var _index = iceberg.math.wrap(
					__.cursor.index - 1,
					0,
					item_get_count() - 1
				);
			}
			else {
				var _index = clamp(
					__.cursor.index - 1,
					0,
					item_get_count() - 1
				);
			}
			cursor_set_index(_index);
			return self;
		};
		static cursor_select		= function() {
			if (item_get_count() > 0) {
				var _index	= __.cursor.index;
				var _option = __.items.entries[_index];
					_option.select();
			}
			return self;
		};
		static cursor_set_index		= function(_index) {
			
			// stop hover on previous
			var _item  = item_get();
			if (_item != undefined) {
				_item.hover_stop();
			}
			
			// update cursor index
			__.cursor.index = _index;
			
			// start hover on current
			var _item  = item_get();
			if (_item != undefined) {
				_item.hover_start();
			}
			
			return self;
		};
		static cursor_snap_position = function() {
			__cursor_snap_y();	
		};
		static cursor_get_index		= function() {
			return __.cursor.index;	
		};
		static cursor_get_item		= function() {
			return __.items.entries[__.cursor.index];
		};
		static cursor_get_visible	= function() {
			return __.cursor.visible;
		};
		static cursor_set_visible	= function(_visible) {
			__.cursor.visible = _visible;
			return self;
		};
		static item_get				= function(_index = __.cursor.index) {
			if (item_get_count() == 0) {
				return undefined;	
			}
			return __.items.entries[_index];
		};
		static item_get_all			= function() {
			return __.items.entries;
		};
		static item_get_count		= function() {
			return array_length(__.items.entries);
		};
		static item_get_visible		= function() {
			return __.items.visible;	
		};
		static item_new				= function(_item_class, _item_config = {}, _index = item_get_count()) {
			
			_item_config[$ "width"] ??= size_get_width ();
			_item_config[$ "x"	  ] ??= position_get_x();
			_item_config[$ "scale"]   = __.items.scale;
			_item_config[$ "index"]   = _index;
			
			// y position is set in the update method for 
			// dynamic heights and dynamic entries list
			
			var _item = new _item_class(_item_config).initialize();
			array_insert(__.items.entries, _index, _item);

			return _item;
		};
		static item_clear_all		= function() {
			iceberg.array.for_each(function(_item) {
				_item.cleanup();
			});	
			__.items.entries = array_create(0);	
			return self;
		};
		static item_set_visible		= function(_visible) {
			__.items.visible = _visible;
			return self;
		};
		
		// = PRIVATE ===================
		with (__) {
			static __cursor_get_y  = function(_index) {
				if (item_get_count() > 0) {
					var _item  = __.items.entries[_index];
					if (_item != undefined) {
						return _item.position_get_y();
					}
				}
				return undefined;
			};
			static __cursor_lerp_y = function() {
				if (__.cursor.y_target != undefined) {
					__.cursor.y = lerp(__.cursor.y, __.cursor.y_target, __.cursor.y_speed);
				}
			};
			static __cursor_snap_y = function() {
				__.cursor.y = __.cursor.y_target;
			};
			static __cursor_update = function() {
				
				// update cursor position
				__.cursor.y_target = __cursor_get_y(__.cursor.index);
				
				if ( __.cursor.y != undefined) {
					 __cursor_lerp_y();
				}
				else __cursor_snap_y();
				
				// update cursor height
				var _item  = item_get();
				if (_item != undefined) {
					__.cursor.height = _item.size_get_height();
				}
			};
			static __cursor_render = function() {
				if (__.cursor.y != undefined) {
					draw_rectangle(
						0, 
						__.cursor.y,
						size_get_width() - 1, 
						__.cursor.y + __.cursor.height,
						true
					);
				}
			};
			static __items_update  = function() {
				
				var _y_center	= position_get_y() + size_get_height() * 0.5;
				var _height_sum = 0;
				
				// calculate block sum height
				for (var _i = 0, _len = item_get_count(); _i < _len; _i++) {
					var _item	 = __.items.entries[_i];
					var _height  = _item.size_get_height();
					_height_sum += _height;
				};
				
				// set y position and update
				var _height_index = 0;
				for (var _i = 0; _i < _len; _i++) {
					var _item	= __.items.entries[_i];
					var _height = _item.size_get_height();
					
					_item.position_set_y(_y_center - (_height_sum * 0.5) + _height_index);
					_item.update();
					
					_height_index += _height;
				};
			};
			static __items_render  = function() {
				iceberg.array.for_each(
					__.items.entries, 
					function(_item) {
						_item.render();
					}
				);				
			};
			
			items  = {
				entries: array_create(0),
				scale:   _config[$ "items_scale"  ] ?? 1,
				space:   _config[$ "items_space"  ] ?? 25,
				visible: _config[$ "items_visible"] ?? true,
			};
			cursor = {
				index:		_config[$ "cursor_index"	 ] ?? 0,												
				visible:	_config[$ "cursor_visible"	 ] ?? true,
				wrap_index: _config[$ "cursor_wrap_index"] ?? true,
				
				height:		string_height("A"), // should remove this, and have cursor 
												// lerp to height of target item
				
				y:			undefined,
				y_target:	undefined,
				y_speed:	0.25,
			};
		};
		
		// = EVENTS ====================
		on_activate(function() {
			// trigger on_hover event
			cursor_set_index(__.cursor.index);
		});
		on_update  (function() {
			__items_update();
			__cursor_update();
		});
		on_render  (function() {
			if (__.items.visible ) __items_render();
			if (__.cursor.visible) __cursor_render();
		});
		on_cleanup (function() {
			iceberg.array.for_each(
				__.items.entries, 
				function(_item) {
					_item.cleanup();
				}
			);
		});
	};
	
	