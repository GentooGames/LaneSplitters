
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   __  __   ______  ______  ______   ______    //
	// /\  == \ /\ \/\ \ /\  ___\/\  ___\/\  ___\ /\  == \   //
	// \ \  __< \ \ \_\ \\ \  __\\ \  __\\ \  __\ \ \  __<   //
	//  \ \_____\\ \_____\\ \_\   \ \_\   \ \_____\\ \_\ \_\ //
	//   \/_____/ \/_____/ \/_/    \/_/    \/_____/ \/_/ /_/ //
	//                                                       //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function _IB_Utility_Buffer() constructor {

		static compress		  = function(_buffer, _delete_source = true) {
			var _size = buffer_get_size(_buffer);
			var _new  = buffer_compress(_buffer, 0, _size);
			if (_delete_source) {
				buffer_delete(_buffer);	
			}
			return _new;
		};
		static create		  = function(_size) {
			return create_ext(_size);
		};
		static create_ext	  = function(_size, _type = buffer_grow, _alignment = 1) {
			return buffer_create(_size, _type, _alignment);
		};
		static decode		  = function(_buffer) {};
		static decompress	  = function(_buffer) {};
		static encode		  = function(_buffer, _delete_source = true) {
			var _size = buffer_get_size(_buffer);
			var _new  = buffer_base64_encode(_buffer, 0, _size);
			if (_delete_source) {
				buffer_delete(_buffer);	
			}
			return _new;
		};
		static from_string	  = function(_string, _buffer = undefined) {
			var _size = string_byte_length(_string);
			if (_buffer == undefined) {
				_buffer  = create(_size);
			}
			write_to_start(_buffer, buffer_text, _string);
			return _buffer;
		};
		static from_struct	  = function(_struct, _buffer = undefined) {
			var _string = json_stringify(_struct);
			return from_string(_string, _buffer);
		};
		static hash			  = function(_buffer, _delete_source = true) {
			return hash_ext(_buffer,,_delete_source);
		};
		static hash_ext		  = function(_buffer, _hash_function = buffer_crc32, _delete_source = true) {
			var _size =  buffer_get_size(_buffer);
			var _new  = _hash_function(_buffer, 0, _size);
			if (_delete_source) {
				buffer_delete(_buffer);	
			}
			return _new;
		}
		static write		  = function(_buffer, _type, _value) {
			buffer_write(_buffer, _type, _value);
			return _buffer;
		};
		static write_to		  = function(_buffer, _type, _value, _seek = buffer_seek_start, _offset = 0) {
			buffer_seek(_buffer, _seek, _offset);
			return write(_buffer, _type, _value);
		};
		static write_to_start = function(_buffer, _type, _value) {
			return write_to(_buffer, _type, _value);
		};
	};














