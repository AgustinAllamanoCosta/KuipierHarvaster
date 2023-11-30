class_name BaseMiner extends Node

var base_miner_power = 3
var ore_inventory = 0
var ore_limit = 10

@onready var attack_range: Area3D = $OreDetector
var targets = []
var target: StaticBody3D = null

func _process(delta):
	targets = attack_range.get_overlapping_bodies()
	if(targets.is_empty()):
		target = null
	else:
		target = targets[0]

func _on_timer_timeout():
	if(target != null):
		target.mine(base_miner_power)
		if target.isDestroy:
			ore_inventory = ore_inventory + target.value
			target.queue_free()
			target = null
			print(ore_inventory)

func get_ore_by_type(ore_type:String):
	return ore_inventory
