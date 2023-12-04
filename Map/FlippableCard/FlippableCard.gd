extends Control

signal card_button_clicked(type)


@export_enum("일반 적", "엘리트 적", "보스 전투", "이벤트", "휴식", "상점") var type:String:
	set(value):
		type = value
		$ContentLabel.text = value

@export var is_flipped:bool = false

var is_mouse_on:bool = false


func flip():
	$AnimationPlayer.play("flip_card")


func close():
	$AnimationPlayer.play("close_card")


func mouse_in():
	is_mouse_on = true


func mouse_out():
	is_mouse_on = false


func card_selected():
	emit_signal("card_button_clicked", type)


func activate_node():
	$ContentLabel.disabled = false


func deactivate_node():
	$ContentLabel.disabled = true


func deactivate_interact():
	$ContentLabel.mouse_filter = MOUSE_FILTER_IGNORE


func activate_interact():
	$ContentLabel.mouse_filter = MOUSE_FILTER_STOP
