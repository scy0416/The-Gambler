extends Control

@onready var potionSlot1 = $PotionPanel/HBoxContainer/Potion1
@onready var potionSlot2 = $PotionPanel/HBoxContainer/Potion2
@onready var potionSlot3 = $PotionPanel/HBoxContainer/Potion3

@onready var potionSlotList = [potionSlot1, potionSlot2, potionSlot3]

func update():
	var potion_num = GameManager.gameData.items.size()
	for i in range(potion_num):
		pass
		#potionSlotList[i].set(GameManager.gameData.items[i])
