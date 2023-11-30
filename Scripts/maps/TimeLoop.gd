class_name TimeLoop extends Node

var number_of_orde = 1

signal player_win
signal player_lose

func _on_timer_timeout():
	self.player_win.emit()

func _on_player_player_dead():
	$Timer.stop()
	self.player_lose.emit()

func _on_ui_game_start():
	$Timer.start()
