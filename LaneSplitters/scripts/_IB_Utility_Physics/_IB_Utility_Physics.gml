
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______  __  __   __  __   ______   __   ______   ______    //
	// /\  == \/\ \_\ \ /\ \_\ \ /\  ___\ /\ \ /\  ___\ /\  ___\   //
	// \ \  _-/\ \  __ \\ \____ \\ \___  \\ \ \\ \ \____\ \___  \  //
	//  \ \_\   \ \_\ \_\\/\_____\\/\_____\\ \_\\ \_____\\/\_____\ //
	//   \/_/    \/_/\/_/ \/_____/ \/_____/ \/_/ \/_____/ \/_____/ //
	//                                                             //	
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function _IB_Utility_Physics() constructor {

		static fixture_box = function(_instance, _collision_group = 0, _density = 0.5, _friction = 0.2, _restitution = 0.1, _linear_damping = 0.1, _angular_damping = 0.1, _awake = true) {
			
			/// @function physics_fixture_box(...)
			/// @argument *collision_group
			/// @argument *density
			/// @argument *friction
			/// @argument *restitution
			/// @argument *linear_damping
			/// @argument *angular_damping
			/// @argument *awake

			with (_instance) {
				var _half_width	 =  sprite_width  * 0.5;
				var _half_height =  sprite_height * 0.5;
				var _origin_x	 = (sprite_width  * 0.5) - sprite_xoffset;
				var _origin_y	 = (sprite_height * 0.5) - sprite_yoffset;
				var _fx			 =  physics_fixture_create();
	
				physics_fixture_set_box_shape	   (_fx, _half_width, _half_height);
				physics_fixture_set_collision_group(_fx, _collision_group);
				physics_fixture_set_density		   (_fx, _density);
				physics_fixture_set_friction	   (_fx, _friction);
				physics_fixture_set_restitution	   (_fx, _restitution);
				physics_fixture_set_linear_damping (_fx, _linear_damping);
				physics_fixture_set_angular_damping(_fx, _angular_damping);
				physics_fixture_set_awake		   (_fx, _awake);
	
				var _fx_return = physics_fixture_bind_ext(_fx, id, _origin_x, _origin_y);
				physics_fixture_delete(_fx);
			};
			return _fx_return;
			
		};

	};
	