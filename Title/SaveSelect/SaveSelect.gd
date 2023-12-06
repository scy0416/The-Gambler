extends Node

@onready var slot1 = $UI/MarginContainer/ContentContainer/SaveSlotContainer/SaveSlot1
@onready var slot2 = $UI/MarginContainer/ContentContainer/SaveSlotContainer/SaveSlot2
@onready var slot3 = $UI/MarginContainer/ContentContainer/SaveSlotContainer/SaveSlot3
@onready var saveContainer = $UI/MarginContainer
@onready var saveSlotcontainer = $UI/MarginContainer/ContentContainer
@onready var characterSelect = $UI/MarginContainer/CharacterSelect
@onready var deleteCheckContainer = $UI/DeleteCheck

func _ready():
	checkSlots()

func continueGame(saveNum):
	GameManager.loadData(GameManager.saveNum)
	get_tree().change_scene_to_packed(GameManager.gameData.savedScene)

func deleteCheck(saveNum):
	saveContainer.visible = false
	deleteCheckContainer.visible = true

func deleteApply():
	GameManager.deleteGameData(GameManager.saveNum)
	saveContainer.visible = true
	deleteCheckContainer.visible = false
	checkSlots()

func deleteDeny():
	saveContainer.visible = true
	deleteCheckContainer.visible = false

func newGame(saveNum):
	saveSlotcontainer.visible = false
	characterSelect.visible = true

func newGameStart(character):
	GameManager.makeNewGameData(GameManager.saveNum, character)
	
	GameManager.loadData(GameManager.saveNum)
	#get_tree().change_scene_to_file("res://Stage/Stage.tscn")
	get_tree().change_scene_to_file("res://StageTmp/Stage.tscn")

func newGameCancel():
	saveSlotcontainer.visible = true
	characterSelect.visible = false

func checkSlots():
	slot1.checkData()
	slot2.checkData()
	slot3.checkData()

func goTitle():
	get_tree().change_scene_to_file("res://Title/Title.tscn")
