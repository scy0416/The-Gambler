extends Node




func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://GameManagerTestingFolder/SaveSelect.tscn")
	

func _on_option_button_pressed():
	pass # Replace with function body.	



func _on_quit_button_pressed():
	$UI/MainMenu.visible = false
	$QuitCheck.visible = true


func _on_quit_yes_pressed():
	get_tree().quit()


func _on_quit_no_pressed():
	$UI/MainMenu.visible = true
	$QuitCheck.visible = false
