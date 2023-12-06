extends Node

@onready var map = $MapCard
var mapActive:bool:
	set(value):
		mapActive = value
		if not value:
			map.get_child(0).visible = false
		else:
			map.get_child(0).visible = true
# Called when the node enters the scene tree for the first time.
func _ready():
	map.interactable = false
	mapActive = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func start_stage(type):
	print(type,"이 선택됨")
	match type:
		"일반 적":
			get_tree().change_scene_to_file("res://Battle/Battle.tscn")


func stage_done():
	map.interactable = true
	mapActive = true
	get_tree().create_timer(1).timeout
	
	var current_scene = get_tree().current_scene
	var packed_scene = PackedScene.new()
	
	if packed_scene.pack(current_scene) == OK:
		GameManager.gameData.savedScene = packed_scene
		GameManager.saveData()
