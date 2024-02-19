extends Control

@onready var level1 = $MarginContainer/ScrollContainer/VBoxContainer/Level1
@onready var level2 = $MarginContainer/ScrollContainer/VBoxContainer/Level2
@onready var level3 = $MarginContainer/ScrollContainer/VBoxContainer/Level3
@onready var level4 = $MarginContainer/ScrollContainer/VBoxContainer/Level4
@onready var level5 = $MarginContainer/ScrollContainer/VBoxContainer/Level5
@onready var level6 = $MarginContainer/ScrollContainer/VBoxContainer/Level6
@onready var level7 = $MarginContainer/ScrollContainer/VBoxContainer/Level7
@onready var level8 = $MarginContainer/ScrollContainer/VBoxContainer/Level8
@onready var level9 = $MarginContainer/ScrollContainer/VBoxContainer/Level9
@onready var level10 = $MarginContainer/ScrollContainer/VBoxContainer/Level10
@onready var level11 = $MarginContainer/ScrollContainer/VBoxContainer/Level11
@onready var level12 = $MarginContainer/ScrollContainer/VBoxContainer/Level12
@onready var level13 = $MarginContainer/ScrollContainer/VBoxContainer/Level13
@onready var level14 = $MarginContainer/ScrollContainer/VBoxContainer/Level14
@onready var level15 = $MarginContainer/ScrollContainer/VBoxContainer/Level15

@onready var levels = [level1, level2, level3, level4, level5, level6, level7,
level8, level9, level10, level11, level12, level13, level14, level15]

var isPressed:bool

@onready var scroll = $MarginContainer/ScrollContainer

var interactable:bool:
	set(value):
		if value:
			activate_interact()
		else:
			deactivate_interact()
		interactable = value


func activate_interact():
	for level in levels:
		level.activate_interact()


func deactivate_interact():
	for level in levels:
		level.deactivate_interact()


func _ready():
	for level in levels:
		level.map = self
	if GameManager.gameData.map_resource == null:
		initial()
		return
	update()


func initial():
	GameManager.gameData.map_resource = MapResource.new()
	for level in levels:
		level.MakeMapNode()
	#level1.activate_level()
	activate_interact()
	saveState()
	#scroll_open()


func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if not isPressed and event.pressed:
			isPressed = true
		if isPressed and not event.pressed:
			isPressed = false
	
	if event is InputEventMouseMotion:
		var isOverlabed = checkOverLabed(event.get_position().x)
	
		if event is InputEventMouseMotion and isPressed and !isOverlabed:
			scroll.set_deferred("scroll_vertical", scroll.scroll_vertical - event.get_relative().y)


func checkOverLabed(x):
	return x >= scroll.get_v_scroll_bar().position.x


func card_selected(type, num):
	emit_signal("start_stage", type)


func saveState():
	for level in levels:
		level.saveState()

func update():
	for level in levels:
		level.update()


func scroll_open():
	activate_interact()
	visible = true
	for level in levels:
		for map in level.mapNodeList:
			if map.current_state == map.state.OPENED or map.current_state == map.state.WAIT:
				map.flip()
	$AnimationPlayer.play("to_bottom")


func selectable_open():
	activate_interact()
	visible = true


func unselectable_open():
	deactivate_interact()
	visible = true
