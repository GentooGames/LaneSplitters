
	//	variable definitions
	//	anchor = undefined;
	
	x = instance_nearest(x, y, anchor.object_index).x;
	y = instance_nearest(x, y, anchor.object_index).y;
	
	path = path_add();
	path_set_kind  (path, true );
	path_set_closed(path, false);
	
	anchors = anchor.get_anchor_chain();	
	for (var _i = 0, _len = array_length(_anchors); _i < _len; _i++) {
		var _anchor = anchors[_i];	
		path_add_point(path, _anchor.x, _anchor.y, _anchor.anchor_speed);
	};
	
	