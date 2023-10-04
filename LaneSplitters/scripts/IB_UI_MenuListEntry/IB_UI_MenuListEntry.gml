
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   __   __   ______  ______   __  __    //
	// /\  ___\ /\ "-.\ \ /\__  _\/\  == \ /\ \_\ \   //
	// \ \  __\ \ \ \-.  \\/_/\ \/\ \  __< \ \____ \  //
	//  \ \_____\\ \_\\"\_\  \ \_\ \ \_\ \_\\/\_____\ //
	//   \/_____/ \/_/ \/_/   \/_/  \/_/ /_/ \/_____/ //
	//                                                //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function IB_UI_MenuListEntry(_config = {}) : IB_Entity(_config) constructor {
	
		var _self = self;
		
		// = PUBLIC ================
		static select			 = function() {
			if (__.callback != undefined) {
				return __.callback(__.callback_data);	
			}
			return undefined;
		};
		static hover_start		 = function() {
			iceberg.array.for_each(__.hover_start_callbacks, 
				function(_callback) {
					_callback.callback(_callback.data);
				}
			);
			return self;
		};
		static hover_stop		 = function() {
			iceberg.array.for_each(__.hover_stop_callbacks, 
				function(_callback) {
					_callback.callback(_callback.data);
				}
			);
			return self;
		};
		static on_hover_start	 = function(_callback, _data = undefined) {
			array_push(__.hover_start_callbacks, {
				callback: _callback,
				data:	  _data,
			});
			return self;
		};
		static on_hover_stop	 = function(_callback, _data = undefined) {
			array_push(__.hover_stop_callbacks, {
				callback: _callback,
				data:	  _data,
			});
			return self;
		};
		static get_callback		 = function() {
			return __.callback;
		};
		static get_callback_data = function() {
			return __.callback_data;
		};
		static get_text			 = function() {
			return __.text;
		};
		static set_callback		 = function(_callback, _data = undefined) {
			__.callback		 = _callback;
			__.callback_data = _data;
			return self;
		};
		static set_text			 = function(_text) {
			__.text = _text;
			return self;
		};
		
		// = PRIVATE ===============
		with (__) {
			index				  = _config[$ "index"		 ] ?? undefined;
			text				  = _config[$ "text"		 ] ?? "";	
			callback			  = _config[$ "callback"	 ] ?? undefined;
			callback_data		  = _config[$ "callback_data"] ?? undefined;
			hover_start_callbacks =  array_create(0);
			hover_stop_callbacks  =  array_create(0);
		};
	};
	
	