extends Relic

@export var maxLifePlus = 8

func activate_relic(owner: RelicUI) -> void:
	var player := owner.get_tree().get_first_node_in_group("Player") as Player
	if player:
		player.stats.setMaxLife(player.stats.getMaxLife() + 8)
		owner.flash()

