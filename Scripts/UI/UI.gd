class_name UI extends Control

@onready var signalBus: SignalBus = get_node("/root/SignalBus")

func _ready():
	get_tree().paused = true
	$Retry.hide()
	$MainMenu.show()
	$WinScrren.hide()
	$MainMenu/CenterContainer/VBoxContainer/StartButton.grab_focus()
	signalBus.connect('player_dead',_on_main_player_lose)
	signalBus.connect('player_win',_on_main_player_win)

func _unhandled_input(event):
	if $Retry.visible:
		get_tree().reload_current_scene()

func _on_start_button_pressed():
	get_tree().paused = false
	$MainMenu.hide()
	$Retry.hide()

func _process(delta):
	if Input.is_action_pressed("accept"):
		$MainMenu/CenterContainer/VBoxContainer/StartButton.emit_signal("pressed")
		self.signalBus.emit('game_start')

func _on_main_player_win():
	get_tree().paused = true
	$WinScrren.show()

func _on_main_player_lose():
	get_tree().paused = true
	$Retry.show()
