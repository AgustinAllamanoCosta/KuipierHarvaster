class_name BaseOre extends StaticBody3D

@export var health = 10
@export var ore_name = 'Base Ore'
@export var type = 'base'
@export var value = 10

@onready var health_tool: HealthBarTool = $HealthBarTool

var isDestroy = false

func _ready():
	health_tool.entity_health = health

func _process(delta):
	if health <= 0:
		isDestroy = true

func mine(damage):
	health = health - damage
	health_tool.take_damage(damage)
