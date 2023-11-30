class_name Mob extends BasicEntity

var enemy_position = Vector3.ZERO
var life = 4
var mob_damage = 10
@export var speed = 7
@export var player: Node3D
@onready var health_bar: HealthBarTool = $HealthBarTool

signal dead

func _ready():
	health_bar.entity_health = life

func _physics_process(delta):
	if player != null:
		var direction_to_player = (player.global_position - global_position).normalized()
		pyshics.target_velocity.x = direction_to_player.x * speed
		pyshics.target_velocity.z = direction_to_player.z * speed

		velocity = pyshics.target_velocity
		super(delta)
		move_and_slide()

func _process(delta):
	if(life <= 0):
		dead.emit()
		queue_free()

func hurt(damage):
	life = life - damage
	health_bar.take_damage(damage)
