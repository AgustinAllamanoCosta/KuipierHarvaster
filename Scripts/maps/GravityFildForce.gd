class_name AsteroidGravity extends Area3D

func _process(delta):

	var targets = get_overlapping_bodies()
	for target in targets:
		target.celestial_body_position = global_position
