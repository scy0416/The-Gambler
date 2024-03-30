extends Node2D
signal turn_end

@onready var tile_map = $"../TileMap"
@onready var player = $"../Player"
@onready var right = $DetectRange/Right
@onready var left = $DetectRange/Left
@onready var up = $DetectRange/Up
@onready var down = $DetectRange/Down
@onready var right_up = $DetectRange/RightUp
@onready var left_up = $DetectRange/LeftUp
@onready var right_down = $DetectRange/RightDown
@onready var left_down = $DetectRange/LeftDown

var astar_grid:AStarGrid2D
var target_position
var detected = false
var tween

var max_hp = 100
var current_hp = 100
var atk = 10


func _ready():
	#detected = false
	astar_grid = AStarGrid2D.new()
	astar_grid.region = tile_map.get_used_rect()
	astar_grid.cell_size = Vector2(64, 64)
	astar_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astar_grid.update()
	
	var region_size = astar_grid.region.size
	var region_position = astar_grid.region.position
	
	for x in region_size.x:
		for y in region_size.y:
			var tile_position = Vector2i(
				x + region_position.x,
				y + region_position.y
			)
			
			var tile_data = tile_map.get_cell_tile_data(0, tile_position)
			
			if tile_data == null or tile_data.get_collision_polygons_count(0) > 0:
				astar_grid.set_point_solid(tile_position)


func turn_start():
	print("적 턴 시작")
	print(detected)
	if not detected:
		detect_enemy()
		if not detected:
			print("결국 찾지 못함")
			await get_tree().create_timer(.2).timeout
			emit_signal("turn_end")
			return
	
	var path = astar_grid.get_id_path(
		tile_map.local_to_map(global_position),
		tile_map.local_to_map(player.global_position)
	)
	
	if path.is_empty():
		print("Can't find path")
		return
	
	print(detected)
	path.pop_front()
	if path.size() == 1:
		if right.is_colliding():
			attack_right()
		elif left.is_colliding():
			attack_left()
		elif up.is_colliding():
			attack_up()
		elif down.is_colliding():
			attack_down()
		await get_tree().create_timer(.2).timeout
		emit_signal("turn_end")
		return
	
	target_position = tile_map.map_to_local(path[0])
	move_to(target_position)
	await get_tree().create_timer(.2).timeout
	emit_signal("turn_end")


func detect_enemy():
	print("탐색중")
	#if right.is_colliding():
	if right.is_colliding():
		detected = true
	if left.is_colliding():
		print("실행")
		detected = true
	if up.is_colliding():
		detected = true
	if down.is_colliding():
		detected = true
	if right_up.is_colliding():
		detected = true
	if left_up.is_colliding():
		detected = true
	if right_down.is_colliding():
		detected = true
	if left_down.is_colliding():
		detected = true
	print("탐색 종료")


func attack_right():
	tween = create_tween()
	tween.tween_property(self, "position", position + Vector2(64, 0), .1)
	tween.tween_property(self, "position", position, .1)


func attack_left():
	tween = create_tween()
	tween.tween_property(self, "position", position + Vector2(-64, 0), .1)
	tween.tween_property(self, "position", position, .1)


func attack_up():
	tween = create_tween()
	tween.tween_property(self, "position", position + Vector2(0, -64), .1)
	tween.tween_property(self, "position", position, .1)


func attack_down():
	tween = create_tween()
	tween.tween_property(self, "position", position + Vector2(0, 64), .1)
	tween.tween_property(self, "position", position, .1)


func move_to(target_position):
	tween = create_tween()
	tween.tween_property(self, "position", target_position, .5)
	#tween.tween_callback(func():emit_signal("moving_done"))
