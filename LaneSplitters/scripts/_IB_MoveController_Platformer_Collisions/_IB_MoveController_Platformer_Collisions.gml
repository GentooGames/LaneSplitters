
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   ______   __       __       __   ______   __   ______   __   __   ______    //
	// /\  ___\ /\  __ \ /\ \     /\ \     /\ \ /\  ___\ /\ \ /\  __ \ /\ "-.\ \ /\  ___\   //
	// \ \ \____\ \ \/\ \\ \ \____\ \ \____\ \ \\ \___  \\ \ \\ \ \/\ \\ \ \-.  \\ \___  \  //
	//  \ \_____\\ \_____\\ \_____\\ \_____\\ \_\\/\_____\\ \_\\ \_____\\ \_\\"\_\\/\_____\ //
	//   \/_____/ \/_____/ \/_____/ \/_____/ \/_/ \/_____/ \/_/ \/_____/ \/_/ \/_/ \/_____/ //
	//                                                                                      //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function _IB_MoveController_Platformer_Collisions(_dir, _config = {}) : IB_Base(_config) constructor {

		var _self = self;

		// = PUBLIC ====================
		static did_collide			   = function(_object_index) {
			return __.collided.contains(_object_index);
		};
		static get_collisions		   = function() {
			return __.collisions;
		};
		static get_instance_colliding  = function(_object_index, _offset = 0, _offset_perpendicular = 0, _precise = __.precise, _notme = __.notme, _ds_list = undefined, _list_ordered = false) {
			
			var _self = self;
			
			// calculate directional bounds
			switch (__.dir) {
				case "left":   {
					var _offset_left   = -_offset; 
					var _offset_top    =  _offset_perpendicular; 
					var _offset_right  = -_offset;
					var _offset_bottom =  _offset_perpendicular; 
					break;
				}
				case "right":  {
					var _offset_left   = _offset; 
					var _offset_top    = _offset_perpendicular; 
					var _offset_right  = _offset;
					var _offset_bottom = _offset_perpendicular; 
					break;
				}
				case "top":	   {
					var _offset_left   =  _offset_perpendicular; 
					var _offset_top    = -_offset; 
					var _offset_right  =  _offset_perpendicular;
					var _offset_bottom = -_offset; 
					break;
				}
				case "bottom": {
					var _offset_left   = _offset_perpendicular; 
					var _offset_top    = _offset; 
					var _offset_right  = _offset_perpendicular;
					var _offset_bottom = _offset; 
					break;
				}
			};
			
			// do collision
			with (__.instance) { 
				if (_ds_list == undefined) {
					return collision_rectangle(
						_self.__.bbox.x1 + _offset_left, 
						_self.__.bbox.y1 + _offset_top, 
						_self.__.bbox.x2 + _offset_right, 
						_self.__.bbox.y2 + _offset_bottom, 
						_object_index, 
						_precise, 
						_notme, 
					);
				}
				else {
					return collision_rectangle_list(
						_self.__.bbox.x1 + _offset_left, 
						_self.__.bbox.y1 + _offset_top, 
						_self.__.bbox.x2 + _offset_right, 
						_self.__.bbox.y2 + _offset_bottom, 
						_object_index, 
						_precise, 
						_notme, 
						_ds_list,
						_list_ordered,
					);
				}
			};
			return noone;
		};
		static get_instances_collided  = function(_object_index = "") {
			return __.collided.get(_object_index);	
		};
		static is_colliding			   = function(_object_index, _offset = 0, _offset_perpendicular = 0, _precise = __.precise, _notme = __.notme) {
			return get_instance_colliding(_object_index, _offset, _offset_perpendicular, _precise, _notme) != noone;
		};
		
		// = PRIVATE ===================
		with (__) {
			static __clear_current	   = function() {
				__.current    = {};
				__.collisions = array_create(0);
				__.collided.clear();
				ds_list_clear(__.list);
				return self;
			};
			static __sort_instance	   = function(_instance) {
				
				array_push(__.collisions, _instance);
				__.collided.add(_instance.object_index, _instance);
			
				if (object_is_ancestor(_instance.object_index, IB_Object_Platformer_Solid)) {
					__.collided.add(IB_Object_Platformer_Solid, _instance);	
				}
				if (object_is_ancestor(_instance.object_index, IB_Object_Platformer_Pass )) {
					__.collided.add(IB_Object_Platformer_Pass, _instance);	
				}
			
				// execute callback on collision?
					__.current [$ _instance.id] = _instance;
				if (__.previous[$ _instance.id] == undefined) {
					__.previous[$ _instance.id] = _instance;
					
					// callbacks 
					if (__.dir == "left" || __.dir == "right" ) {
						__.owner.__collision_on_collide_horiz_callbacks(_instance);
					}
					if (__.dir == "top"  || __.dir == "bottom") {
						__.owner.__collision_on_collide_vert_callbacks(_instance);
					}
				}
			
				return self;
			};
			static __update_bounds	   = function() {
				switch (__.dir) {
					case "left":   {
						__.bbox.x1 = __.instance.bbox_left + __.padding;
						__.bbox.x2 = __.instance.bbox_left - __.distance;
						__.bbox.y1 = __.instance.bbox_top;
						__.bbox.y2 = __.instance.bbox_bottom;
						break;
					}
					case "right":  {
						__.bbox.x1 = __.instance.bbox_right - __.padding;
						__.bbox.x2 = __.instance.bbox_right + __.distance;
						__.bbox.y1 = __.instance.bbox_top;
						__.bbox.y2 = __.instance.bbox_bottom;
						break;
					}
					case "top":    {
						__.bbox.x1 = __.instance.bbox_left;
						__.bbox.x2 = __.instance.bbox_right;
						__.bbox.y1 = __.instance.bbox_top + __.padding;
						__.bbox.y2 = __.instance.bbox_top - __.distance;
						break;
					}
					case "bottom": {
						__.bbox.x1 = __.instance.bbox_left;
						__.bbox.x2 = __.instance.bbox_right;
						__.bbox.y1 = __.instance.bbox_bottom - __.padding;
						__.bbox.y2 = __.instance.bbox_bottom + __.distance;
						break;
					}
				};
				return self;
			};
			static __update_collisions = function() {
				
				var _self = self;
				
				__clear_current();
				
				// do collision ============
				with (__.instance) { 
					var _count = collision_rectangle_list(
						_self.__.bbox.x1, 
						_self.__.bbox.y1, 
						_self.__.bbox.x2, 
						_self.__.bbox.y2, 
						 IB_Object_Platformer,
						_self.__.precise, 
						_self.__.notme, 
						_self.__.list, 
						_self.__.ordered,
					); 
				};
				
				// handle instance =========
				for (var _j = 0; _j < _count; _j++) {
					var _instance = __.list[|_j];
					__sort_instance(_instance);
				};
				return self;
			};
			static __update_previous   = function() {
				
				// if instance is in previous but not in current
				// then remove instance from previous struct.
				var _instance_ids = variable_struct_get_names(__.previous);
				for (var _i = 0, _len_i = array_length(_instance_ids); _i < _len_i; _i++) {
					var _instance_id = _instance_ids[_i];
					if (__.current[$ _instance_id] == undefined) {
						variable_struct_remove(__.previous, _instance_id);	
					}
				};
			};
			
			instance   = _config[$ "instance"] ?? owner.__.owner;
			bbox	   = { x1: 0, y1: 0, x2: 0, y2: 0 };
			collided   = new IB_Collection_Set();
			current	   = {};
			previous   = {};
			collisions = array_create(0);
			dir		   = _dir;
			distance   = 1;
			list	   = ds_list_create();
			notme	   = true;
			ordered	   = false;
			padding	   = 1;
			precise	   = true;
		};
			
		// = EVENTS ====================
		on_update (function() {
			__update_bounds();
			__update_collisions();
			__update_previous();
		});
		on_cleanup(function() {
			__.collided.cleanup();
			ds_list_destroy(__.list);
		});
	};
	
	