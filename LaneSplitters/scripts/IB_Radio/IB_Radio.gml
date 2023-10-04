
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   ______   _____    __   ______    //
	// /\  == \ /\  __ \ /\  __-. /\ \ /\  __ \   //
	// \ \  __< \ \  __ \\ \ \/\ \\ \ \\ \ \/\ \  //
	//  \ \_\ \_\\ \_\ \_\\ \____- \ \_\\ \_____\ //
	//   \/_/ /_/ \/_/\/_/ \/____/  \/_/ \/_____/ //
	//                                            //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function IB_Radio(_config = {}) : IB_Base(_config) constructor {
	
		// a radio contains a set of channels, that can be broadcasted 
		// to, and/or subscribed to. broadcasting to a channel will 
		// immediately transmit the signal to every listener that has 
		// previously subscribed to that same channel.
		// subscribing to a channel creates a listener object. by default
		// this object needs to be manually unsubscribed from the radio
		// using the unsubscribe method. failing to do so may result in
		// a memory leak. it is best to just include the unsubscribe
		// method call in the owning object's on_cleanup()
		
		// see Publisher-Subscriber design pattern
		// https://en.wikipedia.org/wiki/Publish–subscribe_pattern
	
		var _self = self;
	
		// public
		static register    = function(/* event_name_1, ..., event_name_n */) {
			if (__.publisher != undefined) {
				for (var _i = 0; _i < argument_count; _i++) {
					__.publisher.register_channel(argument[_i]);
				}
			}
			return self;
		};
		static broadcast   = function(_event_name, _payload = undefined) {
		
			// <data_struct>: {
			// 	 radio:    self,
			// 	 instance: owner,
			// 	 payload:  <any>,
			// }
			
			if (__.publisher != undefined) {
				var _self  = self;
				var _owner = get_owner();
				var _data  = {
					radio:	  _self,
					instance: _owner,
					payload:  _payload,
				}
				__.publisher.publish(_event_name, _data);
			}
			return self;
		};
		static subscribe   = function(_event_name, _callback, _weak_ref = true) {
		
			// if weak_ref = true, then the publisher/subscriber will not keep track
			// of the method reference. this means that methods not bound to any other
			// variable will be automatically waste collected. methods that need to
			// exist with the lifespan of its associated instance, should have those
			// methods stored in an instance variable.
		
			if (__.publisher != undefined) {
				return __.publisher.subscribe(_event_name, _callback, _weak_ref);
			}
			return undefined;
		};
		static unsubscribe = function(_subscriber, _force = true) {
			if (__.publisher != undefined) {
				__.publisher.unsubscribe(_subscriber, _force);
			}
			return self;
		};
	
		// private
		with (__) {
			publisher = new XD_Publisher();
		
			// if false, events not registered before a publish will cause 
			// a crash. having this set to false can be useful for catching 
			// event_name typos. set to true for more flexibile usage that 
			// will automatically register a new event if a channel with 
			// that name doesnt exist.
			publisher.__autoRegisterOnPublish = false;	
														
			// if false, events not registered before a subscribe will fail
			// silently. having this set to false can be useful for preventing 
			// event_name typos. set to true for more flexibile usage that 
			// will automatically register a new event if a channel with the 
			// name doesnt exist.
			publisher.__autoRegisterOnSubscribe = false;	
		
			// if true, whenever an event callback executes after being 
			// triggered by a listener, if that callback returns a boolean 
			// True value, then the event listener will automatically remove 
			// itself from the subscription. this can be useful for creating 
			// one-time-execution events that auto cleanup. if this is true, 
			// and your callback function returns true, then the event will 
			// be destroyed.
			publisher.__autoRemoveSubscriberOnTrigger = true;
		}													
			
		// events
		on_initialize(function(_data) {
			var _channels  = _data.data;
			if (_channels !=  undefined) {
				iceberg.array.for_each(
					_channels,
					function(_channel) {
						register(_channel);	
					},
				);
			}
		}, _config[$ "channels"])
	};
