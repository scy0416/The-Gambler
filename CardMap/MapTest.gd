extends Control

@onready var map = $Map


func _on_button_pressed():
	map.scroll_open()


func _on_button_2_pressed():
	map.selectable_open()


func _on_button_3_pressed():
	map.unselectable_open()


func _on_button_4_pressed():
	map.visible = false
