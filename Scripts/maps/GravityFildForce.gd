class_name AsteroidGravity extends Area3D

func _process(delta):

	var targets = get_overlapping_bodies()
	for target in targets:
		print(target.name)
		target.pyshics.gravity_point = global_position
