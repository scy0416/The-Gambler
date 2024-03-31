extends Button

@onready var cardDataBase = preload("res://Card/CardDatabase.gd")
var cardName = "Clover1"
@onready var cardIndex = cardDataBase[cardName]
@onready var cardInfo = cardDataBase.DATA[cardIndex]
@onready var cardImage = str("res://Card//Resource/" + cardName + ".png")
@onready var descPanel = preload("res://DescPanel.tscn").instantiate()


var normal_icon_modulate = Color(1, 1, 1, 1)
var hover_icon_modulate = Color(0.8, 0.8, 0.8, 1)

func _ready():
	add_child(descPanel)
	set_button_icon(load(cardImage))
	set_size(Vector2(90, 163))
	mouse_entered.connect(mouse_i)
	mouse_exited.connect(mouse_o)


func mouse_i():
	descPanel.get_child(0).set_text(cardDataBase.CardList[cardIndex])
	modulate = Color(0.8, 0.8, 0.8, 1)
	showDescription()
func mouse_o():
	descPanel.get_child(0).set_text("")
	modulate = Color(1, 1, 1, 1)
	exitDescription()
	
	
func showDescription():
	descPanel.visible = true
	descPanel.position = Vector2(100, 50)
	descPanel.set_rotation(-get_rotation())


func exitDescription():
	descPanel.visible = false
