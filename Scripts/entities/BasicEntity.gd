class_name BasicEntity extends CharacterBody3D

var input
var pyshics
var direction = Vector3.ZERO
var gravitational_constant = 999999.0
var celestial_body_position: Vector3 = Vector3.ZERO
var gravitational_force: Vector3 = Vector3.ZERO

func _init():

	input = BasicInputs.new()
	pyshics = BasicPhysics.new()

func _physics_process(delta):
	var direction_to_center = celestial_body_position - global_transform.origin
	var distance_to_center = direction_to_center.length()

	if distance_to_center > 0.1:
		var normalized_direction = direction_to_center.normalized()

		gravitational_force = (normalized_direction * gravitational_constant) / (distance_to_center * distance_to_center)
		
		#velocity += gravitational_force * delta
		#var look_rotation = transform.basis.looking_at(-normalized_direction,Vector3.UP)
		#var new_transform = Transform3D(global_transform.basis, global_transform.origin)
		#new_transform.basis = look_rotation
		#transform.basis = new_transform.looking_at(Vector3.DOWN,Vector3.BACK).basis

	move_and_slide()
