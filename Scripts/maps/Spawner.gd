extends Node

@export var mob_blueprint: PackedScene
@export var player: Player
@export var spawn_points: Array[Node3D] = []

var total_entities = 10
var spawn_entities = 0

var ord_number = 1
var kille_entity_in_orde = 0

func _process(delta):
	if kille_entity_in_orde == total_entities:
		kille_entity_in_orde = 0
		spawn_entities = 0
		ord_number += 1

func _on_timer_timeout():
	for spawn_point in self.spawn_points:
		if total_entities > spawn_entities:
			self.spawn_entity(spawn_point.transform)

func entity_die():
	kille_entity_in_orde += 1

func spawn_entity(spawn_point):
	if self.player:
		var mob: Mob = mob_blueprint.instantiate()
		mob.player = player
		mob.transform = spawn_point
		add_child(mob)
		mob.dead.connect(self.player.weapon.enemy_die.bind()) 
		mob.dead.connect(self.entity_die.bind())
		spawn_entities += 1
	else:
		print("no player found")
