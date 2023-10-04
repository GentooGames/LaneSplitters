
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  __    __   ______   __   __ ______   ______   ______  ______   ______   _____    //
	// /\ "-./  \ /\  __ \ /\ \ / //\  ___\ /\  ___\ /\  == \/\  ___\ /\  ___\ /\  __-.  //
	// \ \ \-./\ \\ \ \/\ \\ \ \'/ \ \  __\ \ \___  \\ \  _-/\ \  __\ \ \  __\ \ \ \/\ \ //
	//  \ \_\ \ \_\\ \_____\\ \__|  \ \_____\\/\_____\\ \_\   \ \_____\\ \_____\\ \____- //
	//   \/_/  \/_/ \/_____/ \/_/    \/_____/ \/_____/ \/_/    \/_____/ \/_____/ \/____/ //
	//                                                                                   //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function _IB_MoveController_TopDown_MoveSpeed(_config = {}) : IB_Base(_config) constructor {
	
		// = PUBLIC ================
		static condition_check = function() {
			if (__.condition == undefined) {
				return false;	
			}
			return __.condition(get_owner());
		};
		static get_condition   = function() {
			return __.condition;	
		};
		static get_speed	   = function() {
			return __.speed;	
		};						
		static set_condition   = function(_condition) {
			__.condition = _condition;
			return self;
		};
		static set_speed	   = function(_speed) {
			__.speed = _speed;
			return self;
		};
		
		// = PRIVATE ===============
		with (__) {
			condition = _config[$ "condition"] ?? undefined;
			speed	  = _config[$ "speed"	 ] ?? 0;	
		};
	};
	