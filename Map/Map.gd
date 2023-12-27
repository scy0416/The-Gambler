extends Control

signal start_stage(type)

@onready var level1 = $MarginContainer/ScrollContainer/VBoxContainer/MapLevel1
@onready var level2 = $MarginContainer/ScrollContainer/VBoxContainer/MapLevel2
@onready var level3 = $MarginContainer/ScrollContainer/VBoxContainer/MapLevel3
@onready var level4 = $MarginContainer/ScrollContainer/VBoxContainer/MapLevel4
@onready var level5 = $MarginContainer/ScrollContainer/VBoxContainer/MapLevel5
@onready var level6 = $MarginContainer/ScrollContainer/VBoxContainer/MapLevel6
@onready var level7 = $MarginContainer/ScrollContainer/VBoxContainer/MapLevel7
@onready var level8 = $MarginContainer/ScrollContainer/VBoxContainer/MapLevel8
@onready var level9 = $MarginContainer/ScrollContainer/VBoxContainer/MapLevel9
@onready var level10 = $MarginContainer/ScrollContainer/VBoxContainer/MapLevel10
@onready var level11 = $MarginContainer/ScrollContainer/VBoxContainer/MapLevel11
@onready var level12 = $MarginContainer/ScrollContainer/VBoxContainer/MapLevel12
@onready var level13 = $MarginContainer/ScrollContainer/VBoxContainer/MapLevel13
@onready var level14 = $MarginContainer/ScrollContainer/VBoxContainer/MapLevel14
@onready var level15 = $MarginContainer/ScrollContainer/VBoxContainer/MapLevel15

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
	initial()
	if GameManager.gameData.savedSceneState.is_empty():
		return
	update()

func initial():
	for level in levels:
		level.MakeMapNode()
	for map in level15.mapNodeList:
		map.flip()
	await get_tree().create_timer(.9).timeout
	$AnimationPlayer.play("to_bottom")
	await get_tree().create_timer(1).timeout
	level1.map1.flip()
	level1.map3.flip()
	level1.map5.flip()
	level1.map7.flip()
	level1.activate_level()
	
	saveState()

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
	GameManager.gameData.savedSceneState["interactable"] = interactable
	for level in levels:
		level.saveState()
	GameManager.saveData()

func update():
	for level in levels:
		level.update()
