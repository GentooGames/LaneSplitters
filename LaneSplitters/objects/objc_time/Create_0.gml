
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______  __   __    __   ______    //
	// /\__  _\/\ \ /\ "-./  \ /\  ___\   //
	// \/_/\ \/\ \ \\ \ \-./\ \\ \  __\   //
	//    \ \_\ \ \_\\ \_\ \ \_\\ \_____\ //
	//     \/_/  \/_/ \/_/  \/_/ \/_____/ //
	//                                    //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	// objc_time.create //
	event_inherited();
	
	var _self = self;
	
	// public
	countdown		   = function() {
		__.state.fsm.change("countdown");
		return self;
	};			   
	start			   = function() {
		__.state.fsm.change("round");
		return self;
	};
	get_state		   = function() {
		return __.state.fsm.get_current_state();	
	};
	get_time_remaining = function() {
		return __.round_timer;	
	};
	
	// private
	with (__) {
		state = {};
		with (state) {
			fsm = new SnowState("idle", false, {
				owner: _self,
			});
			fsm.add("__", time_state_base());
			fsm.add_child("__", "idle",		 time_state_idle());
			fsm.add_child("__", "countdown", time_state_countdown());
			fsm.add_child("__", "round",	 time_state_round());
			fsm.add_child("__", "finished",  time_state_finished());
		};
		
		time_to_string	= method(_self, function(_time) {
			
			var _total_seconds = floor(_time / SECOND);
		    var _minutes	   = floor(_total_seconds / SECOND);
		    var _seconds	   = _total_seconds mod SECOND;
    
		    // convert remaining frames into milliseconds
		    var _milliseconds = floor((_time mod SECOND) * 16.6667);

		    // format
		    var _str_minutes = (_minutes < 10 ? "0" : "") + string(_minutes);
		    var _str_seconds = (_seconds < 10 ? "0" : "") + string(_seconds);
    
		    var _str_milliseconds = string(_milliseconds);
		    if (_milliseconds < 10) {
		        _str_milliseconds = "00" + _str_milliseconds;
		    } 
			else if (_milliseconds < 100) {
		        _str_milliseconds = "0" + _str_milliseconds;
		    }

		    return _str_minutes + ":" + _str_seconds + "." + _str_milliseconds;
		});
		draw_countdown  = method(_self, function() {
			draw_set_halign(fa_center);
			draw_set_valign(fa_center);
			draw_text_transformed_color(SURF_W * 0.5 + 3, SURF_H * 0.3 + 3, __.time_to_string(__.countdown_timer), 2, 2, 0, c_black, c_black, c_black, c_black, 1);	
			draw_text_transformed(SURF_W * 0.5, SURF_H * 0.3, __.time_to_string(__.countdown_timer), 2, 2, 0);	
			draw_set_halign(fa_left);
			draw_set_valign(fa_top );
		});
		draw_round_time = method(_self, function() {
			draw_text_transformed_color(33, 103, __.time_to_string(__.round_timer), 0.8, 0.8, 0, c_black, c_black, c_black, c_black, 1);
			if (__.round_timer <= (10 * SECOND)) {
				var _red   = #e93841;
				var _wave  = iceberg.tween.wave(0, 1, 1);
				var _color = merge_color(_red, c_white, _wave);
			}
			else {
				var _color = c_white;
			}
			draw_text_transformed_color(30, 100, __.time_to_string(__.round_timer), 0.8, 0.8, 0, _color, _color, _color, _color, 1);
		});
		depth_sort		= method(_self, function() {
			if (depth != objc_veil.depth + 1) {
				depth  = objc_veil.depth + 1;	
			}
		});
		countdown_time	= COUNTDOWN_TIME;
		countdown_timer = countdown_time;
		round_time		= DRIVE_TIME;
		round_timer		= round_time;
	};
	
	// events
	on_initialize(function() {
		__.state.fsm.change("idle");
	});
	on_update	 (function() {
		__.depth_sort();
		__.state.fsm.step();
	});
	on_render_gui(function() {
		__.state.fsm.draw();
	});
	on_room_start(function() {
		__.state.fsm.change("idle");
	});
	on_room_end  (function() {
		__.state.fsm.change("idle");
	});
	
	