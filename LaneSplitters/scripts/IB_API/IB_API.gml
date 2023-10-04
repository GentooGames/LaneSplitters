
	// ~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   ______  __    //
	// /\  __ \ /\  == \/\ \   //
	// \ \  __ \\ \  _-/\ \ \  //
	//  \ \_\ \_\\ \_\   \ \_\ //
	//   \/_/\/_/ \/_/    \/_/ //
	//						   //
    // ~~~~~~~~~~~~~~~~~~~~~~~ //
	function iceberg_create() {
		return instance_create_depth(0, 0, 0, iceberg);
	};
	function iceberg_initialize() {
		return iceberg.initialize();
	};
	function iceberg_activate() {
		return iceberg.activate();	
	};
		
