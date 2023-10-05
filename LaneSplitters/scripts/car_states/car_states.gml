
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   ______   ______    // 
	// /\  ___\ /\  __ \ /\  == \   // 
	// \ \ \____\ \  __ \\ \  __<   // 
	//  \ \_____\\ \_\ \_\\ \_\ \_\ // 
	//   \/_____/ \/_/\/_/ \/_/ /_/ // 
	//                              //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function car_state_base() {
		//  ______   ______   ______   ______    //
		// /\  == \ /\  __ \ /\  ___\ /\  ___\   //
		// \ \  __< \ \  __ \\ \___  \\ \  __\   //
		//  \ \_____\\ \_\ \_\\/\_____\\ \_____\ //
		//   \/_____/ \/_/\/_/ \/_____/ \/_____/ //
		//                                       //
		return {
			enter: function() {},
			step:  function() {
				
				// update relative vectors
				__.movement.position_vector.x = phy_position_x;
				__.movement.position_vector.y = phy_position_y;
				__.movement.facing_vector.set_direction(phy_rotation);
				
				// update axel positions
				__.movement.front_axel.assign_to({
					x: (__.movement.facing_vector.x * __.movement.wheel_base * 0.5),
					y: (__.movement.facing_vector.y * __.movement.wheel_base * 0.5),
				});
				__.movement.rear_axel.assign_to ({
					x: -(__.movement.facing_vector.x * __.movement.wheel_base * 0.5),
					y: -(__.movement.facing_vector.y * __.movement.wheel_base * 0.5),
				});
				
				////////////////////////////////////////////////////////////////////////////
				
				// acceleration
				__.movement.acceleration_vector.zero();
				
				// gas
				if (input_gas_down()) {
					// could assign this to a continuous value bound to right gamepad trigger, instead of simply just 0 or 1
					__.movement.acceleration_vector.set_magnitude(__.movement.engine_power);
					__.movement.acceleration_vector.set_direction(__.movement.facing_vector.get_direction());
				}
				
				////////////////////////////////////////////////////////////////////////////
				
				// friction
				__.movement.friction_vector.set_magnitude(__.movement.friction);
				__.movement.friction_vector.set_direction(__.movement.velocity_vector.get_direction() + 180);
				// ^ setting direction to current facing_vector, or accel_vector instead of velocity could have interesting results
				
				// friction scaling at low speed
				if (__.movement.velocity_vector.get_magnitude() > 0
				&&	__.movement.velocity_vector.get_magnitude() <= __.movement.friction_compound_threshold
				) {
					__.movement.friction_vector.multiply_by(__.movement.friction_compound_scalar);	
				}
				
				// hand_brake
				if (input_hand_brake_down()) {
					__.movement.friction_vector.multiply_by(__.movement.hand_brake_friction_scalar);
					__.movement.traction_current *= __.movement.hand_brake_traction_scalar;
				}
				
				////////////////////////////////////////////////////////////////////////////
				
				// drag
				__.movement.drag_vector.assign_to(__.movement.velocity_vector);
				__.movement.drag_vector.multiply_by(__.movement.velocity_vector.get_magnitude() * __.movement.drag);
				__.movement.drag_vector.set_direction(__.movement.velocity_vector.get_direction() + 180);
				
				////////////////////////////////////////////////////////////////////////////
				
				// steering
				__.movement.steer_vector.assign_to(__.movement.facing_vector);
				if (input_left_down ()) __.movement.steer_vector.rotate(-__.movement.steer_angle);
				if (input_right_down()) __.movement.steer_vector.rotate( __.movement.steer_angle);
				
				// new heading
				var _front_wheel = __.movement.front_axel.copy();
					_front_wheel.add(__.movement.velocity_vector);
					_front_wheel.interpolate_dir(__.movement.steer_vector.get_direction(), 1);
		
				var _rear_wheel  = __.movement.rear_axel.copy();
					_rear_wheel .add(__.movement.velocity_vector);
					
				var _new_heading = _front_wheel.subtract(_rear_wheel);
				__.movement.heading_vector.assign_to(_new_heading);
				
				// traction
				__.movement.traction_target = __.movement.traction_slow;
				if (__.movement.velocity_vector.get_magnitude() > __.movement.traction_threshold) {
					__.movement.traction_target = __.movement.traction_fast;
				}
				__.movement.traction_current = lerp(__.movement.traction_current, __.movement.traction_target, __.movement.traction_correction);
				__.movement.velocity_vector.interpolate_dir(__.movement.heading_vector.get_direction(), __.movement.traction_current);

				////////////////////////////////////////////////////////////////////////////
			
				// apply acceleration & friction
				__.movement.velocity_vector.add(__.movement.acceleration_vector);
				__.movement.velocity_vector.add(__.movement.friction_vector);
				__.movement.velocity_vector.add(__.movement.drag_vector);
				
				// velocity cutoff
				if (__.movement.velocity_vector.get_magnitude() <= __.movement.velocity_cutoff) {
					__.movement.velocity_vector.zero();	
				}
			
				// max speed : holding hand brake
				if (input_hand_brake_down()) {
					__.movement.velocity_vector.limit_magnitude(__.movement.max_speed * __.movement.hand_brake_max_speed_scalar);
				}
				// max speed : no hand brake
				else {
					__.movement.velocity_vector.limit_magnitude(__.movement.max_speed);	
				}
				
				////////////////////////////////////////////////////////////////////////////
				
				// update rotation if velocity has magnitude
				if (__.movement.velocity_vector.has_magnitude() 
				&& (__.movement.acceleration_vector.has_magnitude() || __.movement.friction_vector.has_magnitude())
				) {
					__.movement.rotation_last = __.movement.heading_vector.get_direction();	
				}
				
				// apply movement
				phy_rotation = __.movement.rotation_last;
				phy_speed_x  = __.movement.velocity_vector.x;
				phy_speed_y  = __.movement.velocity_vector.y;
				depth		 = -y;
				
				// effects
				particles_create_exhaust();
			},
			draw:  function() {},
			leave: function() {},
		};
	};
	/**/function car_state_drive() {
		    //  _____    ______   __   __   __ ______    //
			// /\  __-. /\  == \ /\ \ /\ \ / //\  ___\   //
			// \ \ \/\ \\ \  __< \ \ \\ \ \'/ \ \  __\   //
			//  \ \____- \ \_\ \_\\ \_\\ \__|  \ \_____\ //
			//   \/____/  \/_/ /_/ \/_/ \/_/    \/_____/ //
			//                                           //
		    return {
		        enter: function() {
		            __.state.fsm.inherit();
					objc_camera.zoom_set_target(0.60);
		        },
		        step:  function() {
		            __.state.fsm.inherit();
					if (__.state.fsm.trigger("t_drift")) exit;
		        },
		        draw:  function() {
		            __.state.fsm.inherit();
		        },
		        leave: function() {
		            __.state.fsm.inherit();
		        }
		    };
		};
	/**/function car_state_drift() {
		    //  _____    ______   __   ______  ______  //
			// /\  __-. /\  == \ /\ \ /\  ___\/\__  _\ //
			// \ \ \/\ \\ \  __< \ \ \\ \  __\\/_/\ \/ //
			//  \ \____- \ \_\ \_\\ \_\\ \_\     \ \_\ //
			//   \/____/  \/_/ /_/ \/_/ \/_/      \/_/ //
			//                                         //
		    return {
		        enter: function() {
		            __.state.fsm.inherit();
					__.drift.drifting = true;
					objc_camera.zoom_set_target(0.50);
		        },
		        step:  function() {
		            __.state.fsm.inherit();
					
					if (__.state.fsm.trigger("t_drive")) exit;
					
					__.drift.hold_time++;
					__.drift.check_donuts();
					__.drift.check_near_miss();
					__.drift.update_multiplier();
					__.drift.check_score_zone();
					__.drift.check_score_bonus_zone();
					
					particles_create_tracks();
					particles_create_smoke();
		        },
		        draw:  function() {
		            __.state.fsm.inherit();
					__.drift.render_near_miss();
		        },
		        leave: function() {
		            __.state.fsm.inherit();
					if (__.drift.check_success()) {
						__.drift.success();
					}
					__.drift.drifting		  = false;
					__.drift.hold_time		  = 0;
					__.drift.points_current	  = 0;	
					__.drift.multiplier		  = 1;
					__.drift.multiplier_time  = 0;
					__.drift.donuts_active	  = false;
					__.drift.near_miss_object = noone;
					__.drift.clear_donut_trigger();
		        }
		    };
		};

	// triggers
	function car_state_trigger_drift() {
		return (input_hand_brake_down()
			&&	__.drift.penalty_timer == 0
			&&	__.movement.velocity_vector.has_magnitude()
		);
	};
	function car_state_trigger_drive() {
		return (!input_hand_brake_down()
			||	__.drift.penalty_timer != 0
			|| !__.movement.velocity_vector.has_magnitude()
		);
	};
	