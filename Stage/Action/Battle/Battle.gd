extends Node2D

var deck = Deck.new()



func _ready():
	var hands = [[Deck.PATTERN.SPADE, 1], [Deck.PATTERN.SPADE, 2], [Deck.PATTERN.SPADE, 3], [Deck.PATTERN.SPADE, 4], [Deck.PATTERN.SPADE, 5]]
	for hand in hands:
		deck.onHand.append(hand)
	hands = [[Deck.PATTERN.DIAMOND, 1], [Deck.PATTERN.DIAMOND, 2]]
	for hand in hands:
		deck.onHand.append(hand)
	hands = [[Deck.PATTERN.HEART, 1], [Deck.PATTERN.HEART, 2], [Deck.PATTERN.HEART, 3], [Deck.PATTERN.HEART, 4]]
	for hand in hands:
		deck.onHand.append(hand)
	hands = [[Deck.PATTERN.CLOVER, 1], [Deck.PATTERN.CLOVER, 2], [Deck.PATTERN.CLOVER, 3], [Deck.PATTERN.CLOVER, 4], [Deck.PATTERN.CLOVER, 5]]
	for hand in hands:
		deck.onHand.append(hand)
	deck.shuffle()
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
