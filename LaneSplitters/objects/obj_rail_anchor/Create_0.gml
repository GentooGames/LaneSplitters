
	//	variable definitions
	//	anchor_next		= undefined;
	//	anchor_previous = undefined;
	//	anchor_speed	= 100;
	
	// public
	get_anchor_chain = function() {
		
		var _anchors  = [];
		var _next	  = anchor_next;
		var _previous = anchor_previous;
		
		// recursively get previous anchors
		while (_previous != undefined) {
			if (!iceberg.array.contains(_anchors, _previous)) {
				 array_push(_anchors, _previous);
				_previous = _previous.anchor_previous;
			}
			else break;
		};	
		
		// reverse array
		_anchors = iceberg.array.reverse(_anchors);
		
		// stash self into array
		array_push(_anchors, self);
		
		// recursively get next anchors
		while (_next != undefined) {
			if (!iceberg.array.contains(_anchors, _next)) {
				 array_push(_anchors, _next);
				_next = _next.anchor_next;	
			}
			else break;
		};
		
		return _anchors;
	};
	
	// private
	__ = {};
	with (__) {
		path_generate = method(other, function() {
			var _anchors = get_anchor_chain();	
			for (var _i = 0, _len = array_length(_anchors); _i < _len; _i++) {
				var _anchor = _anchors[_i];	
				path_add_point(__.path, _anchor.x, _anchor.y, _anchor.anchor_speed);
			};
		});
		path		  = path_add();	
	};
	
	// events
	__.path_generate();
	