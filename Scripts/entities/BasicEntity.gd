class_name BasicEntity extends CharacterBody3D

var input
var pyshics
var direction = Vector3.ZERO
var gravitational_constant = 1000.0
@onready var celestial_body_position = null

func _init():

	input = BasicInputs.new()
	pyshics = BasicPhysics.new()

func _physics_process(delta):

	if self.celestial_body_position:
		var direction_to_celestial_body = self.celestial_body_position - global_transform.origin
		var distance_to_celestial_body = direction_to_celestial_body.length()
		var gravity = (direction_to_celestial_body.normalized() * gravitational_constant) / (distance_to_celestial_body * distance_to_celestial_body)
		velocity.y -= gravity.y * delta
		move_and_slide()
