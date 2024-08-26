extends Relic

func activate_relic(owner: RelicUI) -> void:
	var restScene = load("res://RestScene/RestScene.tscn").instantiate()
	restScene.get_node("Exercise").visible = true
	restScene.attackPlus = 3
	owner.flash()



