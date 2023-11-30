class_name BasicEntity extends CharacterBody3D

var input
var pyshics
var direction = Vector3.ZERO

func _init():

	input = BasicInputs.new()
	pyshics = BasicPhysics.new()

func _physics_process(delta):
	if not is_on_floor():
		pyshics.target_velocity.y -= 4 * delta
