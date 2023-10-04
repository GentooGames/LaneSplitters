
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   ______  ______   __  __   ______   ______  //
	// /\  ___\ /\__  _\/\  == \ /\ \/\ \ /\  ___\ /\__  _\ //
	// \ \___  \\/_/\ \/\ \  __< \ \ \_\ \\ \ \____\/_/\ \/ //
	//  \/\_____\  \ \_\ \ \_\ \_\\ \_____\\ \_____\  \ \_\ //
	//   \/_____/   \/_/  \/_/ /_/ \/_____/ \/_____/   \/_/ //
	//                                                      //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function IB_Collection_Struct(_config = {}) constructor {

		// public
		static clear		   = function() {
			__.items = {};
			__.names = [];
			__.count = 0;
			return self;
		};
		static contains		   = function(_item_name) {
			return __.items[$ _item_name] != undefined;
		};
		static deserialize	   = function(_string) {
			__.items = json_parse(_string);
			__.names = variable_struct_get_names(__.items);
			__.count = array_length(__.names);
			return self;
		};
		static for_each		   = function(_callback, _data = undefined) {
			for (var _i = 0; _i < __.count; _i++) {
				var _name = __.names[_i];	
				var _item = __.items[$ _name];
				_callback(_item, _data);
			};
		};
		static get			   = function(_item_name) {
			return __.items[$ _item_name];
		};
		static get_by_index	   = function(_index) {
			var _name = get_name(_index);
			return get(_name)
		};
		static get_items	   = function() {
			return __.items;	
		};
		static get_name		   = function(_index) {
			return __.names[_index];
		};
		static get_names	   = function() {
			return __.names;
		};
		static get_random	   = function() {
			var _name = iceberg.array.get_random(__.names);
			return get(_name);
		};
		static get_size		   = function() {
			return __.count;
		};
		static is_empty		   = function() {
			return get_size() == 0;
		};
		static iterate_on_name = function(_callback, _backwards = false) {
			if (_backwards) {
				for (var _i = get_size() - 1; _i >= 0; _i--) {
					var _name = get_name(_i);
					_callback(_name);
				};	
			}
			else {
				for (var _i = 0, _len = get_size(); _i < _len; _i++) {
					var _name = get_name(_i);
					_callback(_name);
				};	
			}
			return self;
		};
		static iterate_on_item = function(_callback, _backwards = false) {
			if (_backwards) {
				for (var _i = get_size() - 1; _i >= 0; _i--) {
					var _item = get_by_index(_i);
					_callback(_item);
				};	
			}
			else {
				for (var _i = 0, _len = get_size(); _i < _len; _i++) {
					var _item = get_by_index(_i);
					_callback(_item);
				};	
			}
			return self;
		};
		static remove		   = function(_item_name) {
			if (contains(_item_name)) {
				// array_find_delete()
				for (var _i = array_length(__.names) - 1; _i >= 0; _i--) {
					if (__.names[_i] == _item_name) {
						array_delete(__.names, _i, 1);	
						__.count--;
					}
				};
				variable_struct_remove(__.items, _item_name);
			}
			return self;
		};
		static serialize	   = function() {
			return json_stringify(__.items);
		};
		static set			   = function(_item_name, _item) {
			if (!contains(_item_name)) {
				array_push(__.names, _item_name);
				__.count++;	
			}
			__.items[$ _item_name] = _item;
			return self;
		};
			
		// private
		__ = {};
		with (__) {
			items = _config[$ "items"] ?? {};
			names = variable_struct_get_names(items);
			count = array_length(names);
		};
	};
