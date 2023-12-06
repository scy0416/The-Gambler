extends Control

@onready var relicSlot1 = $RelicPanel/HBoxContainer/Relic1
@onready var relicSlot2 = $RelicPanel/HBoxContainer/Relic2
@onready var relicSlot3 = $RelicPanel/HBoxContainer/Relic3
@onready var relicSlot4 = $RelicPanel/HBoxContainer/Relic4
@onready var relicSlot5 = $RelicPanel/HBoxContainer/Relic5
@onready var relicSlot6 = $RelicPanel/HBoxContainer/Relic6

@onready var relicSlotList = [relicSlot1, relicSlot2, relicSlot3, relicSlot4,
relicSlot5, relicSlot6]

func update():
	var relic_num = GameManager.gameData.relics.size()
	for i in range(relic_num):
		pass
		#relicSlotList[i].set(GameManager.gameData.relics[i])
