extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func start_stage(type):
	print(type,"이 선택됨")
	match type:
		"일반 적":
			
			#get_tree().change_scene_to_file("res://Battle/Battle.tscn")
