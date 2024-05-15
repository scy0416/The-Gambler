extends Node2D
signal moving_done
signal draw_done
signal key_pressed
signal turn_end
signal delete_card_selected
signal delete_card_button

enum DIRECTION{UP,DOWN,LEFT,RIGHT}

@onready var tile_map = $"../TileMap"
@onready var ray_cast_2d = $RayCast2D
@onready var attack_area = $AttackArea

var tween
var card_tween
var pressed_key
var deck
var hand = []

func _ready():
	deck = $"..".deck


func turn_start():
	print("이동 또는 공격을 선택")
	$"../HUD/MoveAttack".visible = true
	await $"../HUD/MoveAttack".action_selected
	$"../HUD/MoveAttack".visible = false
	match $"../HUD/MoveAttack".action:
		"move":
			print("이동 처리")
			move_proc()
		"attack":
			print("공격 처리")
			await get_tree().create_timer(.2).timeout
			attack()
			emit_signal("turn_end")
	#emit_signal("turn_end")

func attack():
	print("공격")
	print(deck)
	pass

func move_proc():
	print("입력 처리 중")
	await key_pressed
	match pressed_key:
		KEY_W:
			print("위쪽 이동")
			move(Vector2.UP)
		KEY_A:
			print("왼쪽 이동")
			move(Vector2.LEFT)
		KEY_S:
			print("아래쪽 이동")
			move(Vector2.DOWN)
		KEY_D:
			print("오른쪽 이동")
			move(Vector2.RIGHT)
		_:
			print("잘못된 입력")
			move_proc()
			pass
	print("이동 끝")


func move(direction):
	if len(hand) < 5:
		print("손패가 5보다 작음")
		draw_card()
		await draw_done
	else:
		select_delete_card()
		await delete_card_selected
		print("손패가 5임")
	#draw_card()
	#await draw_done
	var current_tile = tile_map.local_to_map(global_position)
	var target_tile = Vector2i(
		current_tile.x + direction.x,
		current_tile.y + direction.y
	)
	var tile_data:TileData = tile_map.get_cell_tile_data(0, target_tile)
	
	ray_cast_2d.target_position = direction * 64
	ray_cast_2d.force_raycast_update()
	
	if ray_cast_2d.is_colliding():
		print("충돌")
		#return
		move_proc()
		return
	
	var target_position = tile_map.map_to_local(target_tile)
	#print(global_position)
	#print(current_tile)
	#print(target_position)
	move_to(target_position)
	await moving_done
	#print("움직임 완료")
	pass


func move_to(target_position):
	tween = create_tween()
	tween.tween_property(self, "position", target_position, .5)
	tween.tween_callback(func():emit_signal("moving_done"))
	tween.tween_callback(func():emit_signal("turn_end"))


func _input(event):
	if event is InputEventKey and event.pressed:
		pressed_key = event.keycode
		emit_signal("key_pressed")


func draw_card():
	print("카드 뽑기")
	var drew_card = deck.draw()
	hand.append(drew_card)
	#deck.offHand.append(drew_card)
	print(drew_card)
	var duplicated_card = $Card.duplicate()
	duplicated_card.pattern = drew_card[0]
	duplicated_card.num = drew_card[1]
	duplicated_card.visible = true
	duplicated_card.isBack = false
	add_child(duplicated_card)
	duplicated_card.position = Vector2.ZERO
	card_tween = create_tween()
	card_tween.tween_property(duplicated_card, "scale", Vector2(.5, .5), .5)
	
	#card_tween.tween_callback(Callable(self, "card_to_outside").bind(duplicated_card))
	
	card_tween.tween_callback(func():emit_signal("draw_done"))


func card_to_outside(card):
	var new_parent = get_node("/root").get_child(2)
	#print(new_parent)
	remove_child(card)
	new_parent.add_child(card)
	#card.position = Vector2(100, 100)
	#print(card.global_position)
	#print(card.position)


func delete_button_pressed(index):
	hand.pop_at(index)
	emit_signal("delete_card_button")
	pass


func select_delete_card():
	print("삭제할 카드 선택 시작")
	$CanvasLayer.visible = true
	var hand_cards = $CanvasLayer/Panel/HBoxContainer.get_children()
	var card_sprite
	for i in range(5):
		var card = hand[i]
		var pattern = card[0]
		var num = card[1]
		var image_path
		match pattern:
			Deck.PATTERN.SPADE:
				image_path = "res://Sprites/card/spade/spade_" + str(num) + ".png"
			Deck.PATTERN.DIAMOND:
				image_path = "res://Sprites/card/diamong/diamond_" + str(num) + ".png"
			Deck.PATTERN.HEART:
				image_path = "res://Sprites/card/heart/heart_" + str(num) + ".png"
			Deck.PATTERN.CLOVER:
				image_path = "res://Sprites/card/clover/clover_" + str(num) + ".png"
		var image = Image.new()
		image.load(image_path)
		var texture = ImageTexture.new()
		texture.create_from_image(image)
		hand_cards[i].get_child(0).get_child(0).texture = texture
	await delete_card_button
	emit_signal("delete_card_selected")
	pass
