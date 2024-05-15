extends Node2D

var battle_end = false	# 전투가 종료 플래그


# 유물을 사용하는 함수
func use_relic():
	pass


# 아이템을 사용하는 함수
func use_item():
	pass


# 전투 시작 함수
func start_battle():
	while true:
		# 플레이어 턴
		if battle_end:
			break
		else:
			await player_turn()
		
		# 적 턴
		if battle_end:
			break
		else:
			await enemy_turn()


# 플레이어 행동 시작
func player_turn():
	var player = get_tree().get_first_node_in_group('player')
	player.turn_start()
	await player.turn_end


# 적 행동 시작
func enemy_turn():
	var enemies = get_tree().get_nodes_in_group('enemy')
	for enemy in enemies:
		enemy.turn_start()
		await enemy.turn_end


# 전투 종료
func battle_ended():
	battle_end = true


func _ready():
	start_battle()
