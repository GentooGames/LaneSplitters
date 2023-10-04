
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  __    __   ______   __   __ ______   ______   ______  ______  //
	// /\ "-./  \ /\  __ \ /\ \ / //\  ___\ /\  ___\ /\  ___\/\__  _\ //
	// \ \ \-./\ \\ \ \/\ \\ \ \'/ \ \  __\ \ \___  \\ \  __\\/_/\ \/ //
	//  \ \_\ \ \_\\ \_____\\ \__|  \ \_____\\/\_____\\ \_____\ \ \_\ //
	//   \/_/  \/_/ \/_____/ \/_/    \/_____/ \/_____/ \/_____/  \/_/ //
	//                                                                //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function _IB_MoveController_TopDown_MoveSet(_config = {}) : IB_Base(_config) constructor {
	
		// = PUBLIC ================
		static condition_check		= function() {
			if (__.condition == undefined) {
				return false;	
			}
			return __.condition(get_owner());
		};
		static get_acceleration		= function() {
			return __.acceleration;	
		};						
		static get_condition		= function() {
			return __.condition;	
		};						
		static get_friction			= function() {
			return __.friction;	
		};						
		static get_speed_multiplier	= function() {
			return __.speed_multiplier;	
		};						
		static set_acceleration		= function(_acceleration) {
			__.acceleration = _acceleration;
			return self;
		};
		static set_condition		= function(_condition) {
			__.condition = _condition;
			return self;
		};
		static set_friction			= function(_friction) {
			__.friction = _friction;
			return self;
		};
		static set_speed_multiplier = function(_speed_multiplier) {
			__.speed_multiplier = _speed_multiplier;
			return self;
		};
		
		// = PRIVATE ===============
		with (__) {
			acceleration	 = _config[$ "acceleration"	   ] ?? 0;
			condition		 = _config[$ "condition"	   ] ?? undefined;
			friction		 = _config[$ "friction"		   ] ?? 0;
			speed_multiplier = _config[$ "speed_multiplier"] ?? 1;
		};
	};
	