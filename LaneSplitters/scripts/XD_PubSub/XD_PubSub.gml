
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______  __  __   ______   __       __   ______   __  __   ______   ______    //
	// /\  == \/\ \/\ \ /\  == \ /\ \     /\ \ /\  ___\ /\ \_\ \ /\  ___\ /\  == \   //
	// \ \  _-/\ \ \_\ \\ \  __< \ \ \____\ \ \\ \___  \\ \  __ \\ \  __\ \ \  __<   //
	//  \ \_\   \ \_____\\ \_____\\ \_____\\ \_\\/\_____\\ \_\ \_\\ \_____\\ \_\ \_\ //
	//   \/_/    \/_____/ \/_____/ \/_____/ \/_/ \/_____/ \/_/\/_/ \/_____/ \/_/ /_/ //
	//                                                                               //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	/// @description Provides a consistent interface for registering and manipulating signal handlers.
	function XD_Publisher() constructor {
	
		#region Fields
	
		__channels = {};
		__lookup = {};
		__autoRegisterOnPublish = false;
		__autoRegisterOnSubscribe = false;
		__autoRemoveSubscriberOnTrigger = true; 
	
		#endregion
		#region Private Methods
		
		static registerSubscriber = function(_subscriber) {
		
			var _uid = _subscriber.uid;
		
			if (variable_struct_exists(__lookup, _uid)) {
				__lookup.remove = false;
				return;
			}
		
			__lookup[$ _uid] = _subscriber;
			array_push(__channels[$ _subscriber.get_channel()], _subscriber);
		}

		#endregion
		#region Public Methods
	
		/// @param {...string} channels The channel identifiers to be registered for this publisher.
		/// @note Only registered channel will allow subscriptions, otherwise they will be ignored.
		static register_channel = function() {
			var _eventName, _count = argument_count;
			repeat(_count) {
				_eventName = argument[--_count];
			
				if (variable_struct_exists(__channels, _eventName)) continue;
			
				__channels[$ _eventName] = [];
			}
			return self;
		}
	
		/// @param {string} channel The channel identifier used for registration.
		/// @returns {boolean}
		static has_registered_channel = function(_eventName) {
			return variable_struct_exists(__channels, _eventName);
		}
	
		/// @param {identifier} channel The the channel to be published into.
		/// @param {*} [params=undefined] The parameters to be passed into the callback function.
		static publish = function(_channel, _params) {
		
			// Check for autoRegisterOnPublish?
			if (__autoRegisterOnPublish) {
				if (!has_registered_channel(_channel)) {
					register_channel(_channel);	
				}
			}
		
			var _subscribers = __channels[$ _channel];
		
			// Throw more verbose error
			if (_subscribers == undefined) {
				show_error("ERROR in Publisher().publish() \"" + string(_channel) + "\" channel not registered", true);	
			}
		
			var _subscriber, _it = array_length(_subscribers);
			repeat(_it) {
				_subscriber = _subscribers[--_it];
		
				////////////////////////////////////////////////////////////////////
				// check for automatic Subscriber removal 
				var _remove = false;
				if (_subscriber.remove) {
					_remove = true;	
				}
				// if callback returns true boolean, remove self from lookup table
				else if (__autoRemoveSubscriberOnTrigger) {
					var _result = _subscriber.trigger(_params);	
					if (is_bool(_result) && _result) { 
						_remove = true;
					}
				}
				if (_remove) {
					array_delete(_subscribers, _it, 1);
					variable_struct_remove(__lookup, _subscriber.uid);
					continue;	
				}
			}	
		}
	
		/// @param {identifier} channel The channel to subscribe to.
		/// @param {method} callback Callback method to execute.
		/// @param {Bool} [weakRef=false] Whether or not a weak reference to the callback should be generated.
		/// @returns {Subscriber}
		static subscribe = function(_channel, _callback, _weakRef = false) {
		
			/// *** see Subscriber() for description of weakRef ***
		
			// Check for autoRegisterOnSubscribe?
			if (!variable_struct_exists(__channels, _channel)) {
				// Ignore if there is no event registered under 'eventName'
				if (!__autoRegisterOnSubscribe) {
					return undefined;
				}
				register_channel(_channel);
			}
		
			// Check if parameter 'callback' is callable
			if (!is_method(_callback)) {
				throw "[ERROR] Parameter 'callback' is not executable.";
			}
		
			// Check if subscriber already exists, that is flagged for removal, and unflag 'remove' if exists.
			var _uid = _channel + "_" + string(ptr(_callback));
			if (variable_struct_exists(__lookup, _uid)) {
				var _subscriber = __lookup[$ _uid];
				_subscriber.remove = false;
			}
		
			// Build observer as array (to avoid scope problems)
			else {
				var _subscriber = new XD_Subscriber(self, _channel, _callback, _weakRef);
			}
		
			// Return listeners (fetch from lookup table to avoid duplicates)
			return __lookup[$ _subscriber.uid];
		}
	
	    /// @param {struct.Subscriber} subscriber The subscriber to be unsubscribed.
	    /// @param {bool} force Whether or not the subscription should be removed on the current frame.
	    static unsubscribe = function(_subscriber, _force = false) {
        
	        if (instanceof(_subscriber) != "XD_Subscriber") {
	            throw "[ERROR] Parameter is an invalid 'XD_Subscriber' instance.";
	        }
        
	        var _uid = _subscriber.uid;
        
	        // Early exit if subscriber is not register with publisher.
	        if (!variable_struct_exists(__lookup, _uid)) return;
        
	        // If we want to force remove the subscription it will happen in the same frame
	        if (_force) {
            
	            var _channel = _subscriber.__channel;
	            var _subscribers = __channels[$ _channel];
            
	            var _it = array_length(_subscribers);
	            repeat(_it) {
	                if (_subscribers[--_it] == _subscriber) {
	                    array_delete(_subscribers, _it, 1);
	                    break;
	                }
	            }
	            return;
	        }
        
	        // Cancel subscriber and remove it from publisher.
	        _subscriber.cancel();
	    }

		/// @description Unsubscribes all the subscription to a given channel.
		/// @param {identifier} channel The channel to be cleared.
		static clear_channel = function(_channel) {
		
			var _subscribers = __channels[$ _channel];

			var _subscriber, _it = array_length(_subscribers);
			repeat(_it) {
				_subscriber = _subscriber[--_it];
				variable_struct_remove(__lookup, _subscriber.uid);
			}
		
			array_resize(_subscribers, 0);
		} 
	
		/// @description Check to see if the given channel has an existing subscription queued up.
		/// @param {identifier} channel The channel to be checked.
		static did_publish = function(_channel) {
		
			/// @note: a subscriber to the event must be established to determine if the event has
			///	been published. otherwise the publish will be discarded.
		
			var _subscribers = __channels[$ _channel];
		
			if (_subscribers == undefined) return false;
		
			return array_length(_subscribers) > 0;
		};
	
		#endregion
	};
	
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   __  __   ______   ______   ______   ______   __   ______   ______   ______    //
	// /\  ___\ /\ \/\ \ /\  == \ /\  ___\ /\  ___\ /\  == \ /\ \ /\  == \ /\  ___\ /\  == \   //
	// \ \___  \\ \ \_\ \\ \  __< \ \___  \\ \ \____\ \  __< \ \ \\ \  __< \ \  __\ \ \  __<   //
	//  \/\_____\\ \_____\\ \_____\\/\_____\\ \_____\\ \_\ \_\\ \_\\ \_____\\ \_____\\ \_\ \_\ //
	//   \/_____/ \/_____/ \/_____/ \/_____/ \/_____/ \/_/ /_/ \/_/ \/_____/ \/_____/ \/_/ /_/ //
	//                                                                                         //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	/// @description A class that describes a signal handler (should NOT be explicitly instantiated).
	/// @param {Publisher} publisher The publisher instance owning this subscriber.
	/// @param {identifier} channel The signal identifier to listen to.
	/// @param {method} callback The callback to be executed once signal is fired.
	/// @param {boolean} releaseRef Whether or not a weak reference to the callback should be generated.
	function XD_Subscriber(_publisher, _channel, _callback, _releaseRef) constructor {
		
		#region Fields
	
		__publisher = _publisher;
		__channel = _channel;
		__callback = _callback;
		__weakCallback = undefined;
		__releaseRef = _releaseRef;		/// releaseRef aka: weakref.
										/// vars are removed from memory if NO reference exists naturally.
										///	weakrefs do not count as an official reference to the var, so the var
										/// can still be deleted and removed from memory, even if a weakref may exist.
										///
										///	if releaseRef = true, and if the instance containing the callback method 
										///	is destroyed, then the subscribe callback is removed automatically because
										/// then it is considered a "dead" callback
										///
										/// if weakRef is false, then the system itself officially holds a reference
										/// to the callback, and therefore this (minimum) of 1 reference(s), will still 
										/// exist, keeping the callback alive in memory.
										///
										/// for example, if an instance is created briefly/one-off and has an associated
										/// Pub/Sub, then setting a weakRef would probably be best, so that the callback
										/// is cleaned up whenever the instance is cleaned up.
										///
										/// if releaseRef is set to false, then events need to be manually unsubscribed
										///	using the manual unsubscribe methods.
		#endregion
		#region Properties
	
		uid = string(_channel) + "_" + string(ptr(_callback));
	
		remove = false;
	
		#endregion
		#region Internal Methods
	
		/// @description Triggers the subscriber callback function (should NOT be explicitly called).
		/// @param {*} params The parameters to be passed into the callback function.
		static trigger = function(_params) {
		
			// Get the callback
			var _callback = get_callback();
		
			// Callback is invalid
			if (_callback == undefined) {
				show_debug_message("\"callback\" is undefined. Do you want this to be a non-weak reference?");
			    cancel();
			    return true;
			}
		
			// Execute callback
			return _callback(_params);
		}
	
		/// @decription Converts the callback into a indirect ref (should NOT be explicitly called).
		static release = function() {
			__weakCallback = weak_ref_create(__callback);
			__callback = undefined;
		}

		#endregion
		#region Public Methods
	
		/// @description Marks the subscription to be removed next execution.
		static cancel = function() {	
			remove = true;
		}
	
		#endregion
		#region Getters & Setters
	
		/// @decription Returns the callback associated with the event.
		/// @note Callbacks can be stored with an weakRef, If the callback is dead, 'undefined' is returned.
		static get_callback = function() {
			if (__callback != undefined) {
				return __callback;
			}
			return weak_ref_alive(__weakCallback) ? __weakCallback.ref : undefined;
		}

		/// @decription Returns the subscribed channel.
		static get_channel = function() {
			return __channel;
		}

		#endregion
		#region Initialization

		if (__releaseRef) release();
		__publisher.registerSubscriber(self);

		#endregion
	};
