extends Relic

@export var atkPlus = 2

func activate_relic(owner: RelicUI) -> void:
	var player := owner.get_tree().get_first_node_in_group("Player") as Player
	if player:
		player.stats.setAtk(player.stats.getAtk() + atkPlus)
		owner.flash()
