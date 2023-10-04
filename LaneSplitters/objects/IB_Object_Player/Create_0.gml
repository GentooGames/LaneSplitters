
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______  __       ______   __  __   ______   ______    //
	// /\  == \/\ \     /\  __ \ /\ \_\ \ /\  ___\ /\  == \   //
	// \ \  _-/\ \ \____\ \  __ \\ \____ \\ \  __\ \ \  __<   //
	//  \ \_\   \ \_____\\ \_\ \_\\/\_____\\ \_____\\ \_\ \_\ //
	//   \/_/    \/_____/ \/_/\/_/ \/_____/ \/_____/ \/_/ /_/ //
	//                                                        //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	// IB_Object_Player.create //
	event_inherited();
	var _self = self;
	
	// public
	subscribe			 = function(_event_name, _callback, _weak_ref = true) {
		__.log("radio subscribed to event: " + _event_name, IB_LOG_FLAG.PLAYER);
		return __.radio.subscribe(_event_name, _callback, _weak_ref);
	};
	unsubscribe			 = function(_subscriber, _force = true) {
		__.radio.unsubscribe(_subscriber, _force);
		return self;
	};
	input_add_device	 = function(_input_device) {
		array_push(__.input_devices, _input_device);
		__.radio.broadcast("input_device_added", _input_device);
		__.log("input device added: " + instanceof(_input_device), IB_LOG_FLAG.PLAYER);
		return self;
	};
	input_get_devices	 = function() {
		return __.input_devices;
	};
	input_get_profile	 = function() {
		return __.input_profile;
	};
	input_get_port_index = function() {
		return __.input_port_index;
	};
	input_has_device	 = function(_input_device = undefined) {
		if (_input_device == undefined) {
			return array_length(__.input_devices) > 0;	
		}
		for (var _i = 0, _len_i = array_length(__.input_devices); _i < _len_i; _i++) {
			if (__.input_devices[_i] == _input_device) {
				return true;	
			}
		};
		return false;
	};
	input_has_devices	 = function() {
		return (__.input_devices != undefined
			&&	array_length(__.input_devices) > 0
		);
	};
	input_has_gamepad	 = function() {
		
		if (__.input_devices == undefined)		 return false;
		if (array_length(__.input_devices) == 0) return false;
		
		for (var _i = 0, _len_i = array_length(__.input_devices); _i < _len_i; _i++) {
			var _input_device = __.input_devices[_i];
			if (_input_device.get_type() == "gamepad") {
				return true;	
			}
		};
		return false;
	}; 
	input_set_devices	 = function(_input_devices) {
		__.input_devices = _input_devices;
		return self;
	};
	input_remove_device  = function(_input_device) {
		iceberg.array.find_delete(__.input_devices, _input_device);
		__.radio.broadcast("input_device_removed", _input_device);
		__.log("input device removed: " + instanceof(_input_device), IB_LOG_FLAG.PLAYER);
		return self;
	};

	// private
	with (__) {
		radio = new IB_Radio();
		radio.register(
			"input_device_added",
			"input_device_removed",
		);
		input_devices			= _self[$ "input_devices"   ] ?? [];
		input_profile			= _self[$ "input_profile"   ] ?? undefined;
		input_port_index		= _self[$ "input_port_index"] ?? 0;
		device_removed_event	=  method(_self, function(_data) {
			var _device_data = _data.payload;
			var _device		 = _device_data.device;
			if (input_has_device(_device)) {
				input_remove_device(_device);
			}
		});
		device_removed_listener =  undefined;
		
		variable_struct_remove(_self, "input_devices"	);
		variable_struct_remove(_self, "input_profile"	);
		variable_struct_remove(_self, "input_port_index");
	};
	
	// events
	on_initialize(function() {
		__.radio.initialize();
		__.device_removed_listener = iceberg.input.subscribe("device_removed", __.device_removed_event);
		var _devices  = iceberg.input.port_get_devices(__.input_port_index);
		if (_devices != undefined) {
			__.input_devices = _devices;
		}
	});
	on_cleanup   (function() {
		__.radio.cleanup();
		iceberg.input.unsubscribe(__.device_removed_listener);
	});

	