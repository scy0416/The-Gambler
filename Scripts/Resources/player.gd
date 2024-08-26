class_name Player
extends Node2D

@export var stats: GameData : set = set_character_stats


func set_character_stats(value: GameData) -> void:
	stats = value

func take_damage(damage : int) -> void:
	if damage <= 0:
		return
	stats.setLife(stats.getLife() - damage)	
	
