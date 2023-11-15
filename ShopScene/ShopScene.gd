extends Node

var gameData = GameData.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	$Gold.text = str(gameData.getGold())
	

func buyRelic():
	pass	

