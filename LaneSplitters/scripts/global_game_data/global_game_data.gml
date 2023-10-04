
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   ______   __    __   ______    //
	// /\  ___\ /\  __ \ /\ "-./  \ /\  ___\   //
	// \ \ \__ \\ \  __ \\ \ \-./\ \\ \  __\   //
	//  \ \_____\\ \_\ \_\\ \_\ \ \_\\ \_____\ //
	//   \/_____/ \/_/\/_/ \/_/  \/_/ \/_____/ //
	//                                         //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	global.game_data = {};
	with (global.game_data) {
		draw	  = {
			circle: {
				precision: 12,	
			},
			colors: {
				red:	#e92f34,
				blue:	#2f63e9,
				green:  #40dc3e,
				yellow:	#efb82d,
				white:  #F9EBE2
			},
			shadow: {
				max_z: 100,
				alpha: 0.6,
			},
		};
		save	  = {
			player: {
				profiles: {
					path: {
						prefix:   "player/profiles/",
						filetype: ".buff",
					},
				},
			},
			map: {
				images: {
					path: {
						prefix:   "map/images/",
						filetype: "",
					},
				},
			},
		};
		player	  = {
			count: 4,
			colors:	[
 				GAME_DATA.draw.colors.red, 
 				GAME_DATA.draw.colors.blue, 
 				GAME_DATA.draw.colors.green, 
 				GAME_DATA.draw.colors.yellow, 
 			],
		};
		character = {
			select: {
				countdown: {
					time: 1,	
				},
			},
		};
	};
	