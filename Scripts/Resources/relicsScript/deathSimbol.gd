extends Relic

@export var lifePenalty = 20
@export var atkReward = 10

func activate_relic(owner: RelicUI) -> void:
	var player := owner.get_tree().get_first_node_in_group("Player") as Player
	if player:
		player.stats.setMaxLife(player.stats.getMaxLife() - lifePenalty)
		player.stats.setAtk(player.stats.getAtk() + atkReward)

