	
	var _x = objc_camera.x_world_to_gui(x);
	var _y = objc_camera.y_world_to_gui(y_lerp);
	draw_text_transformed_color(_x + 2, _y + 2, text, scale, scale, 0, c_black, c_black, c_black, c_black, alpha);
	draw_text_transformed_color(_x, _y, text, scale, scale, 0, color, color, color, color, alpha);
	