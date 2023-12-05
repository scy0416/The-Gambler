extends Control

@onready var option = $OptionContainer

func openOption():
	option.visible = true

func closeOption():
	option.visible = false

func saveQuit():
	pass
