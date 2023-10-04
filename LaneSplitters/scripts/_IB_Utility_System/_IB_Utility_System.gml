
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   __  __   ______   ______  ______   __    __    //
	// /\  ___\ /\ \_\ \ /\  ___\ /\__  _\/\  ___\ /\ "-./  \   //
	// \ \___  \\ \____ \\ \___  \\/_/\ \/\ \  __\ \ \ \-./\ \  //
	//  \/\_____\\/\_____\\/\_____\  \ \_\ \ \_____\\ \_\ \ \_\ //
	//   \/_____/ \/_____/ \/_____/   \/_/  \/_____/ \/_/  \/_/ //
	//                                                          //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function _IB_Utility_System() constructor {
	
		static error   = function(/* format, param_1, ..., param_n */) {
			static _prefix = "ERROR. ";
			static _suffix = "";
		
			if (1) {
				var _params = array_create(argument_count);
				for (var i = 0; i < argument_count; i++) {
					_params[i] = argument[i];
				}
				var _builder = method_get_index(iceberg.text.build);
				var _output  = script_execute_ext(_builder, _params);
				show_error("[" + string(iceberg.control.this.__frame) + "]: " + _prefix + _output + _suffix, true);
			}
		};
		static log	   = function(/* format, param_1, ..., param_n */) {
			static _prefix = "";
			static _suffix = "";
		
			if (1) {
				var _params = array_create(argument_count);
				for (var i = 0; i < argument_count; i++) {
					_params[i] = argument[i];
				}
				var _builder = method_get_index(iceberg.text.build);
				var _output  = script_execute_ext(_builder, _params);
			
				show_debug_message("[" + string(iceberg.control.this.__frame) + "]: " + _prefix + _output + _suffix);
			}
		};
		static print   = function(/* format, param_1, ..., param_n */) {
			static _prefix = "";
			static _suffix = "";
		
			if (1) {
				var _params = array_create(argument_count);
				for (var i = 0; i < argument_count; i++) {
					_params[i] = argument[i];
				}
				var _builder = method_get_index(iceberg.text.build);
				var _output  = script_execute_ext(_builder, _params);
				show_message("[" + string(iceberg.control.this.__frame) + "]: " + _prefix + _output + _suffix);
			}
		};
		static warning = function(/* format, param_1, ..., param_n */) {
			static _prefix = "WARNING. ";
			static _suffix = "";
		
			if (1) {
				var _params = array_create(argument_count + 1);
				for (var i = 0; i < argument_count; i++) {
					_params[i] = argument[i];
				}
				var _builder = method_get_index(iceberg.text.build);
				var _output  = script_execute_ext(_builder, _params);
				show_debug_message("[" + string(iceberg.control.this.__frame) + "]: " + _prefix + _output + _suffix);
			}
		};
	};

