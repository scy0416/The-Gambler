#========================================
# 최초 작성자: 송찬영
# 최초 작성일: 2023.11.05
# 목적: 세이브 슬롯 화면 처리용 스크립트
#========================================
extends Node

@onready var slot1 = $UI/MC/ContentContainer/SaveSlotContainer/SaveSlot
@onready var slot2 = $UI/MC/ContentContainer/SaveSlotContainer/SaveSlot2
@onready var slot3 = $UI/MC/ContentContainer/SaveSlotContainer/SaveSlot3
@onready var saveSelectContainer = $UI/MC
@onready var characterSelectContainer = $UI/CharacterSelect


#========================================
# 목적: 모든 세이브 슬롯의 데이터 유무를 확인
# 매개변수: 없음
# 반환값: 없음
#========================================
func _ready():
	checkSlots()


#========================================
# 목적: 존재하는 게임을 계속하는 메소드
# 매개변수: 없음
# 반환값: 없음
#========================================
func continueGame():
	GameManager.loadData(GameManager.saveNum)
	get_tree().change_scene_to_packed(GameManager.gameData.savedScene)
	#get_tree().change_scene_to_file("res://Stage/Stage.tscn")


#========================================
# 목적: 존재하는 데이터를 삭제하는 메소드
# 매개변수: 없음
# 반환값: 없음
#========================================
func deleteData():
	GameManager.deleteGameData(GameManager.saveNum)
	checkSlots()


#========================================
# 목적: 새로운 게임을 선택하는 메소드
# 매개변수: 없음
# 반환값: 없음
#========================================
func newGame():
	saveSelectContainer.visible = false
	characterSelectContainer.visible = true


#========================================
# 목적: 새로운 게임을 실제로 시작하게 되는 메소드
# 매개변수: dest:GameData.Destiny
# 반환값: 없음
#========================================
func newGameStart(character:GameData.Character):
	GameManager.makeNewGameData(GameManager.saveNum, character)
	#checkSlots()
	
	GameManager.loadData(GameManager.saveNum)
	#get_tree().change_scene_to_file("res://GameManagerTestingFolder/Ingame.tscn")
	get_tree().change_scene_to_file("res://Stage/Stage.tscn")
	
	#saveSelectContainer.visible = true
	#destinySelectContainer.visible = false
	
	#checkSlots()


#========================================
# 목적: 새로운 게임 시작을 취소하는 메소드
# 매개변수: 없음
# 반환값: 없음
#========================================
func newGameCancel():
	saveSelectContainer.visible = true
	characterSelectContainer.visible = false


#========================================
# 목적: 타이틀로 돌아가는 메소드
# 매개변수: 없음
# 반환값: 없음
#========================================
func goTitle():
	get_tree().change_scene_to_file("res://Title/Title.tscn")


#========================================
# 목적: 슬롯의 데이터를 체크하는 메소드
# 매개변수: 없음
# 반환값: 없음
#========================================
func checkSlots():
	slot1.checkData()
	slot2.checkData()
	slot3.checkData()
