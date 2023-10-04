
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   ______   __   __   ______  __   ______    //
	// /\  ___\ /\  __ \ /\ "-.\ \ /\  ___\/\ \ /\  ___\   //
	// \ \ \____\ \ \/\ \\ \ \-.  \\ \  __\\ \ \\ \ \__ \  //
	//  \ \_____\\ \_____\\ \_\\"\_\\ \_\   \ \_\\ \_____\ //
	//   \/_____/ \/_____/ \/_/ \/_/ \/_/    \/_/ \/_____/ //
	//                                                     //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	enum IB_LOG_FLAG {
		NONE		 = 1 << 0,
		ALL			 = 1 << 1,
		INSTANCES	 = 1 << 2,
		OBJECTS		 = 1 << 3,
		CONSTRUCTORS = 1 << 4,
		INPUT		 = 1 << 5,
		STATE		 = 1 << 6,
		GAME		 = 1 << 7,
		CAMERA		 = 1 << 8,
		PLAYER		 = 1 << 9,
		CHARACTER	 = 1 << 10,
	};
	
	global._IB_CONFIG = {
		meta:	  {
			version: "0.4.0",
		},
		log:	  {
			level: IB_LOG_FLAG.NONE,
		},
		internal: {
			systems: {},
			tests:   {},
		},
		public:	  {
			resources: {
				constructors: {},
				shaders:	  {},
			},
			templates: {
				constructors: {},
				objects:	  {
					state: {
						user_event: 15,	
					},
				},
			},
			utilities: {},
		},
	};

	#macro iceberg				obj_iceberg
	#macro IB_CONFIG			global._IB_CONFIG
	#macro IB_LOG_LEVEL			IB_CONFIG.log.level
	#macro PLAYER_OBJECT_INDEX	objc_player