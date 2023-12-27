extends Control
signal saveQuit

@onready var option = $OptionContainer

func openOption():
	option.visible = true

func closeOption():
	option.visible = false

func saveQuitButton():
	emit_signal("saveQuit")

func update():
	$StatusDisplay/HBoxContainer/HPDisplay.update()
	$StatusDisplay/HBoxContainer/MoneyDisplay.update()
	$StatusDisplay/HBoxContainer/PotionDisplay.update()
	$StatusDisplay/HBoxContainer/RelicDisplay.update()
