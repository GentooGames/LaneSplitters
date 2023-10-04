
	// ~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   __  __   __    //
	// /\  ___\ /\ \/\ \ /\ \   //
	// \ \ \__ \\ \ \_\ \\ \ \  //
	//  \ \_____\\ \_____\\ \_\ //
	//   \/_____/ \/_____/ \/_/ //
	//                          //
	// ~~~~~~~~~~~~~~~~~~~~~~~~ //
	function _IB_Utility_Gui() constructor {
	
		static from_gui_x		  = function(_gui_x, _view_camera_index = 0) {
			var _camera	 = view_camera[_view_camera_index];
			var _scale	 = surface_get_width(application_surface) / camera_get_view_width(_camera);
			var _world_x = camera_get_view_x(_camera) + (_gui_x / _scale);
			return _world_x;
		};
		static from_gui_y		  = function(_gui_y, _view_camera_index = 0) {
			var _camera	 = view_camera[_view_camera_index];
			var _scale	 = surface_get_height(application_surface) / camera_get_view_height(_camera);
			var _world_y = camera_get_view_y(_camera) + (_gui_y / _scale);
			return _world_y;
		};
		static from_world_x		  = function(_world_x, _view_camera_index = 0) {
			var _camera	= view_camera[_view_camera_index];
			var _scale	= surface_get_width(application_surface) / camera_get_view_width(_camera);
			var _gui_x	= (_world_x - camera_get_view_x(_camera)) * _scale;
			return _gui_x;
		};
		static from_world_y		  = function(_world_y, _view_camera_index = 0) {
			var _camera	= view_camera[_view_camera_index];
			var _scale	= surface_get_height(application_surface) / camera_get_view_height(_camera);
			var _gui_y	= (_world_y - camera_get_view_y(_camera)) * _scale;
			return _gui_y;
		};
		static get_surface_width  = function(_surface = application_surface) {
			return surface_get_width(_surface);
		};
		static get_surface_height = function(_surface = application_surface) {
			return surface_get_height(_surface);
		};
	};

	