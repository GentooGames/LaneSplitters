
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   ______  ______   __   __   __   ______    //
	// /\  ___\ /\  == \/\  == \ /\ \ /\ "-.\ \ /\  ___\   //
	// \ \___  \\ \  _-/\ \  __< \ \ \\ \ \-.  \\ \ \__ \  //
	//  \/\_____\\ \_\   \ \_\ \_\\ \_\\ \_\\"\_\\ \_____\ //
	//   \/_____/ \/_/    \/_/ /_/ \/_/ \/_/ \/_/ \/_____/ //
	//                                                     //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function IB_Spring(_config = {}) : IB_Base(_config) constructor {
			
		// = PUBLIC ================
		static fire = function(_amount) {
			__.delta = _amount;
			return self;
		};
		static get  = function() {
			return __.value;	
		};
		
		// = PRIVATE ===============
		with (__) {
			static __process = function() {
				__.delta += (__.tension * (__.target - __.value)) - (__.dampening * __.delta);
				__.value +=  __.delta;
			};
			static __cutoff	 = function() {
				if (abs(__.value) <= __.cutoff) {
					__.value = 0;	
				}
			};
			
			tension   = _config[$ "tension"	 ] ?? 0.15;
			dampening = _config[$ "dampening"] ?? 0.15;
			cutoff	  = _config[$ "cutoff"	 ] ?? 0.001;
			delta	  =  0;
			target	  =  0;
			value	  =  0;
		};
		
		// = EVENTS ================
		on_update(function() {
			__process();
			__cutoff();
		});
	};
	