extends Node

var gameData = GameData.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	var button = $recoverHP
	var button2 = $MaxHPUp
	button.pressed.connect(self.recoverHP)
	button2.pressed.connect(self.upMaxHP)
	$HPbar.value = gameData.getLife()
	$HPbar/HPLabel.text = "HP: " + str(gameData.getLife()) + "/" + str(gameData.getMaxLife())
	
#HP 회복
func recoverHP():
	gameData.setLife(gameData.getLife() + 30)
	if(gameData.getLife() >= gameData.getMaxLife()):
		gameData.setLife(gameData.getMaxLife())
	$HPbar.value = gameData.getLife()
	$HPbar/HPLabel.text = "HP: " + str(gameData.getLife()) + "/" + str(gameData.getMaxLife())
	
#최대 HP 증가
func upMaxHP():
	gameData.setMaxLife(gameData.getMaxLife() + 10)
	$HPbar.max_value += 10
	$HPbar/HPLabel.text = "HP: " + str(gameData.getLife()) + "/" + str(gameData.getMaxLife())
