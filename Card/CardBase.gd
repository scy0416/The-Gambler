extends Button

@onready var cardDataBase = preload("res://Card/CardDatabase.gd")
var cardName = "Clover1"
@onready var cardIndex = cardDataBase[cardName]
@onready var cardInfo = cardDataBase.DATA[cardIndex]
@onready var cardImage = str("res://Card//Resource/" + cardName + ".png")

var normal_icon_modulate = Color(1, 1, 1, 1)
var hover_icon_modulate = Color(0.8, 0.8, 0.8, 1)
# Called when the node enters the scene tree for the first time.
func _ready():
	set_button_icon(load(cardImage))

func _on_mouse_entered():
	modulate = hover_icon_modulate
	
func _on_mouse_exited():
	modulate =	normal_icon_modulate
