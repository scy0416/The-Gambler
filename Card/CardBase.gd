extends Button

@onready var cardDataBase = preload("res://Card/CardDatabase.gd")
var cardName = "Clover1"
@onready var cardIndex = cardDataBase[cardName]
@onready var cardInfo = cardDataBase.DATA[cardIndex]
@onready var cardImage = str("res://Card//Resource/" + cardName + ".png")

var normal_icon_modulate = Color(1, 1, 1, 1)
var hover_icon_modulate = Color(0.8, 0.8, 0.8, 1)

func _ready():
	set_button_icon(load(cardImage))
	set_size(Vector2(90, 163))
	mouse_entered.connect(mouse_i)
	mouse_exited.connect(mouse_o)


func mouse_i():
	modulate = Color(0.8, 0.8, 0.8, 1)
func mouse_o():
	modulate = Color(1, 1, 1, 1)
