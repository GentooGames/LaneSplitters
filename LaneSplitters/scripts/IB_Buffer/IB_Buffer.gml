
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   __  __   ______  ______  ______   ______    //
	// /\  == \ /\ \/\ \ /\  ___\/\  ___\/\  ___\ /\  == \   //
	// \ \  __< \ \ \_\ \\ \  __\\ \  __\\ \  __\ \ \  __<   //
	//  \ \_____\\ \_____\\ \_\   \ \_\   \ \_____\\ \_\ \_\ //
	//   \/_____/ \/_____/ \/_/    \/_/    \/_____/ \/_/ /_/ //
    //                                                   	 //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function IB_Buffer(_config = {}) : IB_Base(_config) constructor {
		
		// = PUBLIC ================
		static from_surface			 = function(_surface, _offset = 0) {
			
			if (!surface_exists(_surface)) exit;
			
			// resize buffer to fit the incoming surface
			static _bits_per_pixel	 =  4; // RGBA
			var _surface_width		 =  surface_get_width (_surface);
			var _surface_height		 =  surface_get_height(_surface);
			var _surface_buffer_size = _surface_width * _surface_height * _bits_per_pixel;
			buffer_resize(__.buffer, _surface_buffer_size);
			
			// reset buffer seek position back to the start
			buffer_seek(__.buffer, buffer_seek_start, 0);
			
			// store surface in buffer
			buffer_get_surface(__.buffer, _surface, _offset);
			
			return self;
		};
		static get_alignment		 = function() {
			return __.alignment;	
		};
		static get_buffer			 = function() {
			return __.buffer;	
		};
		static get_offset_from_index = function(_index) {
			return _index * __.alignment;
		};
		static get_size				 = function() {
			return buffer_get_size(__.buffer);	
		};
		static get_type				 = function() {
			return __.type;	
		};
		static read					 = function(_type) {
			return buffer_read(__.buffer, _type);
		};
		static read_from_index		 = function(_index, _type) {
			var _tell = buffer_tell(__.buffer);
			buffer_seek(__.buffer, buffer_seek_start, get_offset_from_index(_index));
			var _value = buffer_read(__.buffer, _type);
			buffer_seek(__.buffer, buffer_seek_start, _tell);
			return _value;
		};
		static reconfigure			 = function(_size, _type, _alignment) {
			__.alignment = _alignment;
			__.type		 = _type;
			__.buffer	 =  buffer_create(_size, _type, _alignment);
			return self;
		};
		static seek					 = function(_base = buffer_seek_start, _offset = 0) {
			buffer_seek(__.buffer, _base, _offset);
			return self;
		};
		static to_surface			 = function(_surface, _offset = 0) {
			buffer_set_surface(__.buffer, _surface, _offset);
			return self;
		};
		static write				 = function(_type, _value) {
			buffer_write(__.buffer, _type, _value);
			return self;
		};
		static write_to_index		 = function(_index, _type, _value) {
			var _tell = buffer_tell(__.buffer);
			buffer_seek (__.buffer, buffer_seek_start, get_offset_from_index(_index));
			buffer_write(__.buffer, _type, _value);
			buffer_seek (__.buffer, buffer_seek_start, _tell);
			return self;
		};
		
		// = PRIVATE ===============
		with (__) {
			alignment = _config[$ "alignment"] ?? 1;
			size	  = _config[$ "size"	 ] ?? 1; //!\\
			type	  = _config[$ "type"	 ] ?? buffer_grow;
			buffer	  =  buffer_create(size, type, alignment);	
			
			// size may change over the lifetime of the buffer,
			// especially if the buffer is of type: grow. because
			// of this, size should never be stored statically, 
			// and instead, should be fetched dynamically whenever
			// needed using buffer_get_size(). therefore, after 
			// instantiation of the buffer instance, this var is 
			// removed from the private struct so that we aren't
			// tempted to access it.
			variable_struct_remove(self, "size");
		};
		
		// = EVENTS ================
		on_cleanup(function() {
			buffer_delete(__.buffer);
			__.buffer = undefined;
		});
	};
	
	function IB_BufferGrid(_config = {}) : IB_Buffer(_config) constructor {
		
		// IB_BufferGrid doesnt actually implement any sort of instance
		// to represent the grid; instead, it simply just provides an 
		// interface to allow for easy reads and writes to the buffer
		// as though the buffer were indexed like that of a grid: with 
		// a given i and j coordinate position.
		
		// = PUBLIC ================
		static size_get_height			 = function() {
			return __.height;	
		};
		static get_offset_from_index = function(_i, _j) { // @override
			return ((_i * __.width) + _j) * __.alignment;
		};
		static size_get_width			 = function() {
			return __.width;	
		};
		static read_from_index		 = function(_i, _j, _type) { // @override
			var _tell = buffer_tell(__.buffer);
			buffer_seek(__.buffer, buffer_seek_start, get_offset_from_index(_i, _j));
			var _value = buffer_read(__.buffer, _type);
			buffer_seek(__.buffer, buffer_seek_start, _tell);
			return _value;
		};
		static set_height			 = function(_height) {
			__.height = _height;
			return self;
		};
		static size_set_width			 = function(_width) {
			__.width = _width;
			return self;
		};
		static write_to_index		 = function(_i, _j, _type, _value) { // @override
			var _tell = buffer_tell(__.buffer);
			buffer_seek (__.buffer, buffer_seek_start, get_offset_from_index(_i, _j));
			buffer_write(__.buffer, _type, _value);
			buffer_seek (__.buffer, buffer_seek_start, _tell);
			return self;
		};
		
		// = PRIVATE ===============
		with (__) {
			width  = _config[$ "width" ] ?? undefined;
			height = _config[$ "height"] ?? undefined;
		};
	};
	