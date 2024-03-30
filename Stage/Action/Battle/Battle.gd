extends Node2D


func _ready():
	#print("전투 시작")
	#start_battle()
	#print(Vector2.RIGHT)
	#$Player.move(Vector2.RIGHT)
	start_battle()


func start_battle():
	while true:
		await play()


func play():
	await player_turn()
	await enemy_turn()


func player_turn():
	$Player.turn_start()
	await $Player.turn_end
	print("플레이어 턴 종료")


func enemy_turn():
	$Enemy.turn_start()
	await $Enemy.turn_end
	print("적 턴 종료")


'''
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				#$TileMap.local_to_map(get_global_mouse_position())
				print(get_global_mouse_position(), $TileMap.local_to_map(get_global_mouse_position()))
'''
