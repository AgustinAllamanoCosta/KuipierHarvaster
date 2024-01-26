class_name Player extends BasicEntity

var speed = 14
var health = 10
var direction = Vector3.ZERO
@onready var weapon: Weapon = $Pivot/Weapon
@onready var builderTool: BaseBuilder = $Pivot/BuilderTool
@onready var miner: BaseMiner = $Pivot/Miner

signal player_dead

func _ready():

	weapon.carrier = self
	if builderTool:
		builderTool.carrier = self

func look_at_move(direction):

	if direction != Vector3.ZERO:
		$Pivot.look_at(position + self.direction, Vector3.UP)

func _physics_process(delta):
	var direction = Vector3.ZERO
	var gravity_force = self.calculate_gravity(delta)
	direction = self.input_controller(direction)
	var target_velocity = self.calculate_target_velocity(speed,direction,Vector3.ZERO)
	look_at_move(direction)
	self.move_entity(delta,target_velocity)
	self.direction = direction

func _on_enemies_detector_body_entered(body):
	
	if "mob_damage"  in body:
		health -= body.mob_damage 
		if health <= 0:
			player_dead.emit()

func get_ore_from_inventory(ore_type:String):

	var ore = miner.get_ore_by_type(ore_type)
	return ore
