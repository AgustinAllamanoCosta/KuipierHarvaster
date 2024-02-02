class_name BasicEntity extends CharacterBody3D

var celestial_body_position: Vector3 = Vector3.ZERO
var gravitational_constant = 9.82
var input_press: bool = false

func calculate_gravity(delta):

	return Vector3(0,-self.gravitational_constant,0)

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

func calculate_target_velocity(speed,direction,gravitational_force,input_press):
	
	var target_velocity = Vector3.ZERO
	if input_press:
		target_velocity.x = direction.x * speed
		target_velocity.z = direction.z * speed
	if not is_on_floor():
		target_velocity = target_velocity + gravitational_force
	return target_velocity

func move_entity(delta,target_velocity):

	velocity = target_velocity
	move_and_slide()
