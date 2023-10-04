
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  __   ______   ______   ______   ______   ______   ______    // 
	// /\ \ /\  ___\ /\  ___\ /\  == \ /\  ___\ /\  == \ /\  ___\   // 
	// \ \ \\ \ \____\ \  __\ \ \  __< \ \  __\ \ \  __< \ \ \__ \  // 
	//  \ \_\\ \_____\\ \_____\\ \_____\\ \_____\\ \_\ \_\\ \_____\ // 
	//   \/_/ \/_____/ \/_____/ \/_____/ \/_____/ \/_/ /_/ \/_____/ // 
	//																//
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	// obj_iceberg.user_event 15 //
	event_inherited();
	
	state_base = function() {
		return {
			enter:		function() {},
			begin_step:	function() {},
			step:		function() {},
			end_step:	function() {},
			draw:		function() {},
			draw_gui:	function() {},
			leave:		function() {},	
		};
	};
		state_systems_initialize = function() {
			return {
				enter: function() {
					__.state.fsm.inherit();
					__.radio.broadcast("systems_initializing");
					__.system.input.initialize();
				},
				step:  function() {
					__.state.fsm.inherit();	
					if (__.system.input.is_initialized()
					) {
						__.state.fsm.change("start_systems");
					}
				},
				leave: function() {
					__.state.fsm.inherit();	
					__.radio.broadcast("systems_initialized");
				},	
			};
		};
		state_systems_start		 = function() {
			return {
				enter: function() {
					__.state.fsm.inherit();	
					__.radio.broadcast("systems_starting");
				},
				step:  function() {
					__.state.fsm.inherit();	
				//	if (__.system.file.is_started()
				//	) {
						__.state.fsm.change("running");	
				//	}
				},
				leave: function() {
					__.state.fsm.inherit();	
					__.radio.broadcast("systems_ready");
				},
			};
		};
		state_running			 = function() {
			return {
				enter: function() {
					__.state.fsm.inherit();	
				},
				step:  function() {
					__.state.fsm.inherit();	
					__.system.input.update();
				},
				leave: function() {
					__.state.fsm.inherit();	
				},
			};
		};
	