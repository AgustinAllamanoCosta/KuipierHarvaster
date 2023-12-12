class_name BasicEntity extends CharacterBody3D

var direction = Vector3.ZERO
var celestial_body_position: Vector3 = Vector3.ZERO
var target_velocity = Vector3.ZERO
var gravitational_constant = 999999.0
var gravitational_force: Vector3 = Vector3.ZERO

func calculate_gravity(delta):

	if not is_on_floor():
		var direction_to_center = self.celestial_body_position - global_transform.origin
		var distance_to_center = direction_to_center.length()
		var normalized_direction = direction_to_center.normalized()
		self.gravitational_force = (normalized_direction * self.gravitational_constant) / (distance_to_center * distance_to_center)
	else:
		self.gravitational_force = Vector3.ZERO

func input_controller():

	if Input.is_action_pressed("move_right"):
		self.direction.x += 1
	if Input.is_action_pressed("move_left"):
		self.direction.x -= 1
	if Input.is_action_pressed("move_back"):
		self.direction.z += 1
	if Input.is_action_pressed("move_forward"):
		self.direction.z -= 1

func calculate_target_velocity(speed):
	self.target_velocity = Vector3.ZERO
	self.target_velocity.x = self.direction.x * speed
	self.target_velocity.z = self.direction.z * speed
	self.target_velocity = self.target_velocity + self.gravitational_force

func calculate_tanget_direction():
	var normal = self.gravitational_force.normalized()
	var vector2 = Vector3(-normal.z, normal.x, normal.y)
	self.direction = normal.cross(vector2)
