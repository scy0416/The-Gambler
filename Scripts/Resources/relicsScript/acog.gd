extends Relic

@export var rngPlus = 2

func activate_relic(owner: RelicUI) -> void:
	var player := owner.get_tree().get_first_node_in_group("Player") as Player
	if player:
		player.stats.setRng(player.stats.getRng() + rngPlus)
		owner.flash()

