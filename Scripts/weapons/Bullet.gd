class_name Bullet extends Node3D

var velocity = Vector3.ZERO
var muzzle_velocity = 25
var damage = 1

func _process(delta):
	transform.origin += velocity * delta
	
func _on_bullet_timer_timeout():
	queue_free()

func _on_bullet_body_body_entered(body):
	body.hurt(damage)
	queue_free()
