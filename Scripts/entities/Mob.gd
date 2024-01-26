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
		
		var direction = Vector3.ZERO
		var gravity_force = self.calculate_gravity(delta)
		direction = self.input_controller(direction_to_player)
		var target_velocity = self.calculate_target_velocity(speed,direction,Vector3.ZERO)
		self.move_entity(delta,target_velocity)

func _process(delta):
	if(life <= 0):
		dead.emit()
		queue_free()

func hurt(damage):
	life = life - damage
	health_bar.take_damage(damage)
