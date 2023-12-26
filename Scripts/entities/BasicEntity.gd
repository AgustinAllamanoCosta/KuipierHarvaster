class_name BasicEntity extends CharacterBody3D

var direction = Vector3.ZERO
var celestial_body_position: Vector3 = Vector3.ZERO
var target_velocity = Vector3.ZERO
var gravitational_constant = 9999.0
var gravitational_force: Vector3 = Vector3.ZERO
var input_press: bool = false

@onready var pivot_point: Node3D = $Pivot
@onready var ray_cast: RayCast3D = $RayCastFront

func calculate_gravity(delta):

	var direction_to_center = self.celestial_body_position - global_transform.origin
	var distance_to_center = direction_to_center.length()
	var normalized_direction = direction_to_center.normalized()
	self.gravitational_force = (normalized_direction * self.gravitational_constant) / (distance_to_center * distance_to_center)

func input_controller():

	self.input_press = false
	self.direction = self.direction.normalized()
	if Input.is_action_pressed("move_right"):
		self.direction.x += 1
		self.input_press = true
	if Input.is_action_pressed("move_left"):
		self.direction.x -= 1
		self.input_press = true
	if Input.is_action_pressed("move_back"):
		self.direction.z += 1
		self.input_press = true
	if Input.is_action_pressed("move_forward"):
		self.direction.z -= 1
		self.input_press = true

func calculate_target_velocity(speed):

	self.target_velocity = Vector3.ZERO
	if self.input_press:
		self.target_velocity.x = self.direction.x * speed
		self.target_velocity.z = self.direction.z * speed
	if not is_on_floor():
		self.target_velocity = self.target_velocity + self.gravitational_force

func move_entity(delta):

	velocity = self.target_velocity
	move_and_slide()
	if self.ray_cast.is_colliding():
		var normal_ground_vector: Vector3 = self.ray_cast.get_collision_normal()
		var ground_position = self.ray_cast.get_collision_point()
		self.align_with_ground(normal_ground_vector,ground_position)

func align_with_ground(ground_normal: Vector3, ground_position: Vector3):
	if ground_normal == Vector3.ZERO:
		return  # No valid normal, cannot align

	var up_vector = (self.pivot_point.global_transform.origin - ground_position).normalized()
	var side_vector = ground_normal.cross(up_vector).normalized()
	var new_up = side_vector.cross(ground_normal)

	var rotation_basis = Basis(side_vector, ground_normal, new_up)

	self.pivot_point.global_transform.basis = rotation_basis
