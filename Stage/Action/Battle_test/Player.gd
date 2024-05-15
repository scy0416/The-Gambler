extends Node2D

signal action_selected	# 플레이어가 행동을 선택하면 발생
signal key_pressed	# 키 입력할 때 발생
signal draw_done	# 카드 드로우 처리 끝나면 발생
signal delete_card_selected	# 버릴 카드를 정하면 발생
signal delete_card_done	# 카드를 버리면 발생
signal moving_done	# 이동을 완료하면 발생
signal turn_end	# 턴 종료 시 발생
signal attack_done	# 공격 종료 시 발생
signal attack_proc_done	# 공격 처리 종료 시 발생
signal move_proc_done	# 이동 처리 종료 시 발생
signal move_done	# move종료 시 발생


var deck = Deck.new()	# 플레이어의 덱 정보
@onready var actionSelect = $PlayerHUD/ActionSelect
var action	# 플레이어가 선택한 행동
var pressed_key	# 입력된 키
var hand = []	# 손패
var delete_index	# 버릴 카드의 인덱스
var tile_map	# 타일맵
@onready var ray_cast_2d = $DetectCollider	# 충돌을 확인하는 레이 캐스팅
var tween	# tween사용을 위한 변수
var hp	# 체력


func _ready():
	# 플레이어의 손패로 이 부분은 세이브 데이터에서 불러와야 한다.
	var hands = [[Deck.PATTERN.SPADE, 1], [Deck.PATTERN.SPADE, 2], [Deck.PATTERN.SPADE, 3], [Deck.PATTERN.SPADE, 4], [Deck.PATTERN.SPADE, 5]]
	for h in hands:
		deck.onHand.append(h)
	hands = [[Deck.PATTERN.DIAMOND, 1], [Deck.PATTERN.DIAMOND, 2]]
	for h in hands:
		deck.onHand.append(h)
	hands = [[Deck.PATTERN.HEART, 1], [Deck.PATTERN.HEART, 2], [Deck.PATTERN.HEART, 3], [Deck.PATTERN.HEART, 4]]
	for h in hands:
		deck.onHand.append(h)
	hands = [[Deck.PATTERN.CLOVER, 1], [Deck.PATTERN.CLOVER, 2], [Deck.PATTERN.CLOVER, 3], [Deck.PATTERN.CLOVER, 4], [Deck.PATTERN.CLOVER, 5]]
	for h in hands:
		deck.onHand.append(h)
	deck.shuffle()
	
	# 타일맵을 받아옴
	tile_map = $"../TileMap"
	
	# 체력은 게임 데이터에서 가져와야 한다.
	hp = 100


# 턴 시작 함수
func turn_start():
	# 플레이어의 행동 선택
	actionSelect.visible = true
	await action_selected
	actionSelect.visible = false
	
	# 선택한 행동 시작
	match action:
		'move':
			move_proc()
			await move_proc_done
		'attack':
			attack_proc()
			await attack_proc_done
	emit_signal("turn_end")


# 행동 선택 버튼 이벤트 처리
func action_select_button(selected_action):
	action = selected_action
	emit_signal("action_selected")


# 이동을 처리하는 함수
func move_proc():
	# 이동 방향 입력
	while true:
		await key_pressed
		match pressed_key:
			KEY_W:
				break
			KEY_A:
				break
			KEY_S:
				break
			KEY_D:
				break
			_:
				pass
	
	match pressed_key:
		KEY_W:
			move(Vector2.UP)
		KEY_A:
			move(Vector2.LEFT)
		KEY_S:
			move(Vector2.DOWN)
		KEY_D:
			move(Vector2.RIGHT)
	await move_done
	emit_signal("move_proc_done")


# 공격을 처리하는 함수
func attack_proc():
	# 공격 방향 입력
	while true:
		await key_pressed
		match pressed_key:
			KEY_W:
				break
			KEY_A:
				break
			KEY_S:
				break
			KEY_D:
				break
			_:
				pass
	
	match pressed_key:
		KEY_W:
			attack(Vector2.UP)
		KEY_A:
			attack(Vector2.LEFT)
		KEY_S:
			attack(Vector2.DOWN)
		KEY_D:
			attack(Vector2.RIGHT)
	await attack_done
	emit_signal("attack_proc_done")


# 공격을 하는 함수
func attack(direction):
	tween = create_tween()
	var original_pos = global_position
	tween.tween_property(self, 'position', original_pos + direction * 64, .25)
	tween.tween_property(self, 'position', original_pos, .25)
	tween.tween_callback(func():emit_signal("attack_done"))


# 키보드 입력 처리
func _input(event):
	if event is InputEventKey and event.pressed:
		pressed_key = event.keycode
		emit_signal("key_pressed")


# 이동 함수
func move(direction):
	# 레이 캐스팅을 가고자 하는 방향으로 설정
	ray_cast_2d.target_position = direction * 64
	ray_cast_2d.force_raycast_update()
	
	# 충돌하는 물체가 존재하는 경우
	if ray_cast_2d.is_colliding():
		move_proc()
		return
	# 카드 드로우
	draw_card()
	await draw_done
	# 이동 처리 로직
	# 현재 위치에 해당하는 타일 정보 추출
	var current_tile = tile_map.local_to_map(global_position)
	# 가고자 하는 타일의 위치
	var target_tile = Vector2i(
		current_tile.x + direction.x,
		current_tile.y + direction.y
	)
	#var tile_data:TileData = tile_map.get_cell_tile_data(0, target_tile)
	
	# 가고자 하는 타일의 실제 위치 추출
	var target_position = tile_map.map_to_local(target_tile)
	# 실제 이동
	move_to(target_position)
	await moving_done
	emit_signal("move_done")


# 실제로 이동을 처리하는 함수
func move_to(target_position):
	tween = create_tween()
	tween.tween_property(self, "position", target_position, .5)
	tween.tween_callback(func():emit_signal("moving_done"))
	#tween.tween_callback(func():emit_signal("turn_end"))


# 카드 드로우
func draw_card():
	await get_tree().create_timer(.1).timeout
	# 카드 드로우
	var drew_card = deck.draw()
	# 손패에 추가
	hand.append(drew_card)
	# 손이 꽉찬 경우
	if len(hand) > 5:
		# 카드 버리는 로직
		delete_card()
		await delete_card_done
	# 뽑은 카드 보여주는 이벤트 처리
	# 드로우 완료
	emit_signal("draw_done")


# 버릴 카드 선택하는 로직
func delete_card():
	# 손에 가지고 있는 패로 텍스쳐 변경
	# 텍스쳐를 담을 텍스쳐렉트 모음
	var texture_rects = []
	for child in $PlayerHUD/CardDelete/VBoxContainer/HBoxContainer.get_children():
		texture_rects.append(child.get_child(0).get_child(0))
	texture_rects.append($PlayerHUD/CardDelete/VBoxContainer/TextureRect)
	var rect_index = 0
	for card in hand:
		var pattern
		match card[0]:
			Deck.PATTERN.SPADE:
				pattern = 'spade'
			Deck.PATTERN.DIAMOND:
				pattern = 'diamond'
			Deck.PATTERN.HEART:
				pattern = 'heart'
			Deck.PATTERN.CLOVER:
				pattern = 'clover'
		var texture = load('res://Sprites/card/'+pattern+'/'+pattern+'_'+str(card[1])+'.png')
		texture_rects[rect_index].texture = texture
		rect_index += 1
		
	# 버릴 카드 선택 대기
	$PlayerHUD/CardDelete.visible = true
	await delete_card_selected
	$PlayerHUD/CardDelete.visible = false
	
	deck.offHand.append(hand[delete_index])
	hand.pop_at(delete_index)
	
	emit_signal("delete_card_done")


# 버릴 카드를 선택하는 버튼
func delete_card_button(index):
	delete_index = index
	emit_signal("delete_card_selected")
