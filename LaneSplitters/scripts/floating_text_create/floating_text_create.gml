
	function floating_text_create(_x = x, _y = y, _depth = depth, _text, _color = c_white) {
		var _instance	= instance_create_depth(_x, _y, _depth, obj_text);
		_instance.color = _color;
		_instance.text  = _text;
		return _instance;
	};