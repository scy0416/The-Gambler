extends Node

signal start_stage(type)

@onready var level1 = $UI/MarginContainer/ScrollContainer/VBoxContainer/MapLevelCard1
@onready var level2 = $UI/MarginContainer/ScrollContainer/VBoxContainer/MapLevelCard2
@onready var level3 = $UI/MarginContainer/ScrollContainer/VBoxContainer/MapLevelCard3
@onready var level4 = $UI/MarginContainer/ScrollContainer/VBoxContainer/MapLevelCard4
@onready var level5 = $UI/MarginContainer/ScrollContainer/VBoxContainer/MapLevelCard5
@onready var level6 = $UI/MarginContainer/ScrollContainer/VBoxContainer/MapLevelCard6
@onready var level7 = $UI/MarginContainer/ScrollContainer/VBoxContainer/MapLevelCard7
@onready var level8 = $UI/MarginContainer/ScrollContainer/VBoxContainer/MapLevelCard8
@onready var level9 = $UI/MarginContainer/ScrollContainer/VBoxContainer/MapLevelCard9
@onready var level10 = $UI/MarginContainer/ScrollContainer/VBoxContainer/MapLevelCard10
@onready var level11 = $UI/MarginContainer/ScrollContainer/VBoxContainer/MapLevelCard11
@onready var level12 = $UI/MarginContainer/ScrollContainer/VBoxContainer/MapLevelCard12
@onready var level13 = $UI/MarginContainer/ScrollContainer/VBoxContainer/MapLevelCard13
@onready var level14 = $UI/MarginContainer/ScrollContainer/VBoxContainer/MapLevelCard14
@onready var level15 = $UI/MarginContainer/ScrollContainer/VBoxContainer/MapLevelCard15

@onready var levels = [level1, level2, level3, level4, level5, level6,
level7, level8, level9, level10, level11, level12, level13, level14, level15]

var isPressed:bool
@onready var vBox = $UI/MarginContainer/ScrollContainer/VBoxContainer
@onready var Scroll = $UI/MarginContainer/ScrollContainer
var interactable:bool = true:
	set(value):
		if value:
			for level in levels:
				level.activate_interact()
		else:
			for level in levels:
				level.deactivate_interact()
		interactable = value

func _ready():
	for level in levels:
		level.MakeMapNode()
	for map in $UI/MarginContainer/ScrollContainer/VBoxContainer/MapLevelCard15.mapNodeList:
		map.flip()
	await get_tree().create_timer(.9).timeout
	$AnimationPlayer.play("to_bottom")
	await get_tree().create_timer(1).timeout
	level1.map1.flip()
	level1.map3.flip()
	level1.map5.flip()
	level1.map7.flip()
	level1.activate_level()

#기능: 마우스 드래그를 통해 화면을 움직이게 한다.
func input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT: # 클릭 여부를 체크
		if not isPressed and event.pressed: #클릭 시 '누름' 상태가 아닐 경우
			isPressed = true
		if isPressed and not event.pressed: #클릭 해제시 '누름' 상태일 경우
			isPressed = false
	
	var isOverlaped = checkOverLabed(event.get_position().x)
	if event is InputEventMouseMotion and isPressed and !isOverlaped: #드래그 여부를 체크
		Scroll.set_deferred("scroll_vertical", Scroll.scroll_vertical - event.get_relative().y)

#플레이어가 드래그를 시작한 위치가 스크롤 바와 겹쳤는지 체크
func checkOverLabed(x):
	return x >= Scroll.get_v_scroll_bar().position.x


func card_selected(type, num):
	emit_signal("start_stage", type)
