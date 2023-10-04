
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   __       ______   ______   ______   __        //
	// /\  ___\ /\ \     /\  __ \ /\  == \ /\  __ \ /\ \       //
	// \ \ \__ \\ \ \____\ \ \/\ \\ \  __< \ \  __ \\ \ \____  //
	//  \ \_____\\ \_____\\ \_____\\ \_____\\ \_\ \_\\ \_____\ //
	//   \/_____/ \/_____/ \/_____/ \/_____/ \/_/\/_/ \/_____/ //
	//                                                         //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	#macro DEV				true
	#macro GAME_NAME		"Dead Tire"
	#macro GAME_VERSION		"v0.2.1"
	
	#macro COUNTDOWN_TIME	(DEV ? (0.5 * 60) : (4  * 60))
	#macro DRIVE_TIME		(DEV ? (30  * 60) : (30 * 60))
	#macro BONUS_TIME		(DEV ? (10  * 60) : (10 * 60))
	#macro CREATED_BY_TIME	(DEV ? (0.5 * 60) : (4  * 60))
	#macro MUSIC_TIME		(DEV ? (0.5 * 60) : (5  * 60))
	
	if (DEV) audio_master_gain(0);
	
	////////////////////////////////////////////////////////////
	
	#macro GAME_DATA global.game_data
	#macro SETTINGS	 global.settings
	
	////////////////////////////////////////////////////////////
	
	#macro SECOND		(room_speed)
	#macro MINUTE		(SECOND * 60)
	
	#macro BROADCAST	objc_radio.broadcast
	#macro SUBSCRIBE	objc_radio.subscribe
	#macro UNSUBSCRIBE	objc_radio.unsubscribe
	
	#macro SURF_W		surface_get_width (application_surface)
	#macro SURF_H		surface_get_height(application_surface)
