extends Node2D
class_name num_card

enum PATTERN {SPADE = 1, DIAMOND, HEART, CLOVER}
enum NUM {CA = 1, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, CJ}

@onready var back = $Back
@onready var front = $Front
@onready var label = $Label

var isBack:
	set(value):
		isBack = value
		display_callback()
var num = NUM.CA
var pattern = PATTERN.SPADE


func _ready():
	isBack = false


func display_callback():
	make_label()
	if isBack:
		$Back.visible = true
		$Front.visible = false
		$Label.visible = false
	else:
		$Back.visible = false
		$Front.visible = true
		$Label.visible = true


func make_label():
	var label = ""
	match pattern:
		PATTERN.SPADE:
			label += "스페이드"
		PATTERN.DIAMOND:
			label += "다이아몬드"
		PATTERN.HEART:
			label += "하트"
		PATTERN.CLOVER:
			label += "클로버"
	label += "\n"
	label += str(num)
	$Label.text = label
