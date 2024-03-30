extends Node2D
signal moving_done
signal draw_done
signal key_pressed
signal turn_end

enum DIRECTION{UP,DOWN,LEFT,RIGHT}

@onready var tile_map = $"../TileMap"
@onready var ray_cast_2d = $RayCast2D
@onready var attack_area = $AttackArea

var tween
var pressed_key

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
			emit_signal("turn_end")
	#emit_signal("turn_end")


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
	draw_card()
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
	pass
