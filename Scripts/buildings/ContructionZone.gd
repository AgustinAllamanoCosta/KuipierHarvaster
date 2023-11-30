class_name ContructionZone extends StaticBody3D


@export var cost = 10
@export var ore_type = 'Base Ore'

@export var build_blueprint: PackedScene

func build(resource):
	if resource == cost:
		var build = build_blueprint.instantiate()
		build.transform = global_transform
		add_sibling(build)
		queue_free()
