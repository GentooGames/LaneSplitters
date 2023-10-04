
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   ______   _____    __   ______    //
	// /\  == \ /\  __ \ /\  __-. /\ \ /\  __ \   //
	// \ \  __< \ \  __ \\ \ \/\ \\ \ \\ \ \/\ \  //
	//  \ \_\ \_\\ \_\ \_\\ \____- \ \_\\ \_____\ //
	//   \/_/ /_/ \/_/\/_/ \/____/  \/_/ \/_____/ //
	//                                            //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	// objc_radio.create //
	event_inherited();
	var _self = self;
		
	// public
	broadcast	= function(_event_name, _payload = undefined) {
		__.radio.broadcast(_event_name, _payload);
		return self;
	};
	subscribe	= function(_event_name, _callback, _weak_ref = true) {
		return __.radio.subscribe(_event_name, _callback, _weak_ref);
	};
	unsubscribe = function(_subscriber, _force = true) {
		__.radio.unsubscribe(_subscriber, _force);
		return self;
	};
	
	// private
	with (__) {
		radio = new IB_Radio();		
		
		// register global events
		var _events = radio_events();
		for (var _i = 0, _len = array_length(_events); _i < _len; _i++) {
			radio.register(_events[_i]);
		};
	};
	
	// events
	on_initialize(function() {
		__.radio.initialize();
	});
	on_cleanup	 (function() {
		__.radio.cleanup();
	});
	