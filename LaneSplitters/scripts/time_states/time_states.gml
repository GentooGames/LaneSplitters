
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______  __   __    __   ______    //
	// /\__  _\/\ \ /\ "-./  \ /\  ___\   //
	// \/_/\ \/\ \ \\ \ \-./\ \\ \  __\   //
	//    \ \_\ \ \_\\ \_\ \ \_\\ \_____\ //
	//     \/_/  \/_/ \/_/  \/_/ \/_____/ //
	//                                    //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function time_state_base() {
		//  ______   ______   ______   ______    //
		// /\  == \ /\  __ \ /\  ___\ /\  ___\   //
		// \ \  __< \ \  __ \\ \___  \\ \  __\   //
		//  \ \_____\\ \_\ \_\\/\_____\\ \_____\ //
		//   \/_____/ \/_/\/_/ \/_____/ \/_____/ //
		//                                       //
		return {
			enter: function() {},
			step:  function() {},
			leave: function() {},
			draw:  function() {},
		};
	};
	/**/function time_state_idle() {
			//  __   _____    __       ______    //
			// /\ \ /\  __-. /\ \     /\  ___\   //
			// \ \ \\ \ \/\ \\ \ \____\ \  __\   //
			//  \ \_\\ \____- \ \_____\\ \_____\ //
			//   \/_/ \/____/  \/_____/ \/_____/ //
			//                                   //
			return {
				enter: function() {
					__.state.fsm.inherit();
					__.countdown_timer = __.countdown_time;
					__.round_timer	   = __.round_time;
				},
				step:  function() {
					__.state.fsm.inherit();
				},
				leave: function() {
					__.state.fsm.inherit();
				},
				draw:  function() {
					__.state.fsm.inherit();
				},
			};
		};
	/**/function time_state_countdown() {
			//  ______   ______   __  __   __   __   ______   //
			// /\  ___\ /\  __ \ /\ \/\ \ /\ "-.\ \ /\__  _\  //
			// \ \ \____\ \ \/\ \\ \ \_\ \\ \ \-.  \\/_/\ \/  //
			//  \ \_____\\ \_____\\ \_____\\ \_\\"\_\  \ \_\  //
			//   \/_____/ \/_____/ \/_____/ \/_/ \/_/   \/_/  //
			//                                                //
			return {
				enter: function() {
					__.state.fsm.inherit();
					__.countdown_timer = __.countdown_time;
					__.round_timer	   = __.round_time;
					BROADCAST("countdown_started");
				},
				step:  function() {
					__.state.fsm.inherit();
					
					// done with countdown
					__.countdown_timer--;
					if (__.countdown_timer <= 0) {
						__.state.fsm.change("round");	
					}
					
					// play sfx
					if (__.countdown_timer mod SECOND == 0) {
						var _pitch = (__.countdown_timer == 0) ? 1.5 : 1.0;
						audio_sound_pitch(sfx_countdown_time, _pitch);
						audio_play_sound (sfx_countdown_time, 3, 0);	
					}
				},
				
				leave: function() {
					__.state.fsm.inherit();
					__.countdown_timer = 0;
					BROADCAST("countdown_finished");
				},
				draw:  function() {
					__.state.fsm.inherit();
					__.draw_round_time();
					__.draw_countdown();	
				},
			};
		};
	/**/function time_state_round() {
			//  ______   ______   __  __   __   __   _____    //
			// /\  == \ /\  __ \ /\ \/\ \ /\ "-.\ \ /\  __-.  //
			// \ \  __< \ \ \/\ \\ \ \_\ \\ \ \-.  \\ \ \/\ \ //
			//  \ \_\ \_\\ \_____\\ \_____\\ \_\\"\_\\ \____- //
			//   \/_/ /_/ \/_____/ \/_____/ \/_/ \/_/ \/____/ //
			//                                                //
			return {
				enter: function() {
					__.state.fsm.inherit();
					__.round_timer = __.round_time;
					BROADCAST("round_started");
				},
				step:  function() {
					__.state.fsm.inherit();
					
					// done with round
					__.round_timer--;
					if (__.round_timer <= 0) {
						__.state.fsm.change("finished");	
					}
					
					// play sfx
					if (__.round_timer <= 5 * SECOND
					&&	__.round_timer mod SECOND == 0
					) {
						audio_play_sound(sfx_time_expire, 3, 0);	
					}
				},
				leave: function() {
					__.state.fsm.inherit();
					__.round_timer = 0;
				},
				draw:  function() {
					__.state.fsm.inherit();
					__.draw_round_time();
				},
			};
		};
	/**/function time_state_finished() {
			//  ______  __   __   __   __   ______   __  __    //
			// /\  ___\/\ \ /\ "-.\ \ /\ \ /\  ___\ /\ \_\ \   //
			// \ \  __\\ \ \\ \ \-.  \\ \ \\ \___  \\ \  __ \  //
			//  \ \_\   \ \_\\ \_\\"\_\\ \_\\/\_____\\ \_\ \_\ //
			//   \/_/    \/_/ \/_/ \/_/ \/_/ \/_____/ \/_/\/_/ //
			//                                                 //
			return {
				enter: function() {
					__.state.fsm.inherit();
					BROADCAST("round_finished");
				},
				step:  function() {
					__.state.fsm.inherit();
				},
				leave: function() {
					__.state.fsm.inherit();
				},
				draw:  function() {
					__.state.fsm.inherit();
					__.draw_round_time();
				},
			};
		};