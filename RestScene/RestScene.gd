extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	var button = $recoverHP
	var button2 = $MaxHPUp
	button.pressed.connect(self.recoverHP)
	button2.pressed.connect(self.upMaxHP)
	$HPbar.value = GameManager.player_hp
	$HPbar/HPLabel.text = "HP: " + str(GameManager.player_hp) + "/" + str(GameManager.player_maxHP)
	
#HP 회복
func recoverHP():
	GameManager.player_hp += 30
	if(GameManager.player_hp >= GameManager.player_maxHP):
		GameManager.player_hp = GameManager.player_maxHP
	$HPbar.value = GameManager.player_hp
	$HPbar/HPLabel.text = "HP: " + str(GameManager.player_hp) + "/" + str(GameManager.player_maxHP)
	
#최대 HP 증가
func upMaxHP():
	GameManager.player_maxHP += 10
	$HPbar.max_value += 10
	$HPbar/HPLabel.text = "HP: " + str(GameManager.player_hp) + "/" + str(GameManager.player_maxHP)
