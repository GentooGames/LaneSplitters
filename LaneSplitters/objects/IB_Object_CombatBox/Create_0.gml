
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   ______   __    __   ______   ______   __  __    //
	// /\  ___\ /\  __ \ /\ "-./  \ /\  == \ /\  __ \ /\_\_\_\   //
	// \ \ \____\ \ \/\ \\ \ \-./\ \\ \  __< \ \ \/\ \\/_/\_\/_  //
	//  \ \_____\\ \_____\\ \_\ \ \_\\ \_____\\ \_____\ /\_\/\_\ //
	//   \/_____/ \/_____/ \/_/  \/_/ \/_____/ \/_____/ \/_/\/_/ //
	//                                                           //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	// IB_Object_CombatBox.create //	
	event_inherited();
	var _self = self;
	var _data = self[$ "data"] ?? self;
	
	////////////////////////////

	#region sprite ............|
	
		// private
		with (__) {
			sprite_default = IB_Sprite_Pixel_2x2_White_Precise;	
		};
	
	#endregion
	#region size ..............|
	
		// private
		with (__) {
			size_update = method(_self, function() {
				if (sprite_index == __.sprite_default) {
					
					// stick to owner?
					if (__.stick_to_owner_size) {
						var _width  = __.stick_owner.bbox_right  - __.stick_owner.bbox_left;
						var _height = __.stick_owner.bbox_bottom - __.stick_owner.bbox_top;
					}
					else {
						// get raw base scale
						static _apply_scale = false;
						var _width  = size_get_width (_apply_scale);
						var _height = size_get_height(_apply_scale);
					}
					
					scale_set_x(_width  * 0.5);
					scale_set_y(_height * 0.5);
				}
			});	
		};
		
		// events
		on_update(function() {
			__.size_update();
		});
	
	#endregion
	#region life ..............|
	
		// public
		life_get_base	   = function() {
			return __.life_base;	
		};
		life_get_current   = function() {
			return __.life;
		};
		life_get_progress  = function() {
			if (__.life_base == 0) {
				return 0;	
			}
			return __.life / __.life_base;
		};
		life_set_base	   = function(_life) {
			__.life_base = _life;
			return self;
		};
		life_set_current   = function(_life) {
			__.life = _life;
			return self;
		};
		life_reset_to_base = function() {
			__.life = __.life_base;
			return self;
		};
		
		// private
		with (__) {
			life_tick =  method(_self, function() {
				if (__.life  > 0) __.life--;	
				if (__.life == 0) destroy();	
			});
			life	  = _data[$ "life"] ?? -1;
			life_base =  life;
			
			variable_struct_remove(_self, "life");
		};
		
		// events
		on_update(function() {
			__.life_tick();
		});
	
	#endregion
	#region stick .............|
	
		// public
		stick_owner_get_offset_x		 = function(_apply_facing = true) {
			if (_apply_facing) {
				return __.stick_owner_x_offset * __.stick_owner_facing;
			}	
			return __.stick_owner_x_offset;
		};
		stick_owner_get_offset_y		 = function() {
			return __.stick_owner_y_offset;
		};
		stick_owner_set_offset_x		 = function(_x_offset) {
			__.stick_owner_x_offset = _x_offset;
			__.stick_update_pos();
			return self;
		};
		stick_owner_set_offset_y		 = function(_y_offset) {
			__.stick_owner_y_offset = _y_offset;
			__.stick_update_pos();
			return self;
		};
		stick_owner_set					 = function(_stick_owner) {
			__.stick_owner			= _stick_owner;
			__.stick_owner_x_offset = __.stick_owner_get_x_offset();
			__.stick_owner_y_offset = __.stick_owner_get_y_offset();
			__.stick_update_pos();
			__.size_update();
			return self;
		};
		stick_to_owner_angle_get_active  = function() {
			return __.stick_to_owner_angle;	
		};
		stick_to_owner_angle_set_active  = function(_stick_angle) {
			__.stick_to_owner_angle = _stick_angle;
			return self;
		};
		stick_to_owner_facing_get_active = function() {
			return __.stick_to_owner_facing;
		};
		stick_to_owner_facing_set_active = function(_stick_facing) {
			__.stick_to_owner_facing = _stick_facing;
			return self;
		};
		stick_to_owner_pos_get_active	 = function() {
			return __.stick_to_owner_pos;	
		};
		stick_to_owner_pos_set_active	 = function(_stick_pos) {
			__.stick_to_owner_pos = _stick_pos;
			return self;
		};
			
		// private
		with (__) {
			stick_owner_get_facing	 =  method(_self, function() {
				return sign(__.stick_owner.facing_get());
			});
			stick_owner_get_x_offset =  method(_self, function() {
				return position_get_x() - __.stick_owner.position_get_x();
			});
			stick_owner_get_y_offset =  method(_self, function() {
				return position_get_y() - __.stick_owner.position_get_y();
			});
			stick_update_angle		 =  method(_self, function() {
				if (__.stick_to_owner_angle) {
					image_angle = __.stick_owner.angle_get();
				}
			});
			stick_update_facing		 =  method(_self, function() {
				if (__.stick_to_owner_facing) {
					__.stick_owner_facing = __.stick_owner_get_facing();
				}
			});
			stick_update_pos		 =  method(_self, function() {
				if (__.stick_to_owner_pos) {
					var _x = __.stick_owner.position_get_x() + (__.stick_owner_x_offset * __.stick_owner_facing);
					var _y = __.stick_owner.position_get_y() + (__.stick_owner_y_offset);
					position_set_x(_x); x = _x;
					position_set_y(_y); y = _y;
				}
			});
			stick_owner				 = _data[$ "stick_owner"		  ] ?? _self.get_owner();
			stick_to_owner_angle	 = _data[$ "stick_to_owner_angle" ] ?? true;
			stick_to_owner_facing	 = _data[$ "stick_to_owner_facing"] ?? true;
			stick_to_owner_pos		 = _data[$ "stick_to_owner_pos"   ] ?? true;
			stick_to_owner_size		 = _data[$ "stick_to_owner_size"  ] ?? false;
			stick_owner_x_offset	 =  stick_owner_get_x_offset();
			stick_owner_y_offset	 =  stick_owner_get_y_offset();
			stick_owner_facing		 =  stick_owner_get_facing();
			
			variable_struct_remove(_self, "stick_to_owner_angle" );
			variable_struct_remove(_self, "stick_to_owner_facing");
			variable_struct_remove(_self, "stick_to_owner_pos"	 );
			variable_struct_remove(_self, "stick_to_owner_size"	 );
		};
		
		// events
		on_update(function() {
			__.stick_update_facing();
			__.stick_update_pos();
			__.stick_update_angle();
		});
	
	#endregion
	#region collision .........|
	
		// public
		collision_object_add	= function(_object_index, _on_start_callback = undefined, _on_stop_callback = undefined, _config = {}) {
			if (!__.collision_definitions_map.contains(_object_index)) {
			
				// optional params
				_config[$ "precise"			] ??=  false;
				_config[$ "notme"			] ??=  true;
				_config[$ "ordered"			] ??=  false;
				_config[$ "repetitions_per"	] ??= -1;
				_config[$ "repetitions_max"	] ??= -1;
				_config[$ "repetitions_rate"] ??=  1;
			
				__.collision_definitions_map.set(_object_index, {
					object:	  _object_index,
					current:   ds_list_create(),
					previous:  ds_list_create(),
					size:	   0,
					on_start: _on_start_callback,
					on_stop:  _on_stop_callback,
					config:	  _config,
					control:   {
						collide_started: false,
						collide_stopped: false,
						repetitions_per: 0,	
						repetitions_max: 0,	
						repetitions_i:   0,
					},
				});
			}
			return self;
		};
		collision_object_remove = function(_object_index) {
			var _data  = __.collision_definitions_map.get(_object_index);
			if (_data != undefined) {
				ds_list_destroy(_data.current );
				ds_list_destroy(_data.previous);
				__.collision_definitions_map.remove(_object_index);
			}
			return self;
		};
		collision_objects_clear	= function() {
			__.collision_definitions_map.for_each(function(_data) {
				ds_list_destroy(_data.current );
				ds_list_destroy(_data.previous);
			});
			__.collision_definitions_map.clear();
			return self;
		};
			
		////////////////////////////////////////////////////////////////////////
		//																	  //
		//	a collision filter is a function that determines if the current	  //
		//	collision should be registered. a filter function should return   //
		//	TRUE if the collision should be filtered, and FALSE if the 		  //
		//	collision should still be registered. remember, it is a filtering //
		//	check function, not a collision check function.					  //
		//																	  //
		////////////////////////////////////////////////////////////////////////
		collision_filter_exists = function(_object_index, _filter_name = undefined) {
			var _filters = __.collision_filters.get(_object_index);
			if (_filters	 == undefined) return false;	
			if (_filter_name == undefined) return true;	
			return _filters[$ _filter_name] != undefined;
		};
		collision_filter_get	= function(_object_index, _filter_name = undefined) {
			var _filters = __.collision_filters.get(_object_index);
			if (_filters	 == undefined) return undefined;
			if (_filter_name == undefined) return _filters;
			return _filters[$ _filter_name];
		};
		collision_filter_remove = function(_object_index, _filter_name = undefined) {
			var _filters  = __.collision_filters.get(_object_index);
			if (_filters != undefined) {
				if (_filter_name == undefined) {
					__.collision_filters.remove(_object_index);	
				}
				else variable_struct_remove(_filters, _filter_name);	
			}
			return self;
		};
		collision_filter_set	= function(_object_index, _filter_name = undefined, _filter_function = undefined) {
			
			// if first time setting object_index's filter, create empty struct
			if (!__.collision_filters.contains(_object_index)) {
				 __.collision_filters.set(_object_index, {});
			}
			
			var _filters = __.collision_filters.get(_object_index);
			
			// if filter_name defined, set with specific name index
			if (_filter_name != undefined) {
				_filters[$ _filter_name] = _filter_function;
			}
			
			// if filter_name not defined, then pass to all filters
			else {
				var _names = variable_struct_get_names(_filters);
				for (var _i = 0, _len_i = array_length(_names); _i < _len_i; _i++) {
					_filters[$ _names[_i]] = _filter_function;
				};
			}
			return self;
		};
		collision_filters_clear = function(_object_index) {
			__.collision_filters.set(_object_index, {});
			return self;
		};
	
		// private
		with (__) {
			collision_check_for_stopped	= method(_self, function(_data) {
				
				var _on_collision_stop = _data.on_stop;
				
				// if instance exists in the previous list but not in the 
				// current list, then trigger collision_on_stop callback 
				for (var _i = ds_list_size(_data.previous) - 1; _i >= 0; _i--) {
					var _previous = _data.previous[| _i];
					if (!iceberg.list.contains(_data.current, _data.previous)) {
						if (_on_collision_stop != undefined) {
							_on_collision_stop(self, _previous);	
						}	
					}
				};
			});
			collision_is_filtered		= method(_self, function(_instance) {
				
				if (_instance == undefined || !instance_exists(_instance)) return true;
				
				var _filters  = collision_filter_get(_instance.object_index);
				if (_filters == undefined) return false;
				
				var _names	= variable_struct_get_names(_filters);
				for (var _i = 0, _len_i = array_length(_names); _i < _len_i; _i++) {
					var _filter = _filters[$ _names[_i]];
					if (_filter(self, _instance)) {
						return true;
					}
				};
					
				return false;
			});
			collision_object_get_count	= method(_self, function(_object_index) {
				var _data = __.collision_definitions_map.get(_object_index);
				if (_data == undefined) {
					return 0;	
				}
				return _data.size;
			});
			collision_object_get_list	= method(_self, function(_object_index) {
				var _data = __.collision_definitions_map.get(_object_index);
				if (_data == undefined) {
					return undefined;	
				}
				return _data.current;
			});
			collision_update			= method(_self, function() {
				__.collision_definitions_map.for_each(function(_data) {
					
					var _object				= _data.object;
					var _current			= _data.current;
					var _previous			= _data.previous;
					var _on_collision_start = _data.on_start;
					var _config				= _data.config;
					var _control			= _data.control;
					
					// auto-assume no collision this frame
					_control.collide_started = false;
					
					// update list references & count
					ds_list_copy (_previous, _current);
					ds_list_clear(_current);
					_data.count = instance_place_list(x, y, _object, _current, _config.ordered);
						
					// act on collision instances
					for (var _j = _data.count - 1; _j >= 0; _j--) {
						
						if (!instance_exists(self)) break;
						
						var _instance = _current[|_j];
						if (__.collision_is_filtered(_instance)) continue;
						
						////////////////////////////////////////////////
						
						// check if can execute this iteration
						if ((_control.repetitions_i % _config.repetitions_rate) == 0) {
							
							// check if collision can be registered
							if ((_config.repetitions_per == -1 || _control.repetitions_per < _config.repetitions_per)
							&&	(_config.repetitions_max == -1 || _control.repetitions_max < _config.repetitions_max)
							) {
								// check for on_start callback
								if (_on_collision_start != undefined) {
									_on_collision_start(self, _instance);
								}
								_control.repetitions_per++;
								_control.repetitions_max++;
							}
						}
						_control.collide_started = true;
						_control.collide_stopped = false;
						_control.repetitions_i++;
					};
					
					// if not colliding this frame
					if (!_control.collide_started) {
						 _control.repetitions_per = 0;
						 _control.repetitions_i   = 0;
						
						// check for on_stop callback
						if (!_control.collide_stopped) {
							 _control.collide_stopped = true;	 
							__.collision_check_for_stopped(_data);
						}
					}
				});
			});	
			collision_definitions_map	= new IB_Collection_Struct();
			collision_filters			= new IB_Collection_Struct();
		};
		
		// events
		on_update (function() {
			__.collision_update();
		});
		on_cleanup(function() {
			collision_objects_clear();
		});
	
	#endregion
	