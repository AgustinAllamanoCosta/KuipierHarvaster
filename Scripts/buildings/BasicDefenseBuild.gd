class_name BasicDefenseBuild extends BasicEntity

@export var health = 10
@onready var health_tool: HealthBarTool = $HealthBarTool
@onready var weapon: Weapon = $Weapon

func _ready():
	health_tool.entity_health = health
	$Weapon.carrier = self

func _process(delta):
	if health <= 0:
		queue_free()

func hurt(damage):
	health = health - damage
	health_tool.take_damage(damage)
