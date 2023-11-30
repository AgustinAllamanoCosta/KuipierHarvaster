class_name Player extends BasicEntity

var speed = 14
var health = 10
@onready var weapon: Weapon = $Weapon

signal player_dead

func _ready():
	weapon.carrier = self

func look_at_move(direction):

	if direction != Vector3.ZERO:
		direction = direction.normalized()
		$Pivot.look_at(position + direction, Vector3.UP)


func _physics_process(delta):

	direction = input.input_controller()
	look_at_move(direction)

	pyshics.target_velocity.x = direction.x * speed
	pyshics.target_velocity.z = direction.z * speed

	velocity = pyshics.target_velocity
	super(delta)
	move_and_slide()

func _on_enemies_detector_body_entered(body):
	health -= body.mob_damage

	if health <= 0:
		player_dead.emit()
