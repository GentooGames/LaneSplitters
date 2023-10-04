
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   __  __   ______   ______  ______   __    __    //
	// /\  ___\ /\ \_\ \ /\  ___\ /\__  _\/\  ___\ /\ "-./  \   //
	// \ \___  \\ \____ \\ \___  \\/_/\ \/\ \  __\ \ \ \-./\ \  //
	//  \/\_____\\/\_____\\/\_____\  \ \_\ \ \_____\\ \_\ \ \_\ //
	//   \/_____/ \/_____/ \/_____/   \/_/  \/_____/ \/_/  \/_/ //
	//                                                          //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function _IB_System(_config = {}) : IB_Base(_config) constructor {
		
		var _self = self;
	
		// = PUBLIC ================
		static start	   = function() {
			if (is_initialized()) {
				if (!__.starting && !__.started) {
					 __.starting = true;
					 __.state.fsm.change("starting");
				}
			}
			else initialize();
			return self;
		};
		static is_started  = function() {
			return __.started;	
		};
			
		// = RADIO =================
		static subscribe   = function(_event_name, _callback, _weak_ref = true) {
			return __.radio.subscribe(_event_name, _callback, _weak_ref);	
		};
		static unsubscribe = function(_subscriber, _force = true) {
			__.radio.unsubscribe(_subscriber, _force);
			return self;
		};
		
		// = PRIVATE ===============
		with (__) {
			started  = false;
			starting = false;
			clock	 = iceberg.clock_create();
			radio	 = new IB_Radio();
			state    = {};
			with (state) {
				fsm	= new SnowState("uninitialized",,{
					owner: other.root	
				});
				fsm.add("__", {
					enter:		function() {},
					begin_step:	function() {},
					step:		function() {},
					end_step:	function() {},
					draw_gui:	function() {},
					leave:		function() {},
				});
				fsm.add_child("__", "uninitialized");
				fsm.add_child("__", "starting",	   {
					enter: function() {
						__.state.fsm.inherit();
						__.starting = true;
					},
					step:  function() {
						__.state.fsm.inherit();
						__.state.fsm.change("running");
					},
					leave: function() {
						__.state.fsm.inherit();	
						__.started  = true;
						__.starting = false;
					},
				});
				fsm.add_child("__", "running");
			};
		};
			
		// = EVENTS ================
		on_initialize(function() {
			__.radio.initialize();
			__.clock.add_cycle_method(__.state.fsm.step		 );
			__.clock.add_begin_method(__.state.fsm.begin_step);
			__.clock.add_end_method	 (__.state.fsm.end_step  );
		});
		on_cleanup   (function() {
			iceberg.clock_destroy(__.clock);
			__.radio.cleanup();
		});
	};

	