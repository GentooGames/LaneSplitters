
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   ______   __       __       __   ______   __   ______   __   __    //
	// /\  ___\ /\  __ \ /\ \     /\ \     /\ \ /\  ___\ /\ \ /\  __ \ /\ "-.\ \   //
	// \ \ \____\ \ \/\ \\ \ \____\ \ \____\ \ \\ \___  \\ \ \\ \ \/\ \\ \ \-.  \  //
	//  \ \_____\\ \_____\\ \_____\\ \_____\\ \_\\/\_____\\ \_\\ \_____\\ \_\\"\_\ //
	//   \/_____/ \/_____/ \/_____/ \/_____/ \/_/ \/_____/ \/_/ \/_____/ \/_/ \/_/ //
	//                                                                             //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function _IB_Utility_Collision() constructor {
	
		static get_instance_bbox_center_x = function(_instance = other) {
			return (_instance.bbox_left + _instance.bbox_right) * 0.5;
		};
		static get_instance_bbox_center_y = function(_instance = other) {
			return (_instance.bbox_top + _instance.bbox_bottom) * 0.5;
		};
		static get_instance_bbox_height	  = function(_instance = other) {
			return _instance.bbox_bottom - _instance.bbox_top;
		};
		static get_instance_bbox_width	  = function(_instance = other) {
			return _instance.bbox_right - _instance.bbox_left;
		};
		static rectangle_bbox			  = function(_instance = other, _object, _precise, _notme, _margin = 0) {
			return collision_rectangle(
				_instance.bbox_left   - _margin, 
				_instance.bbox_top	  - _margin, 
				_instance.bbox_right  + _margin, 
				_instance.bbox_bottom + _margin, 
				_object, 
				_precise, 
				_notme
			);
		};
		static rectangle_list_bbox		  = function(_instance = other, _object, _precise, _notme, _list, _ordered, _margin = 0) {
			return collision_rectangle_list(
				_instance.bbox_left   - _margin, 
				_instance.bbox_top	  - _margin, 
				_instance.bbox_right  + _margin, 
				_instance.bbox_bottom + _margin, 
				_object, 
				_precise, 
				_notme, 
				_list, 
				_ordered
			);
		};
		static raycast					  = function(_x1, _y1, _x2, _y2, _object, _precise, _not_me) {
			// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
			// https://yal.cc/gamemaker-collision-line-point/ //
			// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
			var rr  = collision_line(_x1, _y1, _x2, _y2, _object, _precise, _not_me);
			var rx  = _x2;
			var ry  = _y2;
			if (rr != noone) {
			    var p0 = 0;
			    var p1 = 1;
			
			    repeat (ceil(log2(point_distance(_x1, _y1, _x2, _y2))) + 1) {
			        var np = p0 + (p1 - p0) * 0.5;
			        var nx = _x1 + (_x2 - _x1) * np;
			        var ny = _y1 + (_y2 - _y1) * np;
			        var px = _x1 + (_x2 - _x1) * p0;
			        var py = _y1 + (_y2 - _y1) * p0;
			        var nr = collision_line(px, py, nx, ny, _object, _precise, _not_me);
				
			        if (nr != noone) {
			            rr  = nr;
			            rx  = nx;
			            ry  = ny;
			            p1  = np;
			        } 
					else {
						p0  = np;
					}
			    }
			}
			return { id: rr, x: rx, y: ry, };
		};
	};
