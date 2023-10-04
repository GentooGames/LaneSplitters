	
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   __  __   ______   __   __ ______    //
	// /\  ___\ /\ \/\ \ /\  == \ /\ \ / //\  ___\   //
	// \ \ \____\ \ \_\ \\ \  __< \ \ \'/ \ \  __\   //
	//  \ \_____\\ \_____\\ \_\ \_\\ \__|  \ \_____\ //
	//   \/_____/ \/_____/ \/_/ /_/ \/_/    \/_____/ //
	//                                               //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function IB_AnimationCurve(_config = {}) : IB_Base(_config) constructor {
		
		// = PUBLIC ================
		static get_value	   = function(_channel_id = __.channel, _t) {
			var _channel = animcurve_get_channel(__.curve, _channel_id);
			return animcurve_channel_evaluate(_channel, abs(_t));
		};
		static set_curve	   = function(_curve_index) {
			__.curve = _curve_index;
			return self;
		};
		static set_channel	   = function(_channel_id) {
			__.channel = _channel_id;
			return self;
		};
		static set_iterator	   = function(_iterator) {
			__.iterator = _iterator;
			return self;
		};
		
		// = PRIVATE ===============
		with (__) {
			curve	 = _config[$ "curve"   ] ?? undefined;
			channel	 = _config[$ "channel" ] ?? 0;
		};
	};
	
	
