extends Panel
signal action_selected
var action


func _on_move_pressed():
	action = "move"
	emit_signal("action_selected")


func _on_attack_pressed():
	action = "attack"
	emit_signal("action_selected")
