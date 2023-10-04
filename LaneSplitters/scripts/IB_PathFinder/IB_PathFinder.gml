
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   ______   ______  ______   ______    //
	// /\  __ \ /\  ___\ /\__  _\/\  __ \ /\  == \   //
	// \ \  __ \\ \___  \\/_/\ \/\ \  __ \\ \  __<   //
	//  \ \_\ \_\\/\_____\  \ \_\ \ \_\ \_\\ \_\ \_\ //
	//   \/_/\/_/ \/_____/   \/_/  \/_/\/_/ \/_/ /_/ //
	//                                               //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function IB_PathFinder(_config = {}) : IB_Base(_config) constructor {
	
		#region [info]
	
		// original Unity code by Sebastian Lague 
		// https://github.com/SebLague/Pathfinding
	
		#endregion
		#region coords 
		
		static __COORDS_4DIR = [
			[-1,  0,  0], [-1,  0,  1], [-1,  0, -1], [ 1,  0,  0], 
			[ 1,  0,  1], [ 1,  0, -1], [ 0, -1,  0], [ 0, -1,  1], 
			[ 0, -1, -1], [ 0,  1,  0], [ 0,  1,  1], [ 0,  1, -1],
		];
		static __COORDS_8DIR = [
			[-1,  0,  0], [-1,  0,  1], [-1,  0, -1], [ 1,  0,  0], 
			[ 1,  0,  1], [ 1,  0, -1], [ 0, -1,  0], [ 0, -1,  1], 
			[ 0, -1, -1], [ 0,  1,  0], [ 0,  1,  1], [ 0,  1, -1], 
			[-1,  1,  0], [-1,  1,  1], [-1,  1, -1], [ 1, -1,  0], 
			[ 1, -1,  1], [ 1, -1, -1], [-1, -1,  0], [-1, -1,  1], 
			[-1, -1, -1], [ 1,  1,  0], [ 1,  1,  1], [ 1,  1, -1],
		];
		
		#endregion
		
		var _self = self;
		
		// = PUBLIC ====================
		static get_node						= function(_i, _j, _k = 0) {
			return __.grid[_i][_j][_k];
		};
		static insert_node					= function(_node) {
			insert_node_at(_node, 
				_node.get_i(), 
				_node.get_j(), 
				_node.get_k()
			);
			return self;
		};
		static insert_node_at				= function(_node, _i, _j, _k = 0) {
			_node.set_finder(self);
			_node.set_i(_i);
			_node.set_j(_j);
			_node.set_k(_k);
			var _key = __index_to_string(_i, _j, _k);
			__.nodes.nodes[$ _key] = _node;
			__.grid[_i][_j][_k] = _node;
			return self;
		};
		static new_node						= function(_i, _j, _k = 0, _weight, _closed = false, _owner = other) {
			var _node = new IB_PathFinder_Node({
				finder: self,
				owner: _owner,
				i:	    _i,
				j:	    _j,
				k:	    _k,
				weight: _weight,
				closed: _closed,
			});
			insert_node(_node);
			return _node;
		};
		static new_traversable_condition	= function(_condition_name, _condition_method, _condition_params = undefined) {
			__.conditions.set(_condition_name, {
				condition_name:   _condition_name,
				condition_method: _condition_method,
				condition_params: _condition_params,
			});
			//	IB_PathFinder.new_traversable_condition(
			//		"swim_check", 
			//		function(_instance, _node_from, _node_to, _params) {
			//			show_debug_message(_params.message);
			//			// check if node is water, and if instance can swim in water
			//			if (_node_to.owner.type == "water" && !_instance.can_swim) {
			//				return false;
			//			}
			//			return true;
			//		},
			//		{ message: "hello there. here is some passed in dynamic data" },
			//	);
			return self;
		};
		static pathfind						= function(_instance, _node_from, _node_to) {
			// returns an array of IB_PathFinderNodes
			__.nodes.open   = [];
			__.nodes.closed = [];
			array_push(__.nodes.open, _node_from);
		
			while (array_length(__.nodes.open) > 0) {
				var _node = __.nodes.open[0];
				for (var _i = 1, _len = array_length(__.nodes.open); _i < _len; _i++) {
					if (__.nodes.open[_i].get_f_cost()  < _node.get_f_cost() 
					|| (__.nodes.open[_i].get_f_cost() == _node.get_f_cost() && __.nodes.open[_i].get_h_cost() < _node.get_h_cost())) 
					{
						_node = __.nodes.open[_i];
					}	
				}
				iceberg.array.find_delete(__.nodes.open, _node);
				array_push(__.nodes.closed, _node);
			
				if (_node == _node_to) {
					return __retrace_path(_node_from, _node_to);
				}
				// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
				var _neighbors = __get_neighbors(_node);
				for (var _i = 0, _len = array_length(_neighbors); _i < _len; _i++) {
				
					var _neighbor = _neighbors[_i];
					if (!__is_traversable(_instance, _node, _neighbor)) continue;
					if (array_contains(__.nodes.closed, _neighbor))	continue;
				
					var _neighbor_dist			   = __get_distance(_node, _neighbor);
					var _new_move_cost_to_neighbor = _node.get_g_cost() + _neighbor_dist + _neighbor.get_weight();
					if (_new_move_cost_to_neighbor < _neighbor.get_g_cost() || !array_contains(__.nodes.open, _neighbor)) {
					
						_neighbor.set_g_cost(_new_move_cost_to_neighbor);
						_neighbor.set_h_cost(__get_distance(_neighbor, _node_to));
						_neighbor.set_parent(_node);
					
						if (!iceberg.array.contains(this.__nodes.open, _neighbor)) {
							array_push(this.__nodes.open, _neighbor);	
						}
					}
				}
			}
		};
		static remove_index					= function(_i, _j, _k = 0) {
			__.grid[_i][_j][_k] = undefined;
			var _key = __index_to_string(_i, _j, _k);
			variable_struct_remove(__.nodes.nodes, _key);
			return self;
		};
		static remove_node					= function(_node) {
			remove_index(_node.get_i(), _node.get_j(), _node.get_k());
			return self;
		};
		static remove_traversable_condition = function(_name) {
			__.conditions.remove(_name);
			return self;
		};
		
		// = PRIVATE ===================
		with (__) {
			static __get_distance	 = function(_node_from, _node_to) {
			
				// this formula assumes that a square cell is of size 10 in width; therfore, the distance 
				// to travel along an axis is equated to the ratio between the width of the cell and the 
				// size of its diagonal. this can be calculated using the pythagorean theorem, getting 
				// the square root of the cell's hypotenuse, in both 2d and 3d space.
				//
				// for example: if a cell is 10 wide, then it would cost 10 to move along that same axis,
				// but if we wanted to shift axis, then we would need to travel along the diagonal, in 
				// which case, the cost to move along that diagonal would be equal to the length of that
				// hypotenuse. to calculate the length of the hypotenuse in 2-dimensions, it is just the
				// sqrt(2). to calculate the length of the hypotenuse in 3-dimensions, it is just the 
				// sqrt(3). we then scale these values by the size of the cell, in this case, 10. 
				// 
				// you can keep the scalar value set as 10 for a decent approximation; however, you could 
				// make this more precise by setting the scalar value equal to the cell's width in pixels,
				// and have it match the actual pixel size of the cell's sprite.
				//
				// https://gamedev.stackexchange.com/questions/185689/distance-cost-for-3d-a-algorithm
			
				static _traversal_cost_scalar	   = 10;
				static _1d_neighbor_traversal_cost = sqrt(1) * _traversal_cost_scalar; // 1.000 * 10 =  10
				static _2d_neighbor_traversal_cost = sqrt(2) * _traversal_cost_scalar; // 1.414 * 10 = ~14
				static _3d_neighbor_traversal_cost = sqrt(3) * _traversal_cost_scalar; // 1.732 * 10 = ~17
			
				var _dist_i  =  abs(_node_to.get_i() - _node_from.get_i());
				var _dist_j  =  abs(_node_to.get_j() - _node_from.get_j());
				var _dist_k  =  abs(_node_to.get_k() - _node_from.get_k());
				var _min	 =  min(_dist_i, _dist_j, _dist_k);
				var _max	 =  max(_dist_i, _dist_j, _dist_k);
				var _3d_axis = _min;
				var _2d_axis =  max(0, _dist_i + _dist_j + _dist_k - _max - 2 * _min);
				var _1d_axis = _max - _2d_axis - _3d_axis;
			
				return (
					_1d_neighbor_traversal_cost	* _1d_axis + 
					_2d_neighbor_traversal_cost	* _2d_axis + 
					_3d_neighbor_traversal_cost * _3d_axis
				);
			};
			static __get_neighbors   = function(_node, _diagonals = get_can_move_diagonally()) {
				var _neighbors = [];
				var _coords	   = _diagonals ? __COORDS_8DIR : __COORDS_4DIR;
				for (var _i = 0, _len = array_length(_coords); _i < _len; _i++) {
					var _coord  = _coords[_i];
					var _node_i = _node.get_i() + _coord[0];
					var _node_j = _node.get_j() + _coord[1];
					var _node_k = _node.get_k() + _coord[2];
				
					if (_node_i >= 0 && _node_i < size_get_width() 
					&&	_node_j >= 0 && _node_j < get_length() 
					&&	_node_k >= 0 && _node_k < size_get_height()
					) {
					    var _node_adjacent  = __.grid[_node_i][_node_j][_node_k];
					    if (_node_adjacent != undefined) {
						    array_push(_neighbors, _node_adjacent);
					    }
					}
				};
				return _neighbors;
			};
			static __index_to_string = function(_i, _j, _k = 0, _delineator = ",") {
				return (string(_i) + _delineator + 
						string(_j) + _delineator + 
						string(_k)
				);
			};
			static __is_traversable  = function(_instance, _node_from, _node_to) {
				if (!_node_from.__check_can_traverse_from()) return false;
				if (!_node_to.__check_can_traverse_to())	 return false;
			
				__.conditions.for_each(function(_condition_data, _node_data) {
					var _method	   = _condition_data.condition_method;
					var _params	   = _condition_data.condition_params;
					var _result = _method(
						_node_data.instance, 
						_node_data.node_from, 
						_node_data.node_to, 
						_params
					);
					if (!_result) return false;	
				}, {
					instance:  _instance,
					node_from: _node_from, 
					node_to:   _node_to,
				});
				return true;
			};
			static __retrace_path	 = function(_node_from, _node_to) {
				var _path = [];
				var _node = _node_to;
			
				while (_node != _node_from) {
					array_push(_path, _node);
					_node = _node.parent;
				};
				_path = iceberg.array.reverse(_path);
				return _path;
			};
			
			can_move_diagonally = _config[$ "can_move_diagonally"] ?? false;
			height				= _config[$ "height"			 ] ?? 1;
			length				= _config[$ "length"			 ] ?? 1;
			width				= _config[$ "width"				 ] ?? 1;
			grid				= iceberg.array.create_nd(width, length, height);
			nodes				= { nodes: {}, open: [], closed: [], };
			conditions			= new IB_Collection_Struct();
		};
			
		// = EVENTS ====================
		on_cleanup(function() {
			var _names = variable_struct_get_names(__.nodes.nodes);
			var _count = array_length(_names);
			for (var _i = 0; _i < _count; _i++) {
				var _node = __.nodes.nodes[$ _names[_i]];
					_node.cleanup();
			};	
			__.conditions.cleanup();
		});
	};

