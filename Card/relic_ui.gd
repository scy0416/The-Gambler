extends Control
class_name RelicUI

@export var relic: Relic : set = set_relic

@onready var icon: TextureButton = $Icon
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	relic = preload("res://Scripts/Resources/allRelics/sword.tres")
	await get_tree().create_timer(2.0).timeout
	flash()
	
func set_relic(new_relic: Relic) -> void:
		if not is_node_ready():
			await ready
		
		relic = new_relic
		icon.texture_normal = relic.icon
		
func flash() -> void:
	animation_player.play("flash")
	
func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_mouse"):
			print("Relic tooltip")
	

