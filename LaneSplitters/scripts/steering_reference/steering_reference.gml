/*
	# This function updates every physics frame.
	func _physics_process(delta):
	    # Reset the acceleration at the start of each physics frame.
	    acceleration_vector = Vector2.ZERO
	
		////////////////////////////////////////////////////////////////////////
	
	    # Read player input to determine acceleration and steering.
		# Determine the direction of the turn based on user input.
		var turn = 0
		if Input.is_action_pressed("steer_right"):
		    turn += 1
		if Input.is_action_pressed("steer_left"):
		    turn -= 1
		
		# Update the steering angle based on the turn direction.
		steer_angle = turn * steering_angle
		
		# Adjust the acceleration based on user input for acceleration and braking.
		if Input.is_action_pressed("accelerate"):
		    acceleration_vector = transform.x * engine_power
		if Input.is_action_pressed("brake"):
		    acceleration_vector = transform.x * braking
	
		////////////////////////////////////////////////////////////////////////
	
		# Calculate the friction and drag forces on the vehicle.
		# If the vehicle's speed is very low, bring it to a stop.
		if velocity_vector.length() < 5:
		    velocity_vector = Vector2.ZERO
		
		# Calculate friction and drag forces.
		var friction_force = velocity_vector * friction
		var drag_force = velocity_vector * velocity_vector.length() * drag
	
		# If the vehicle's speed is below a certain threshold, increase friction.
		if velocity_vector.length() < 100:
		    friction_force *= 3
		
		# Accumulate the effects of friction and drag into the acceleration.
		acceleration_vector += drag_force + friction_force
	
		////////////////////////////////////////////////////////////////////////
	
	    # Calculate the vehicle's new heading based on current speed and steering angle.
	    var rear_wheel = position - transform.x * wheel_base / 2.0
	    var front_wheel = position + transform.x * wheel_base / 2.0
	
	    # Move the positions of the wheels based on the velocity.
	    rear_wheel += velocity_vector * delta
	    front_wheel += velocity_vector.rotated(steer_angle) * delta
	
	    # Calculate the new direction (or heading) of the vehicle.
	    var new_heading_vector = (front_wheel - rear_wheel).normalized()
	
	    # Determine the amount of traction based on current speed.
	    var traction = velocity_vector.length() > slip_speed ? traction_fast : traction_slow
	
	    # Dot product between the new heading and current velocity direction.
	    var d = new_heading_vector.dot(velocity_vector.normalized())
	
	    # Update the velocity based on the traction and the new heading.
	    if d > 0:
	        velocity_vector = velocity_vector.linear_interpolate(new_heading_vector * velocity_vector.length(), traction)
	    elif d < 0:
	        velocity_vector = -new_heading_vector * min(velocity_vector.length(), max_speed_reverse)
		
	    # Update the vehicle's rotation to align with the new heading.
	    rotation = new_heading_vector.angle()
		
		////////////////////////////////////////////////////////////////////////
	
	    # Update the velocity using the accumulated acceleration.
	    velocity_vector += acceleration_vector * delta
	
	    # Move the vehicle based on its updated velocity.
	    velocity_vector = move_and_slide(velocity_vector)
	