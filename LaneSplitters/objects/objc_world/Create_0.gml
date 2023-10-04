
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  __     __   ______   ______   __       _____    //
	// /\ \  _ \ \ /\  __ \ /\  == \ /\ \     /\  __-.  //
	// \ \ \/ ".\ \\ \ \/\ \\ \  __< \ \ \____\ \ \/\ \ //
	//  \ \__/".~\_\\ \_____\\ \_\ \_\\ \_____\\ \____- //
	//   \/_/   \/_/ \/_____/ \/_/ /_/ \/_____/ \/____/ //
	//                                                  //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	// objc_world.create //
	event_inherited();
	var _self = self;
	
	depth = 100;

	// public
	room_is_track	  = function(_room = room) {
		return (_room != __rm_init
			&&	_room != __rm_created_by
			&&	_room != __rm_headphones
		);
	};
	clear_tire_tracks = function() {
		if (!surface_exists(__.ground_surface_tracks)) {
			__.ground_surface_tracks = surface_create(room_width, room_height);	
		}
		surface_set_target(__.ground_surface_tracks);
		draw_clear_alpha(c_black, 0);
		surface_reset_target();
		return self;
	};
	
	// private
	with (__) {
		shadow_alpha		   = 0.6;
		shadow_strength		   = 2;
		shadow_direction	   = 340;
		tracks_alpha		   = 0.8;
		ground_surface_shadows = surface_create(room_width, room_height);	
		ground_surface_tracks  = surface_create(room_width, room_height);
	};
	
	// events
	on_room_start(function() {
		clear_tire_tracks();
		if (room_is_track()) {
			BROADCAST("track_started");
		}
	});
	on_render	 (function() {
		// tire tracks
		if (!surface_exists(__.ground_surface_tracks)) {
			__.ground_surface_tracks = surface_create(room_width, room_height);		
		}
		draw_surface_ext(__.ground_surface_tracks, 0, 0, 1, 1, 0, c_white, __.tracks_alpha);
		
		// shadows
		if (!surface_exists(__.ground_surface_shadows)) {
			__.ground_surface_shadows = surface_create(room_width, room_height);		
		}
		draw_surface_ext(__.ground_surface_shadows, 0, 0, 1, 1, 0, c_white, __.shadow_alpha);
		
		// wipe surface
		surface_set_target(__.ground_surface_shadows);
		draw_clear_alpha(c_black, 0);
		surface_reset_target();
	});
		
	// ambient sfx
	audio_play_sound(sfx_ambient_birds, -1, true);
	audio_play_sound(sfx_ambient_ocean, -1, true);