class_name BasicEntity extends CharacterBody3D

var celestial_body_position: Vector3 = Vector3.ZERO
var gravitational_constant = 9999.0
var input_press: bool = false

func calculate_gravity(delta):

	var direction_to_center = self.celestial_body_position - global_transform.origin
	var distance_to_center = direction_to_center.length()
	var normalized_direction = direction_to_center.normalized()
	return (normalized_direction * self.gravitational_constant) / (distance_to_center * distance_to_center)

func input_controller(diretion_input):

	self.input_press = false
	var direction = diretion_input.normalized()
	if Input.is_action_pressed("move_right"):
		direction.x += 1
		self.input_press = true
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
		self.input_press = true
	if Input.is_action_pressed("move_back"):
		direction.z += 1
		self.input_press = true
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1
		self.input_press = true
	return direction

func calculate_target_velocity(speed,direction,gravitational_force):
	
	var target_velocity = Vector3.ZERO
	if self.input_press:
		target_velocity.x = direction.x * speed
		target_velocity.z = direction.z * speed
	if not is_on_floor():
		target_velocity = target_velocity + gravitational_force
	return target_velocity

func move_entity(delta,target_velocity):

	velocity = target_velocity
	move_and_slide()
