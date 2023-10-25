extends Node


@onready var slot1 = $UI/MC/SaveSlotContainer/SaveSlot
@onready var slot2 = $UI/MC/SaveSlotContainer/SaveSlot2
@onready var slot3 = $UI/MC/SaveSlotContainer/SaveSlot3


func _ready():
	slot1.checkData()
	slot2.checkData()
	slot3.checkData()


func continueGame():
	GameManager.loadData(GameManager.saveNum)
	get_tree().change_scene_to_file("res://GameManagerTestingFolder/Ingame.tscn")


func deleteData():
	GameManager.deleteGameData(GameManager.saveNum)
	for saveSlot in $UI/MC/SaveSlotContainer.get_children():
		saveSlot.checkData()


func newGame():
	$UI/MC.visible = false
	$UI/DestinySelect.visible = true


func newGameStart(dest:GameData.Destiny):
	GameManager.makeNewGameData(GameManager.saveNum, dest)
	for saveSlot in $UI/MC/SaveSlotContainer.get_children():
		saveSlot.checkData()
	$UI/MC.visible = true
	$UI/DestinySelect.visible = false
	
	GameManager.loadData(GameManager.saveNum)
	get_tree().change_scene_to_file("res://GameManagerTestingFolder/Ingame.tscn")


func newGameCancel():
	$UI/MC.visible = true
	$UI/DestinySelect.visible = false
