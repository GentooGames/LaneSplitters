	
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   ______   ______   ______    //
	// /\  == \ /\  __ \ /\  ___\ /\  ___\   //
	// \ \  __< \ \  __ \\ \___  \\ \  __\   //
	//  \ \_____\\ \_\ \_\\/\_____\\ \_____\ //
	//   \/_____/ \/_/\/_/ \/_____/ \/_____/ //
	//                                       //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	// IB_Object_Base.create //
	event_inherited();
	
	var _self = self;
	
	// public
	activate			= function(_active = true) {
		if (is_initialized() && !is_active()) {
			if (_active) {
				__.base.activation.active = true;
				iceberg.array.for_each(
					__.base.activation.on_activation,
					function(_callback) {
						_callback.callback(_callback.data);	
					},
				);
				__.log("activate");
			}
			else deactivate();
		}
		return self;
	};
	cleanup				= function() {
		if (is_initialized() && !is_cleaned_up()) {
			__.base.cleanup.cleaned_up = true;
			iceberg.array.for_each(
				__.base.cleanup.on_cleanup,
				function(_callback) {
					_callback.callback(_callback.data);	
				},
			);
			__.log("cleanup");
		}
		return self;
	};
	deactivate			= function() {
		if (is_initialized()) {
			__.base.activation.active = false;
			iceberg.array.for_each(
				__.base.activation.on_deactivation,
				function(_callback) {
					_callback.callback(_callback.data);	
				},
			);
			__.log("deactivate");
		}
		return self;
	};
	debug_activate		= function(_debug = true) {
		if (is_initialized()) {
			if (_debug) {
				__.base.debugging.active = true;
				iceberg.array.for_each(
					__.base.debugging.on_activate,
					function(_callback) {
						_callback.callback(_callback.data);
					},
				);
				__.log("debug activate");
			}
			else debug_deactivate();
		}
		return self;
	};
	debug_deactivate	= function() {
		if (is_initialized()) {
			__.base.debugging.active = false;
			iceberg.array.for_each(
				__.base.debugging.on_deactivate,
				function(_callback) {
					_callback.callback(_callback.data);
				},
			);
			__.log("debug deactivate");
		}
		return self;
	};
	destroy				= function(_immediate = true, _cleanup = true) {
		if (is_initialized() && !is_destroyed()) {
			__.base.destruction.destroyed = true;
			if (_cleanup  ) cleanup();
			if (_immediate) instance_destroy();
			__.log("destroy");
		}
		return self;
	};
	hide				= function() {
		if (is_initialized()) {
			__.base.visibility.visible = false;
							   visible = false;
			iceberg.array.for_each(
				__.base.visibility.on_hide,
				function(_callback) {
					_callback.callback(_callback.data);	
				},
			);
			__.log("hide");
		}
		return self;
	};
	initialize			= function() {
		if (!is_initialized()) {
			__.base.initialization.initialized = true;
			__.base.cleanup.cleaned_up		   = false;
			iceberg.array.for_each(
				__.base.initialization.on_initialization,
				function(_callback) {
					_callback.callback(_callback.data);	
				},
			);
			__.log("initialize");
		}
		return self;
	};
	render				= function(_visible = is_visible()) {
		if (is_initialized() && _visible) {
			iceberg.array.for_each(
				__.base.render.on_render,
				function(_callback) {
					_callback.callback(_callback.data);	
				},
			);
		}
		return self;
	};
	render_begin		= function(_visible = is_visible()) {
		if (is_initialized() && _visible) {
			iceberg.array.for_each(
				__.base.render.on_render_begin,
				function(_callback) {
					_callback.callback(_callback.data);	
				},
			);
		}
		return self;
	};
	render_end			= function(_visible = is_visible()) {
		if (is_initialized() && _visible) {
			iceberg.array.for_each(
				__.base.render.on_render_end,
				function(_callback) {
					_callback.callback(_callback.data);	
				},
			);
		}
		return self;
	};
	render_gui			= function(_visible = is_visible()) {
		if (is_initialized() && _visible) {
			iceberg.array.for_each(
				__.base.render.on_render_gui,
				function(_callback) {
					_callback.callback(_callback.data);	
				},
			);
		}
		return self;
	};
	show				= function(_visible = true) {
		if (is_initialized()) {
			if (_visible) {
				__.base.visibility.visible = true;
								   visible = true;
				iceberg.array.for_each(
					__.base.visibility.on_show,
					function(_callback) {
						_callback.callback(_callback.data);	
					},
				);
				__.log("show");
			}
			else hide();
		}
		return self;
	};
	update_begin		= function(_active  = is_active()) {
		if (is_initialized() && _active) {
			iceberg.array.for_each(
				__.base.update.on_begin,
				function(_callback) {
					_callback.callback(_callback.data);	
				},
			);
		}
		return self;
	};
	update				= function(_active  = is_active()) {
		if (is_initialized() && _active) {
			iceberg.array.for_each(
				__.base.update.on_update,
				function(_callback) {
					_callback.callback(_callback.data);	
				},
			);
		}
		return self;
	};
	update_end			= function(_active  = is_active()) {
		if (is_initialized() && _active) {
			iceberg.array.for_each(
				__.base.update.on_end,
				function(_callback) {
					_callback.callback(_callback.data);	
				},
			);
		}
		return self;
	};
	room_start			= function() {
		if (is_initialized()) {
			iceberg.array.for_each(
				__.base.room.on_start,
				function(_callback) {
					_callback.callback(_callback.data);	
				},
			);
		}
		return self;
	};
	room_end			= function() {
		if (is_initialized()) {
			iceberg.array.for_each(
				__.base.room.on_end,
				function(_callback) {
					_callback.callback(_callback.data);	
				},
			);
		}
		return self;
	};

	get_guid			= function() {
		
		// guid is a static variable that doesnt change
		// during the lifecycle. this is a reference to 
		// the class definition + ptr value. even if the 
		// defined name and uid values change, this guid
		// value will always remain constant, making it
		// a great value to use for global storage / 
		// reference keys.
		
		return __.meta.guid;	
	};
	get_name			= function() {
		return __.meta.name;
	};
	get_owner			= function() {
		return __.owner;	
	};
	get_uid				= function() {
		return __.meta.uid;
	};

	is_initialized		= function() {
		return __.base.initialization.initialized;	
	};
	is_active			= function() {
		return __.base.activation.active;	
	};
	is_cleaned_up		= function() {
		return __.base.cleanup.cleaned_up;	
	};
	is_debug_active		= function() {
		return __.base.debugging.debugging;	
	};
	is_destroyed		= function() {
		return __.base.destruction.destroyed;	
	};
	is_visible			= function() {
		return __.base.visibility.visible;
	};

	set_name			= function(_name) {
		__.meta.name = _name;
		return self;
	};
	set_owner			= function(_owner) {
		__.owner = _owner;
		return self;
	};
	set_uid				= function(_uid) {
		__.meta.uid = _uid;
		return self;
	};

	on_activate			= function(_callback, _data = undefined) {
		array_push(__.base.activation.on_activation, {
			callback: _callback, 
			data:	  _data,
		});
		return activate;
	};
	on_cleanup			= function(_callback, _data = undefined) {
		array_push(__.base.cleanup.on_cleanup, {
			callback: _callback,
			data:	  _data,
		});
		return cleanup;
	};
	on_deactivate		= function(_callback, _data = undefined) {
		array_push(__.base.activation.on_deactivation, {
			callback: _callback, 
			data:	  _data,
		});
		return deactivate;
	};
	on_debug_activate   = function(_callback, _data = undefined) {
		array_push(__.base.debugging.on_activate, {
			callback: _callback, 
			data:	  _data,
		});
		return debug_activate;
	};
	on_debug_deactivate = function(_callback, _data = undefined) {
		array_push(__.base.debugging.on_deactivate, {
			callback: _callback, 
			data:	  _data,
		});
		return debug_deactivate;
	};
	on_hide				= function(_callback, _data = undefined) {
		array_push(__.base.visibility.on_hide, {
			callback: _callback,
			data:	  _data,
		});
		return hide;
	};
	on_initialize		= function(_callback, _data = undefined) {
		array_push(__.base.initialization.on_initialization, {
			callback: _callback, 
			data: _data,
		});
		return initialize;
	};
	on_render			= function(_callback, _data = undefined) {
		array_push(__.base.render.on_render, {
			callback: _callback, 
			data: _data,
		});
		return render;
	};
	on_render_begin		= function(_callback, _data = undefined) {
		array_push(__.base.render.on_render_begin, {
			callback: _callback, 
			data: _data,
		});
		return render_begin;
	};
	on_render_end		= function(_callback, _data = undefined) {
		array_push(__.base.render.on_render_end, {
			callback: _callback, 
			data: _data,
		});
		return render_end;
	};
	on_render_gui		= function(_callback, _data = undefined) {
		array_push(__.base.render.on_render_gui, {
			callback: _callback, 
			data: _data,
		});
		return render_gui;
	};
	on_show				= function(_callback, _data = undefined) {
		array_push(__.base.visibility.on_show, {
			callback: _callback,
			data:	  _data,
		});
		return show;
	};
	on_update_begin		= function(_callback, _data = undefined) {
		array_push(__.base.update.on_begin, {
			callback: _callback,
			data: _data,
		});
		return update_begin;
	};
	on_update			= function(_callback, _data = undefined) {
		array_push(__.base.update.on_update, {
			callback: _callback, 
			data: _data,
		});
		return update;
	};
	on_update_end		= function(_callback, _data = undefined) {
		array_push(__.base.update.on_end, {
			callback: _callback,
			data: _data,
		});
		return update_end;
	};
	on_room_start		= function(_callback, _data = undefined) {
		array_push(__.base.room.on_start, {
			callback: _callback,
			data: _data,
		});
		return update_end;
	};
	on_room_end			= function(_callback, _data = undefined) {
		array_push(__.base.room.on_end, {
			callback: _callback,
			data: _data,
		});
		return update_end;
	};

	// private
	self[$ "__"] ??= {};
	with (__) {
		root  = _self;
		owner = _self[$ "owner"];
		log   =  method(_self, function(_message, _flags = IB_LOG_FLAG.NONE) {
			iceberg.log(
				"[" + object_get_name(object_index) + "] " + _message, 
				IB_LOG_FLAG.INSTANCES | IB_LOG_FLAG.OBJECTS | _flags
			);
		});
		
		// meta
		meta = {};
		meta.generate_guid = method(_self, function() {
			return __.meta.generate_name() + "_" + __.meta.generate_uid()
		});
		meta.generate_name = method(_self, function() {
			return object_get_name(object_index);
		});
		meta.generate_uid  = method(_self, function() {
			return string(ptr(self));
		});
		
		meta.guid = _self[$ "guid"] ?? meta.generate_guid();
		meta.name = _self[$ "name"] ?? meta.generate_name();
		meta.uid  = _self[$ "uid" ] ?? meta.generate_uid();
			
		// base
		base = {};
		base.activation		= {
			active:			_self[$ "active"] ?? true,
			on_activation:	 [],
			on_deactivation: [],
		};
		base.cleanup		= {
			cleaned_up: false,
			on_cleanup: [],
		};
		base.debugging		= {
			active:			 false,
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
		base.room			= {
			on_start: [],
			on_end:   [],
		};
		base.update			= {
			on_begin:  [],
			on_update: [],
			on_end:	   [],
		};
		base.visibility		= {
			visible: _self.visible,
			on_hide:  [],
			on_show:  [],
		};
			
		variable_struct_remove(_self, "owner" );
		variable_struct_remove(_self, "guid"  );
		variable_struct_remove(_self, "name"  );
		variable_struct_remove(_self, "uid"   );
		variable_struct_remove(_self, "active");
	};
		
	__.log("created");
		
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	