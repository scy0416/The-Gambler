extends Control

signal card_button_clicked(type)

@export_enum("일반 적", "엘리트 적", "보스 전투", "이벤트", "휴식", "상점") var type:String:
	set(value):
		type = value
		$ContentButton.text = value

@export var is_front:bool = false
var is_activated = true
var is_interact_activated = true

func _ready():
	set_back()

func flip():
	$AnimationPlayer.play("flip_card")

func close():
	$AnimationPlayer.play("close_card")

func card_selected():
	emit_signal("card_button_clicked", type)

func activate_node():
	$ContentButton.disabled = false
	is_activated = true

func deactivate_node():
	$ContentButton.disabled = true
	is_activated = false

func deactivate_interact():
	$ContentButton.mouse_filter = MOUSE_FILTER_IGNORE
	is_interact_activated = false

func activate_interact():
	$ContentButton.mouse_filter = MOUSE_FILTER_STOP
	is_interact_activated = true

func set_front():
	$CardBack.visible = false
	$ContentButton.visible = true
	$ContentButton.position.x = 0
	$ContentButton.scale.x = 1

func set_back():
	$CardBack.visible = true
	$CardBack.position.x = 140
	$CardBack.scale.x = -1
	$ContentButton.visible = false

func update():
	pass
