
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  __    __   ______   __   __   __  __    //
	// /\ "-./  \ /\  ___\ /\ "-.\ \ /\ \/\ \   //
	// \ \ \-./\ \\ \  __\ \ \ \-.  \\ \ \_\ \  //
	//  \ \_\ \ \_\\ \_____\\ \_\\"\_\\ \_____\ //
	//   \/_/  \/_/ \/_____/ \/_/ \/_/ \/_____/ //
	//                                          //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	// objc_menu.create //
	event_inherited();
	
	var _self = self;
	
	open	= function() {
		with (obj_car) { 
			input_lock_set("menu_open"); 
		};
		objc_veil.close();
		show();
		activate();
		__.open = true;
		return self;
	};
	close	= function() {
		with (obj_car) {
			input_lock_remove("menu_open");
		};
		objc_veil.open();
		hide();
		deactivate();
		__.open = false;
		
		// start countdown?
		if (objc_time.get_state() == "idle") {
			objc_time.countdown();
		}
		
		return self;
	};
	is_open = function() {
		return __.open;
	};
	
	// private
	with (__) {
		open   = true;
		volume = 1;
		
		// menu slabs
		slab = new IB_UI_SlabStack({
			x:					 SURF_W - 350,
			y:					 SURF_H - 450,
			indentation_per:	 0,
			select_indentation: -50,
			select_color:		 #eb6c82,
			unselect_color:		 c_white,
		});
		var _slab_config = {
			width:		  500,
			height:		  50,
			text_color:	  c_black,
			text_scale:	  1,
			text_padding: 20,
		};
		slab.new_slab("drive!",			method(_self, function() {
			close();
			if (objc_time.get_state() == "finished") {
				room_restart();	
			}
		}), _slab_config);
		slab.new_slab("restart",		method(_self, function() {
			room_restart();
		}), _slab_config);
		slab.new_slab("next track",		method(_self, function() {
			if (room_next(room) != -1) {
				room_goto_next();
			}
			else {
				room_goto(room_next(__rm_headphones));	
			}
		}), _slab_config);
		slab.new_slab("previous track", method(_self, function() {
			if (room_previous(room) != -1
			&&	objc_world.room_is_track(room_previous(room))
			) {
				room_goto_previous();
			}
			else {
				var _room = __rm_init;
				while (_room != -1) {
					_room = room_next(_room);
					if (room_next(_room) == -1) {
						break;	
					}
				};
				room_goto(_room);
			}
		}), _slab_config);
		slab.new_slab("volume",			method(_self, function() {
			switch (__.volume) {
				case 1.00: __.volume = 0.66; break;
				case 0.66: __.volume = 0.33; break;
				case 0.33: __.volume = 0.00; break;
				case 0.00: __.volume = 1.00; break;
			};
			audio_master_gain(__.volume);
			// play sfx ...
			
		}), _slab_config);
		slab.new_slab("fullscreen",		method(_self, function() {
			window_set_fullscreen(!window_get_fullscreen());
		}), _slab_config);
		slab.new_slab("retire...",		method(_self, function() {
			game_end();
		}), _slab_config);	
		slab.on_select		(method(_self, function() {
			audio_play_sound(sfx_menu_move, false, 0);
		}));
		slab.on_index_change(method(_self, function() {
			audio_play_sound(sfx_menu_move, false, 0);
		}));
			
		// hooks
		round_finished_event	= method(_self, function(_data) {
			open();
		});
		round_finished_listener = undefined;
	};
	
	// events
	on_initialize(function() {
		__.slab.initialize();
		__.round_finished_listener = SUBSCRIBE("round_finished", __.round_finished_event);
	});
	on_update	 (function() {
		__.slab.update();
	});
	on_render_gui(function() {
		// other text drawn on veil
		__.slab.render_gui();
	});
	on_room_start(function() {
		if (objc_world.room_is_track()) {
			activate();
			show();
		}
		else {
			deactivate();
			hide();
		}
	});
	on_cleanup   (function() {
		UNSUBSCRIBE(__.round_finished_listener);
	});
	