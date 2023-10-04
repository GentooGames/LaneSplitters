
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______  ______   __   __   __   ______  ______    //
	// /\  == \/\  __ \ /\ \ /\ "-.\ \ /\__  _\/\  ___\   //
	// \ \  _-/\ \ \/\ \\ \ \\ \ \-.  \\/_/\ \/\ \___  \  //
	//  \ \_\   \ \_____\\ \_\\ \_\\"\_\  \ \_\ \/\_____\ //
	//   \/_/    \/_____/ \/_/ \/_/ \/_/   \/_/  \/_____/ //
	//                                                    //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	// objc_points.create //
	event_inherited();
	
	var _self = self;
	
	// public
	get_highscore	  = function() {
		var _track = room_get_name(room);
		var _score = __.highscores[$ _track];
		return _score ?? 0;
	};
	update_highscores = function() {
		if (objc_world.room_is_track()) {
			var _track = room_get_name(room);
			var _score = __.highscores[$ _track];
			
			if (_score == undefined
			||	__.points > _score
			) {
				_score = __.points;
			}
			
			__.points_last = __.points;
			__.highscores[$ _track] = _score;
			save_highscores();
		}
		return self;
	};
	score_drift		  = function(_amount) {
		__.points += _amount;	
		obj_car.audio_play(sfx_drift_score);
		return self;
	};
	penalty_cone_hit  = function(_penalty = 1) {
		__.text_color = #4d80c9;
		__.points	 -= _penalty;
		
		var _interval = 5;
		if (iceberg.time.do_every_frame(_interval)) {
			__.text_create("-", _penalty * _interval, __.text_color);
			obj_car.audio_play(sfx_impact_cone, false, 0);
		}
		return self;
	};
	penalty_human_hit = function(_penalty = 150) {
		__.text_color = #e93841;
		__.points	 -= _penalty;
		__.text_create("-", _penalty, __.text_color);
		return self;
	};
		
	save_highscores	  = function() {
		
		var _data	  = {
			version: GAME_VERSION,
			scores:  __.highscores,
		};
		
		var _string   = json_stringify(_data);
			_string   = base64_encode(_string);
		var _buffer   = buffer_create(string_byte_length(_string), buffer_grow, 1);
		
		buffer_seek(_buffer, buffer_seek_start, 0);
		buffer_write(_buffer, buffer_text, _string);
		
		var _compress = buffer_compress(_buffer, 0, buffer_get_size(_buffer))
		buffer_save(_compress, "highscores.buf");
		
		buffer_delete(_buffer);
		buffer_delete(_compress);
		
		return self;
	};
	load_highscores	  = function() {
		if (file_exists("highscores.buf")) {
			var _compress = buffer_load("highscores.buf");
			var _buffer   = buffer_decompress(_compress);
			
			if (_buffer == -1) exit;
		
			buffer_seek(_buffer, buffer_seek_start, 0);
			var _encoded = buffer_read(_buffer, buffer_text);
			var _string	 = base64_decode(_encoded);
			var _data	 = json_parse(_string);
		
			var _version = _data[$ "version"];
			if (_version != GAME_VERSION) {
				file_delete("highscores.buf");
				exit;
			}
		
			__.highscores = _data.scores;
		
			buffer_delete(_buffer);
			buffer_delete(_compress);
		}
		return self;
	};
	
	// private
	with (__) {
		text_create	= method(_self, function(_sign, _amount, _color = c_white) {
			floating_text_create(obj_car.x, obj_car.y, obj_car.depth, _sign + string(_amount), _color);
		});
		points		= 0;	
		points_last	= 0;
		text_color	= c_white;
		highscores	= {};
		
		// hooks
		round_finished_event	= method(_self, function(_data) {
			update_highscores();
		});
		round_finished_listener = undefined;
	};
	
	// events
	on_initialize(function() {
		__.round_finished_listener = SUBSCRIBE("round_finished", __.round_finished_event);
	});
	on_update	 (function() {
		depth = objc_veil.depth + 1;
	});
	on_render_gui(function() {
		if (objc_world.room_is_track()
		&& !objc_menu.is_active()) {
			static _scale = 1.5;
			var _color	  = c_white;
			var _text	  = string(__.points) + " pts";
			draw_text_transformed_color(23, 33, _text, _scale, _scale, 0, c_black, c_black, c_black, c_black, 1);
			draw_text_transformed_color(20, 30, _text, _scale, _scale, 0, _color, _color, _color, _color, 1);
		}
	});
	on_room_start(function() {
		__.points	  = 0;
		__.text_color = c_white;
		load_highscores();
	});
	on_cleanup	 (function() {
		UNSUBSCRIBE(__.round_finished_listener);
	});
	
	