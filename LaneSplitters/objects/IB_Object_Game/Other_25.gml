
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   ______   __    __   ______    //
	// /\  ___\ /\  __ \ /\ "-./  \ /\  ___\   //
	// \ \ \__ \\ \  __ \\ \ \-./\ \\ \  __\   //
	//  \ \_____\\ \_\ \_\\ \_\ \ \_\\ \_____\ //
	//   \/_____/ \/_/\/_/ \/_/  \/_/ \/_____/ //
	//                                         //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	// IB_Object_Game.user_event_15 //
	event_inherited();
	
	state_base = function() {
		return {
			enter:	  function() {},
			step:	  function() {},
			draw_gui: function() {},	
			leave:	  function() {},
		};
	};
		state_idle = function() {
			return {};	
		};