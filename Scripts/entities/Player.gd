class_name Player extends BasicEntity

var speed = 14
var health = 10
@onready var weapon: Weapon = $Pivot/Weapon
@onready var builderTool: BaseBuilder = $Pivot/BuilderTool
@onready var miner: BaseMiner = $Pivot/Miner

signal player_dead

func _ready():

	weapon.carrier = self
	if builderTool:
		builderTool.carrier = self

func look_at_move():

	if self.direction != Vector3.ZERO:
		$Pivot.look_at(position + self.direction, Vector3.UP)

func _physics_process(delta):
	self.calculate_gravity(delta)
	self.input_controller()
	self.calculate_target_velocity(speed)
	look_at_move()
	self.move_entity(delta)

func _on_enemies_detector_body_entered(body):
	
	if "mob_damage"  in body:
		health -= body.mob_damage 
		if health <= 0:
			player_dead.emit()

func get_ore_from_inventory(ore_type:String):

	var ore = miner.get_ore_by_type(ore_type)
	return ore
