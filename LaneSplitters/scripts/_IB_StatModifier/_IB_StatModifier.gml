
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  __    __   ______   _____    __   ______  __   ______   ______    //
	// /\ "-./  \ /\  __ \ /\  __-. /\ \ /\  ___\/\ \ /\  ___\ /\  == \   //
	// \ \ \-./\ \\ \ \/\ \\ \ \/\ \\ \ \\ \  __\\ \ \\ \  __\ \ \  __<   //
	//  \ \_\ \ \_\\ \_____\\ \____- \ \_\\ \_\   \ \_\\ \_____\\ \_\ \_\ //
	//   \/_/  \/_/ \/_____/ \/____/  \/_/ \/_/    \/_/ \/_____/ \/_/ /_/ //
	//                                                                    //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function __IB_StatModifier(_config = {}) constructor {
	
		var _owner = other;
	
		// public
		static get		= function() {
			return __.value;
		};
		static get_type = function() {
			return _TYPE;
		};
		static remove	= function() {
			__.owner.remove_modifier(__.name, self);
		};
		static tick		= function() {
			if (__.duration > 0) {
				__.duration = max(__.duration - __.cost, 0);
			}
			else if (__.duration > -1) {
				__.duration = 0;
				remove();
			}
			return self;
		};
	
		// private
		__ = {};
		with (__) {
			cost	 = _config[$ "cost"	   ] ??  1;	
			duration = _config[$ "duration"] ?? -1;	
			name	 = _config[$ "name"	   ] ?? "";
			owner	 = _config[$ "owner"   ] ?? _owner;
			value	 = _config[$ "value"   ] ??  0;	
		};
	};
	function __IB_StatModifier_Additive(_config = {}) : __IB_StatModifier(_config) constructor {
		static _TYPE = "additive";
	};
	function __IB_StatModifier_Scalar  (_config = {}) : __IB_StatModifier(_config) constructor {
	
		static _TYPE = "scalar";
	
		// public
		static get = function() {
			if (__.relative) {
				return owner.__.value * __.value;
			}
			return __.base * __.value;
		};
	
		// private
		with (__) {
			base	 = _config[$ "base"	   ] ?? owner.__.value;
			relative = _config[$ "relative"] ?? false;
		};
	};
	function __IB_StatModifier_Override(_config = {}) : __IB_StatModifier(_config) constructor {
		static _TYPE = "override";
	};
	