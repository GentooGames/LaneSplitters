
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   ______   ______   ______  ______  //
	// /\  __ \ /\  ___\ /\  ___\ /\  ___\/\__  _\ //
	// \ \  __ \\ \___  \\ \___  \\ \  __\\/_/\ \/ //
	//  \ \_\ \_\\/\_____\\/\_____\\ \_____\ \ \_\ //
	//   \/_/\/_/ \/_____/ \/_____/ \/_____/  \/_/ //
	//                                             //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function _IB_Utility_AssetTree() constructor {
	
		static get_fonts_as_array	   = function() {
			var _items = [];
			for (var _item = 0; _item < 1000000; _item++) {
				if (!font_exists(_item)) {
					return _items;	
				}
				array_push(_items, _item);
			};
			return _items;
		};
		static get_fonts_as_struct	   = function() {
			var _items = {};
			for (var _item = 0; _item < 1000000; _item++) {
				if (!font_exists(_item)) {
					return _items;	
				}
				_items[$ font_get_name(_item)] = _item;
			};
			return _items;
		};
		static get_objects_as_array	   = function() {
			var _items = [];
			for (var _item = 0; _item < 1000000; _item++) {
				if (!object_exists(_item)) {
					return _items;	
				}
				array_push(_items, _item);
			};
			return _items;
		};
		static get_objects_as_struct   = function() {
			var _items = {};
			for (var _item = 0; _item < 1000000; _item++) {
				if (!object_exists(_item)) {
					return _items;	
				}
				_items[$ object_get_name(_item)] = _item;
			};
			return _items;
		};
		static get_object_parents	   = function() {
			var _parents = [];
			var _unique  = {};	// used so that duplicates are not stored
	
			for (var _object = 0; _object < 1000000; _object++) {
				if (!object_exists(_object)) {
					return _parents;	
				}
				var _parent  = object_get_parent(_object);
				if (_parent != -1 && _parent != -100) {
					if (_unique[$ object_get_name(_parent)] == undefined) {
						_unique[$ object_get_name(_parent)] = _parent;
						array_push(_parents, _parent);		
					}
				}
			};
			return _parents;
		};
		static get_paths_as_array	   = function() {
			var _items = [];
			for (var _item = 0; _item < 1000000; _item++) {
				if (!path_exists(_item)) {
					return _items;	
				}
				array_push(_items, _item);
			};
			return _items;
		};
		static get_paths_as_struct	   = function() {
			var _items = {};
			for (var _item = 0; _item < 1000000; _item++) {
				if (!path_exists(_item)) {
					return _items;	
				}
				_items[$ path_get_name(_item)] = _item;
			};
			return _items;
		};
		static get_rooms_as_array	   = function() {
			var _items = [];
			for (var _item = 0; _item < 1000000; _item++) {
				if (!room_exists(_item)) {
					return _items;	
				}
				array_push(_items, _item);
			};
			return _items;
		};
		static get_rooms_as_struct	   = function() {
			var _items = {};
			for (var _item = 0; _item < 1000000; _item++) {
				if (!room_exists(_item)) {
					return _items;	
				}
				_items[$ room_get_name(_item)] = _item;
			};
			return _items;
		};
		static get_sequences_as_array  = function() {
			var _items = [];
			for (var _item = 0; _item < 1000000; _item++) {
				if (!sequence_exists(_item)) {
					return _items;	
				}
				array_push(_items, _item);
			};
			return _items;
		};
		static get_scripts_as_array	   = function() {
			var _items = [];
			for (var _item = 0; _item < 1000000; _item++) {
				if (!script_exists(_item)) {
					return _items;	
				}
				array_push(_items, _item);
			};
			return _items;
		};
		static get_scripts_as_struct   = function() {
			var _items = {};
			for (var _item = 0; _item < 1000000; _item++) {
				if (!script_exists(_item)) {
					return _items;	
				}
				_items[$ script_get_name(_item)] = _item;
			};
			return _items;
		};
		static get_sounds_as_array	   = function() {
			var _items = [];
			for (var _item = 0; _item < 1000000; _item++) {
				if (!audio_exists(_item)) {
					return _items;	
				}
				array_push(_items, _item);
			};
			return _items;
		};
		static get_sounds_as_struct    = function() {
			var _items = {};
			for (var _item = 0; _item < 1000000; _item++) {
				if (!audio_exists(_item)) {
					return _items;	
				}
				_items[$ audio_get_name(_item)] = _item;
			};
			return _items;
		};
		static get_sprites_as_array	   = function() {
			var _items = [];
			for (var _item = 0; _item < 1000000; _item++) {
				if (!sprite_exists(_item)) {
					return _items;	
				}
				array_push(_items, _item);
			};
			return _items;
		};
		static get_sprites_as_struct   = function() {
			var _items = {};
			for (var _item = 0; _item < 1000000; _item++) {
				if (!sprite_exists(_item)) {
					return _items;	
				}
				_items[$ sprite_get_name(_item)] = _item;
			};
			return _items;
		};
		static get_timelines_as_array  = function() {
			var _items = [];
			for (var _item = 0; _item < 1000000; _item++) {
				if (!timeline_exists(_item)) {
					return _items;	
				}
				array_push(_items, _item);
			};
			return _items;
		};
	};
