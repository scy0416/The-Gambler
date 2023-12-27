extends Control

@onready var label = $HBoxContainer/Money

func update():
	label.text = "%d" % [GameManager.gameData.gold]
