class_name UI extends Control

signal game_start

func _ready():
	get_tree().paused = true
	$Retry.hide()
	$MainMenu.show()
	$WinScrren.hide()
	$MainMenu/CenterContainer/VBoxContainer/StartButton.grab_focus()

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
		game_start.emit()

func _on_main_player_win():
	get_tree().paused = true
	$WinScrren.show()

func _on_main_player_lose():
	get_tree().paused = true
	$Retry.show()
