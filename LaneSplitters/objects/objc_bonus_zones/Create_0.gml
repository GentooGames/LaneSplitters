
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   ______   __   __   __  __   ______    //
	// /\  == \ /\  __ \ /\ "-.\ \ /\ \/\ \ /\  ___\   //
	// \ \  __< \ \ \/\ \\ \ \-.  \\ \ \_\ \\ \___  \  //
	//  \ \_____\\ \_____\\ \_\\"\_\\ \_____\\/\_____\ //
	//   \/_____/ \/_____/ \/_/ \/_/ \/_____/ \/_____/ //
	//                                                 //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	// objc_bonus_zones.create //
	event_inherited();
	
	var _self = self;
	
	// private 
	with (__) {
		bonus_host = undefined;	
	};
	
	// events
	on_update	(function() {
		// spawn bonus zones
		if (__.bonus_host == undefined
		&&	objc_time.get_state() == "round"
		&&	objc_time.get_time_remaining() < BONUS_TIME
		) {
			__.bonus_host = instance_furthest(obj_car.x, obj_car.y, obj_bonus_zone_option);
			var _zone = instance_create_layer(__.bonus_host.x, __.bonus_host.y, "Triggers", obj_bonus_zone);
				_zone.image_xscale = __.bonus_host.image_xscale;
				_zone.image_yscale = __.bonus_host.image_yscale;
		}	
	});
	on_room_start(function() {
		__.bonus_host = undefined;
	});
	