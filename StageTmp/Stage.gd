extends Node

@onready var map = $Map

var mapVisible:bool:
	set(value):
		mapVisible = value
		if not value:
			map.visible = false
		else:
			map.visible = true

func _ready():
	initial()
	if GameManager.gameData.savedSceneState.is_empty():
		saveState()
		return
	update()

func initial():
	map.interactable = false
	mapVisible = false

func update():
	mapVisible = GameManager.gameData.savedSceneState["mapVisible"]
	if mapVisible:
		map.visible = true
	else:
		map.visible = false
	get_child(0).update()

func saveState():
	GameManager.gameData.savedSceneState["mapVisible"] = mapVisible
	GameManager.gameData.savedSceneState["map_activate"] = map.interactable
	var current_scene = get_tree().current_scene
	var packed_scene = PackedScene.new()
	if packed_scene.pack(current_scene) == OK:
		GameManager.gameData.savedScene = packed_scene
		GameManager.saveData()
	map.saveState()
	get_child(0).saveState()
	GameManager.saveData()

func action_done():
	get_child(0).deactivate()
	
	map.interactable = true
	mapVisible = true
	map.activate_interact()
	get_tree().create_timer(1).timeout
	
	saveState()

func action_start(type):
	get_child(0).is_stage_done = true
	map.interactable = false
	map.deactivate_interact()
	await get_tree().create_timer(1.5).timeout
	mapVisible = false
	match type:
		"일반 적":
			get_child(0).set_owner(null)
			get_child(0).queue_free()
			var battle_scene = preload("res://StageTmp/Action/Battle/Battle.tscn").instantiate()
			add_child(battle_scene)
			move_child(battle_scene, 0)
			battle_scene.set_owner(self)
	saveState()

func saveAndQuit():
	get_tree().change_scene_to_file("res://Title/Title.tscn")
