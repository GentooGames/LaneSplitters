
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  __   __   ______   _____    ______    //
	// /\ "-.\ \ /\  __ \ /\  __-. /\  ___\   //
	// \ \ \-.  \\ \ \/\ \\ \ \/\ \\ \  __\   //
	//  \ \_\\"\_\\ \_____\\ \____- \ \_____\ //
	//   \/_/ \/_/ \/_____/ \/____/  \/_____/ //
	//                                        //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function IB_PathFinder_Node(_config = {}) : IB_Base(_config) constructor {
	
		#region [info]
	
		// do not manually instantiate node. 
		// create through IB_PathFinder.new_node()
	
		#endregion
		
		var _self = self;
		
		// = PUBLIC ====================
		static new_traversable_condition_from	 = function(_condition_name, _condition_method, _condition_params = undefined) {
			__.from_conditions.add(_condition_name, {
				condition_name:    _condition_name,
				condition_method:  _condition_method, 
				condition_params:  _condition_params,
			});
			return self;
		};
		static new_traversable_condition_to		 = function(_condition_name, _condition_method, _condition_params = undefined) {
			__.to_conditions.add( _condition_name, {
				condition_name:   _condition_name,
				condition_method: _condition_method, 
				condition_params: _condition_params,
			});
			return self;
		};
		static remove_traversable_condition_from = function(_name) {
			__.from_conditions.remove(_name);
			return self;
		};
		static remove_traversable_condition_to	 = function(_name) {
			__.to_conditions.remove(_name);
			return self;
		};
		
		static get_finder = function() {
			return __.finder;
		};
		static get_f_cost = function() {
			return __.g_cost + __.h_cost;
		};
		static get_g_cost = function() {
			return __.g_cost;
		};
		static get_h_cost = function() {
			return __.h_cost;
		};
		static get_i	  = function() {
			return __.i;
		};
		static get_j	  = function() {
			return __.j;
		};
		static get_k	  = function() {
			return __.k;
		};
		static get_parent = function() {
			return __.parent;
		};
		static get_weight = function() {
			return __.weight;
		};
		
		static set_finder = function(_finder) {
			__.finder = _finder;
			return self;
		};
		static set_g_cost = function(_g_cost) {
			__.g_cost = _g_cost;
			return self;
		};
		static set_h_cost = function(_g_cost) {
			__.h_cost = _h_cost;
			return self;
		};
		static set_i	  = function(_i) {
			__.i = _i;
			return self;
		};
		static set_j	  = function(_j) {
			__.j = _j;
			return self;
		};
		static set_k	  = function(_k) {
			__.k = _k;
			return self;
		};
		static set_parent = function(_parent) {
			__.parent = _parent;
			return self;
		};
		static set_weight = function(_weight) {
			__.weight = _weight;
			return self;
		};
	
		// = PRIVATE ===================
		with (__) {
			static __check_can_traverse_from = function(_instance, _node_to) {
				if (!__.can_traverse_from) return false;
				for (var _i = 0; _i < __.from_conditions.get_size(); _i++) {
					var _condition_name	  = __.from_conditions.get_name(_i);
					var _condition_data	  = __.from_conditions.get(_condition_name);
					var _condition_method = _condition_data.condition_method;
					var _condition_params = _condition_data.condition_params;
					var _condition_result = _condition_method(_instance, _node_to, _condition_params);
					if (_condition_result == false) return false;	
				};
				return true;
			};
			static __check_can_traverse_to	 = function(_instance, _node_from) {
				if (!__.can_traverse_to) return false;
				for (var _i = 0; _i < __.to_conditions.get_size(); _i++) {
					var _condition_name	  = __.to_conditions.get_name(_i);
					var _condition_data	  = __.to_conditions.get(_condition_name);
					var _condition_method = _condition_data.condition_method;
					var _condition_params = _condition_data.condition_params;
					var _condition_result = _condition_method(_instance, _node_from, _condition_params);
					if (_condition_result == false) return false;	
				};
				return true;
			};
			
			finder			  = _config[$ "finder"			 ] ?? other;
			i				  = _config[$ "i"				 ] ?? 0;
			j				  = _config[$ "j"				 ] ?? 0;
			k				  = _config[$ "k"				 ] ?? 0;
			weight			  = _config[$ "weight"			 ] ?? 1;
			can_traverse_from = _config[$ "can_traverse_from"] ?? true;
			can_traverse_to   = _config[$ "can_traverse_to"  ] ?? true;
			g_cost			  =  0;
			h_cost			  =  0;
			parent			  =  undefined; 
			from_conditions   =  new IB_Collection_Struct();
			to_conditions     =  new IB_Collection_Struct();
		};
			
		// = EVENTS ====================
		on_cleanup(function() {
			__.from_conditions.cleanup();
			__.to_conditions.cleanup();
		});
	};


