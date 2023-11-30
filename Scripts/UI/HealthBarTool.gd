class_name HealthBarTool extends Node3D

var entity_health = 1

func take_damage(damage):
	var damage_in_porcentage = (float(damage) / entity_health)*100
	$SubViewport/HealhtBar.value -= damage_in_porcentage
