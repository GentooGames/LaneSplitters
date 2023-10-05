
	self[$ "text"  ] ??= "";
	self[$ "color" ] ??= c_white;
	self[$ "scale" ] ??= 1;
	self[$ "alpha" ] ??= 1;
	self[$ "center"] ??= false;
	
	y_start  = y;
	y_lerp	 = y;
	y_offset = 20;
	decay	 = 0.01;
	