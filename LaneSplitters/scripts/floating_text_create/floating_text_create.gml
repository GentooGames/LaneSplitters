
	function floating_text_create(_x = x, _y = y, _depth = depth, _text, _color = c_white, _scale = 1, _center = false) {
		return instance_create_depth(_x, _y, _depth, obj_text, {
			color:	_color,	
			text:	_text,	
			scale:	_scale,	
			center: _center,
		});
	};
	