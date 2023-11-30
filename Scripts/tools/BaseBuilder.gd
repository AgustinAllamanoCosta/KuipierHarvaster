class_name BaseBuilder extends Node

@onready var attack_range: Area3D = $ZoneDetector
@onready var carrier: Player

func _process(delta):
	var targets = attack_range.get_overlapping_bodies()
	if not targets.is_empty():
		var construction_zone = targets[0]
		var ore = carrier.get_ore_from_inventory(construction_zone.ore_type)
		construction_zone.build(ore)
