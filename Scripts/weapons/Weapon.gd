class_name Weapon extends Node3D

var base_attack = 1
@export var bullet_blueprint: PackedScene
@onready var carrier: BasicEntity
@onready var attack_range: Area3D = $EnemiesDetector
var target = null

func _process(delta):
	
	var direction = carrier.direction.normalized()
	var up = Vector3.UP
	var targets = attack_range.get_overlapping_bodies()

	if(targets.is_empty()):
		if not direction.cross(up).is_zero_approx():
			$Pivote.look_at(position + direction,up)
	else:
		if targets[0]:
			target = targets[0]
			$Pivote.look_at(targets[0].global_position)

func _on_timer_timeout():

	if(target != null):
		var bullet = bullet_blueprint.instantiate()
		bullet.transform = $Pivote.global_transform
		bullet.velocity = -bullet.transform.basis.z * bullet.muzzle_velocity
		carrier.add_sibling(bullet)

func enemy_die():
	target = null
