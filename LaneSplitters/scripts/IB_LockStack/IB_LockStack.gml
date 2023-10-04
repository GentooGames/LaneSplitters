
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  __       ______   ______   __  __    //
	// /\ \     /\  __ \ /\  ___\ /\ \/ /    //
	// \ \ \____\ \ \/\ \\ \ \____\ \  _"-.  //
	//  \ \_____\\ \_____\\ \_____\\ \_\ \_\ //
	//   \/_____/ \/_____/ \/_____/ \/_/\/_/ //
	//                                       //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function IB_LockStack(_config = {}) constructor {
		
		// public
		static set_lock		 = function(_lock_name, _lock_time = -1) {
			__.locks.set(_lock_name, _lock_time);
			if (_lock_time > 0) {
				__.updating = true;
			}
			return self;
		};
		static remove_lock	 = function(_lock_name) {
			__.locks.remove(_lock_name)
			if (__.locks.is_empty()) {
				__.updating = false;	
			}
			return self;
		};
		static contains_lock = function(_lock_name) {
			return __.locks.contains(_lock_name);	
		};
		static is_locked	 = function() {
			return __.locks.is_empty() == false;
		};
		static is_unlocked	 = function() {
			return __.locks.is_empty() == true;
		};
		
		// private
		__ = {};
		with (__) {
			initialized = false;
			active		= true;
			updating	= false;
			locks		= new IB_Collection_Struct();
		};
			
		// events
		static initialize = function() {
			__.initialized = true;
			return self;
		};
		static activate	  = function() {
			__.active = true;
			return self;
		};
		static deactivate = function() {
			__.active = false;
			return self;
		};
		static update	  = function() {
			if (__.initialized && __.active && __.updating) {
				for (var _i = __.locks.get_size() - 1; _i >= 0; _i--) {
					var _name =  __.locks.get_name(_i);
					var _time =  __.locks.get(_name);
					if (_time == undefined || _time < 0) continue;	
				
					// update time
					if (_time > 0) {
						_time--;
						set_lock(_name, _time);
					}
					// time expired remove lock
					else if (_time == 0) {
						remove_lock(_name);
					}
				};
			}
			return self;	
		};
		static cleanup	  = function() {
			// here for compatibility...
		};
	};
	
	