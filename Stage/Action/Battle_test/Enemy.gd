extends Node2D

signal turn_end	# 턴이 종료되면 발생
signal attack_end	# 공격이 종료되면 발생
signal move_done	# 이동 종료되면 발생


@onready var upRay = $DetectRays/Up
@onready var downRay = $DetectRays/Down
@onready var leftRay = $DetectRays/Left
@onready var rightRay = $DetectRays/Right
@onready var leftUpRay = $DetectRays/LeftUp
@onready var rightUpRay = $DetectRays/RightUp
@onready var leftDownRay = $DetectRays/LeftDown
@onready var rightDownRay = $DetectRays/RightDown

@onready var tile_map = $"../TileMap"

@onready var player = $"../Player"

var astar_grid:AStarGrid2D
var detected = false
var tween

var max_hp
var cur_hp
var atk


# astar_grid를 설정하는 부분
func set_astar_grid():
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
	
	for enemy in get_tree().get_nodes_in_group('enemy'):
		if enemy == self:
			continue
		#tile_map.local_to_map(enemy.global_position)
		astar_grid.set_point_solid(tile_map.local_to_map(enemy.global_position))


# 턴 시작
func turn_start():
	if not detected:
		detect_player()
		await detect_player()
		if not detected:
			await get_tree().create_timer(.2).timeout
			emit_signal("turn_end")
			return
	
	set_astar_grid()
	
	var path = astar_grid.get_id_path(
		tile_map.local_to_map(global_position),
		tile_map.local_to_map(player.global_position)
	)
	
	if path.is_empty():
		emit_signal("turn_end")
		return
	
	var is_attacked = false
	path.pop_front()
	if path.size() == 1:
		if upRay.is_colliding():
			attack(Vector2.UP)
			is_attacked = true
		elif downRay.is_colliding():
			attack(Vector2.DOWN)
			is_attacked = true
		elif leftRay.is_colliding():
			attack(Vector2.LEFT)
			is_attacked = true
		elif rightRay.is_colliding():
			attack(Vector2.RIGHT)
			is_attacked = true
		await attack_end
		#await get_tree().create_timer(.2).timeout
	
	if not is_attacked:
		var target_position = tile_map.map_to_local(path[0])
		move_to(target_position)
		await move_done
	#var target_position = tile_map.map_to_local(path[0])
	#move_to(target_position)
	#await move_done
	emit_signal("turn_end")


# 플레이어를 감지하는 함수
func detect_player():
	if upRay.is_colliding():
		detected = true
	if downRay.is_colliding():
		detected = true
	if leftRay.is_colliding():
		detected = true
	if rightRay.is_colliding():
		detected = true
	if leftUpRay.is_colliding():
		detected = true
	if rightUpRay.is_colliding():
		detected = true
	if leftDownRay.is_colliding():
		detected = true
	if rightDownRay.is_colliding():
		detected = true


# 공격하는 메소드
func attack(direction):
	var original_position = global_position
	tween = create_tween()
	tween.tween_property(self, "position", original_position + direction * 64, .25)
	tween.tween_property(self, "position", original_position, .25)
	tween.tween_callback(func():emit_signal("attack_end"))


# 이동하는 함수
func move_to(target_position):
	tween = create_tween()
	tween.tween_property(self, "position", target_position, .5)
	tween.tween_callback(func():emit_signal("move_done"))
