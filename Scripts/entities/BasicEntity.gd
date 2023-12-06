class_name BasicEntity extends CharacterBody3D

var input
var pyshics
var direction = Vector3.ZERO
var gravitational_constant = 999999.0
var celestial_body_position = null

func _init():

	input = BasicInputs.new()
	pyshics = BasicPhysics.new()

func _physics_process(delta):

	if self.celestial_body_position != null:
		var direction_to_celestial_body = self.celestial_body_position - global_transform.origin
		var distance_to_celestial_body = direction_to_celestial_body.length()

		if distance_to_celestial_body > 0.1:  # Adjust this threshold as needed
			# Calculate the normalized direction vector towards the center
			var normalized_direction = direction_to_celestial_body.normalized()

			# Calculate the gravitational force based on the distance and the direction towards the center
			var gravitational_force = (normalized_direction * gravitational_constant) / (distance_to_celestial_body * distance_to_celestial_body)

			# Apply the gravitational force to the character's velocity
			velocity += gravitational_force * delta
			move_and_slide()
