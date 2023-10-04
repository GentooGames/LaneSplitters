
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   ______   ______   ______    //
	// /\  == \ /\  __ \ /\  ___\ /\  ___\   //
	// \ \  __< \ \  __ \\ \___  \\ \  __\   //
	//  \ \_____\\ \_\ \_\\/\_____\\ \_____\ //
	//   \/_____/ \/_/\/_/ \/_____/ \/_____/ //
	//                                       //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function IB_Base(_config = {}) constructor {
	
		var _self  = self;
		var _owner = other;
	
		// public
		static activate			   = function(_active = true) {
			if (is_initialized()) {
				if (_active) {
					__.base.activation.active = true;
					__on_activate();
					__log("activate");
				}
				else deactivate();
			}
			return self;
		};
		static cleanup			   = function() {
			if (is_initialized() && !is_cleaned_up()) {
				__.base.cleanup.cleaned_up = true;
				__on_cleanup();
				__log("cleanup");
			}
			return self;
		};
		static deactivate		   = function() {
			if (is_initialized()) {
				__.base.activation.active = false;
				__on_deactivate();
				__log("deactivate");
			}
			return self;
		};
		static debug_activate	   = function(_debug = true) {
			if (is_initialized()) {
				if (_debug) {
					__.base.debugging.active = true;
					__on_debug_activate();
					__log("debug activate");
				}
				else debug_deactivate();
			}
			return self;
		};
		static debug_deactivate	   = function() {
			if (is_initialized()) {
				__.base.debugging.active = false;
				__on_debug_deactivate();
				__log("debug deactivate");
			}
			return self;
		};
		static destroy			   = function(_immediate = true, _cleanup = true) {
			if (is_initialized() && !is_destroyed()) {
				__.base.destruction.destroyed = true;
				__on_destroy();
				if (_cleanup  ) cleanup();
				if (_immediate) {}
				__log("destroy");
			}
			return self;
		};
		static hide				   = function() {
			if (is_initialized()) {
				__.base.visibility.visible = false;
				__on_hide();
				__log("hide");
			}
			return self;
		};
		static initialize		   = function() {
			if (!is_initialized()) {
				__.base.initialization.initialized = true;
				__on_initialize();
				__log("initialize");
			}
			return self;
		};
		static render			   = function(_visible = is_visible()) {
			if (is_initialized() && _visible) {
				__on_render();
			}
			return self;
		};
		static render_begin		   = function(_visible = is_visible()) {
			if (is_initialized() && _visible) {
				__on_render_begin();
			}
			return self;
		};
		static render_end		   = function(_visible = is_visible()) {
			if (is_initialized() && _visible) {
				__on_render_end();
			}
			return self;
		};
		static render_gui		   = function(_visible = is_visible()) {
			if (is_initialized() && _visible) {
				__on_render_gui();
			}
			return self;
		};
		static show				   = function(_visible = true) {
			if (is_initialized()) {
				if (_visible) {
					__.base.visibility.visible = true;
					__on_show();
					__log("show");
				}
				else hide();
			}
			return self;
		};
		static update_begin		   = function(_active  = is_active()) {
			if (is_initialized() && _active) {
				__on_update_begin();
			}
			return self;
		};
		static update			   = function(_active  = is_active()) {
			if (is_initialized() && _active) {
				__on_update();
			}
			return self;
		};
		static update_end		   = function(_active  = is_active()) {
			if (is_initialized() && _active) {
				__on_update_end();
			}
			return self;
		};
							      
		static get_guid			   = function() {
		
			// guid is a static variable that doesnt change
			// during the lifecycle. this is a reference to 
			// the class definition + ptr value. even if the 
			// defined name and uid values change, this guid
			// value will always remain constant, making it
			// a great value to use for global storage / 
			// reference keys.
		
			return __.meta.guid;	
		};
		static get_name			   = function() {
			return __.meta.name;
		};
		static get_owner		   = function() {
			return __.owner;	
		};
		static get_uid			   = function() {
			return __.meta.uid;
		};
							      
		static is_initialized	   = function() {
			return __.base.initialization.initialized;	
		};
		static is_active		   = function() {
			return __.base.activation.active;	
		};
		static is_cleaned_up	   = function() {
			return __.base.cleanup.cleaned_up;	
		};
		static is_debug_active	   = function() {
			return __.base.debugging.debugging;	
		};
		static is_destroyed		   = function() {
			return __.base.destruction.destroyed;	
		};
		static is_visible		   = function() {
			return __.base.visibility.visible;
		};
							      						    
		static on_activate		   = function(_callback, _data) {
			array_push(__.base.activation.on_activation, {
				callback: _callback, 
				data:	  _data,
			});
			return self;
		};
		static on_cleanup		   = function(_callback, _data) {
			array_push(__.base.cleanup.on_cleanup, {
				callback: _callback,
				data:	  _data,
			});
			return self;
		};
		static on_deactivate	   = function(_callback, _data) {
			array_push(__.base.activation.on_deactivation, {
				callback: _callback, 
				data:	  _data,
			});
			return self;
		};
		static on_debug_activate   = function(_callback, _data) {
			array_push(__.base.debugging.on_activate, {
				callback: _callback, 
				data:	  _data,
			});
			return self;
		};
		static on_debug_deactivate = function(_callback, _data) {
			array_push(__.base.debugging.on_deactivate, {
				callback: _callback, 
				data:	  _data,
			});
			return self;
		};
		static on_hide			   = function(_callback, _data) {
			array_push(__.base.visibility.on_hide, {
				callback: _callback,
				data:	  _data,
			});
			return self;
		};
		static on_initialize	   = function(_callback, _data) {
			array_push(__.base.initialization.on_initialization, {
				callback: _callback, 
				data: _data,
			});
			return self;
		};
		static on_render		   = function(_callback, _data) {
			array_push(__.base.render.on_render, {
				callback: _callback, 
				data: _data,
			});
			return self;
		};
		static on_render_begin	   = function(_callback, _data) {
			array_push(__.base.render.on_render_begin, {
				callback: _callback, 
				data: _data,
			});
			return self;
		};
		static on_render_end	   = function(_callback, _data) {
			array_push(__.base.render.on_render_end, {
				callback: _callback, 
				data: _data,
			});
			return self;
		};
		static on_render_gui	   = function(_callback, _data) {
			array_push(__.base.render.on_render_gui, {
				callback: _callback, 
				data: _data,
			});
			return self;
		};
		static on_show			   = function(_callback, _data) {
			array_push(__.base.visibility.on_show, {
				callback: _callback,
				data:	  _data,
			});
			return self;
		};
		static on_update_begin	   = function(_callback, _data) {
			array_push(__.base.update.on_begin, {
				callback: _callback, 
				data: _data,
			});
			return self;
		};
		static on_update		   = function(_callback, _data) {
			array_push(__.base.update.on_update, {
				callback: _callback, 
				data: _data,
			});
			return self;
		};
		static on_update_end	   = function(_callback, _data) {
			array_push(__.base.update.on_end, {
				callback: _callback, 
				data: _data,
			});
			return self;
		};
		
		static set_name			   = function(_name) {
			__.meta.name = _name;
			return self;
		};
		static set_owner		   = function(_owner) {
			__.owner = _owner;
			return self;
		};
		static set_uid			   = function(_uid) {
			__.meta.uid = _uid;
			return self;
		};
	
		// private
		self[$ "__"] ??= {};
		with (__) {
			static __log				 = function(_message, _flags = IB_LOG_FLAG.NONE) {
				iceberg.log(
					"[" + instanceof(self) + "] " + _message, 
					IB_LOG_FLAG.INSTANCES | IB_LOG_FLAG.CONSTRUCTORS | _flags
				);
			};
			static __on_callback		 = function(_callback) {
				_callback.callback({
					data: _callback.data,
				});	
			};
			static __on_activate		 = function() {
				iceberg.array.for_each(
					__.base.activation.on_activation,
					__on_callback,
				);
			};
			static __on_cleanup		   	 = function() {
				iceberg.array.for_each(
					__.base.cleanup.on_cleanup,
					__on_callback,
				);
			};
			static __on_destroy		   	 = function() {
				iceberg.array.for_each(
					__.base.destruction.on_destruction,
					__on_callback,
				);
			};
			static __on_deactivate	   	 = function() {
				iceberg.array.for_each(
					__.base.activation.on_deactivation,
					__on_callback,
				);
			};
			static __on_debug_activate   = function() {
				iceberg.array.for_each(
					__.base.debugging.on_activate,
					__on_callback,
				);
			};
			static __on_debug_deactivate = function() {
				iceberg.array.for_each(
					__.base.debugging.on_deactivate,
					__on_callback,
				);
			};
			static __on_hide			 = function() {
				iceberg.array.for_each(
					__.base.visibility.on_hide,
					__on_callback,
				);
			};
			static __on_initialize	   	 = function() {
				iceberg.array.for_each(
					__.base.initialization.on_initialization,
					__on_callback,
				);
			};
			static __on_render			 = function() {
				iceberg.array.for_each(
					__.base.render.on_render,
					__on_callback,
				);
			};
			static __on_render_begin	 = function() {
				iceberg.array.for_each(
					__.base.render.on_render_begin,
					__on_callback,
				);
			};
			static __on_render_end		 = function() {
				iceberg.array.for_each(
					__.base.render.on_render_end,
					__on_callback,
				);
			};
			static __on_render_gui		 = function() {
				iceberg.array.for_each(
					__.base.render.on_render_gui,
					__on_callback,
				);
			};
			static __on_show			 = function() {
				iceberg.array.for_each(
					__.base.visibility.on_show,
					__on_callback,
				);
			};
			static __on_update_begin	 = function() {
				iceberg.array.for_each(
					__.base.update.on_begin,
					__on_callback,
				);
			};
			static __on_update			 = function() {
				iceberg.array.for_each(
					__.base.update.on_update,
					__on_callback,
				);
			};
			static __on_update_end		 = function() {
				iceberg.array.for_each(
					__.base.update.on_end,
					__on_callback,
				);
			};
			
			root  = _self;
			owner = _config[$ "owner"] ?? _owner;
		
			// meta
			meta = {};
			meta.generate_guid = method(_self, function() {
				return __.meta.generate_name() + "_" + __.meta.generate_uid();	
			});
			meta.generate_name = method(_self, function() {
				return instanceof(self);
			});
			meta.generate_uid  = method(_self, function() {
				return string(ptr(self));
			});
			
			meta.guid = _config[$ "guid"] ?? meta.generate_guid();
			meta.name = _config[$ "name"] ?? meta.generate_name();
			meta.uid  = _config[$ "uid" ] ?? meta.generate_uid();
		
			// base
			base = {};
			base.activation		= {
				active:			_config[$ "active"] ?? true,
				on_activation:	 [],
				on_deactivation: [],
			};
			base.cleanup		= {
				cleaned_up: false,
				on_cleanup: [],
			};				
			base.debugging		= {
				active:			_config[$ "debug"] ?? false,
				on_activation:   [],
				on_deactivation: [],
			};
			base.destruction	= {
				destroyed:		false,
				on_destruction: [],
			};
			base.initialization = {
				initialized:	   false, 
				on_initialization: [],
			};
			base.render			= {
				on_render:		 [],
				on_render_begin: [],
				on_render_end:	 [],
				on_render_gui:	 [],
			};
			base.update			= {
				on_begin:  [],
				on_update: [],
				on_end:	   [],
			};
			base.visibility		= {
				visible: _config[$ "visible"] ?? true,
				on_hide:  [],
				on_show:  [],
			};
		};
			
		////////////////////////////
		
		__log("created");
	};
	
	
	
	
	