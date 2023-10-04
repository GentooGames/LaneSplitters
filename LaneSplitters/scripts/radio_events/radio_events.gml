
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   __   __ ______   __   __   ______  ______    //
	// /\  ___\ /\ \ / //\  ___\ /\ "-.\ \ /\__  _\/\  ___\   //
	// \ \  __\ \ \ \'/ \ \  __\ \ \ \-.  \\/_/\ \/\ \___  \  //
	//  \ \_____\\ \__|  \ \_____\\ \_\\"\_\  \ \_\ \/\_____\ //
	//   \/_____/ \/_/    \/_____/ \/_/ \/_/   \/_/  \/_____/ //
	//                                                        //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//	list of global events that can be broadcasted to and
	//	subscribed to using the following global macros:
	//
	//	#macro BROADCAST	(event_name, payload = undefined)
	//  #macro SUBSCRIBE	(event_name, callback, weak_ref = true)
	//	#macro UNSUBSCRIBE	(subscriber, force_unsub = true)
	//
	//	every SUBSCRIBE call will return a listener instance, the
	//	listener instance needs to be manually cleaned-up/garbage
	//	collected using the UBSUBSCRIBE method.
	//
	//	example:
	//		listener = SUBSCRIBE("character_created", function(_data) {
	//			var _payload   =  data.payload;
	//			var _char = _payload;
	//			// do whatever with character instance...
	//		});
	//		
	//		on_cleanup(function() {
	//			UNSUBSCRIBE(listener);
	//		});
	//	
	function radio_events() {
		return [
			"character_spawned",
			/*	payload: {
					instance: <character_instance>,
					player:	  <character_owner_instance>,
					spawn:	  <spawn_point_instance>,
				}; */
			"character_death",
			/*	payload: {
					instance: <character_instance>,
				}; */
				
			"track_started",
			"countdown_started",
			"countdown_finished",
			"round_started",
			"round_finished",
		];
	};
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	