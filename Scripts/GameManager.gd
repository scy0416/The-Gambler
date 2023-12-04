#========================================
# 최초 작성자: 송찬영
# 최초 작성일: 2023.10.10
# 최종 변경일: 2023.11.08
# 목적: 게임의 데이터를 저장, 관리하는 게임 매니저
# 개정 이력: 송찬영, 2023.10.11, 환경 설정 데이터까지 로드할 수 있게 변경
# 데이터 삭제 기능 추가, 데이터 생성 기능 추가
# 송찬영, 2023.11.08, 환경 설정 리소스 생성시 값을 초기화 하는 부분을 삭제
# 환경 설정 파일 저장하는 메소드 추가
#========================================
extends Node

# 데이터가 저장될 주소
const SAVE_PATH = "user://"

# 현재 세이브 데이터 번호
var saveNum:int = -1
# 게임 데이터
var gameData:Resource
# 환경 설정 데이터
var gameConfigData:Resource


#========================================
# 목적: 게임이 시작됨과 동시에 게임 매니저가 로드되는 순간 환경 설정 파일을 로드
# 매개변수: 없음
# 반환값: 없음
#========================================
func _init():
	loadConfigData()


#========================================
# 목적: 특정 데이터 파일이 존재하는지 확인하는 메소드
# 매개변수: targetSaveNum: 확인하고자 하는 저장 파일의 숫자
# 반환값: bool
#========================================
func isDataExist(targetSaveNum:int)->bool:
	var dirCheck = DirAccess.open(SAVE_PATH)
	if dirCheck.file_exists("save" + str(targetSaveNum) + ".tres"):
		return true
	else:
		return false


#========================================
# 목적: 특정 데이터 파일을 로드하는 메소드
# 매개변수: targetSaveNum: 로드하고자 하는 데이터 파일의 번호
# 반환값: bool
#========================================
func loadData(targetSaveNum:int)->bool:
	if isDataExist(targetSaveNum):
		gameData = ResourceLoader.load(SAVE_PATH + "save" + str(targetSaveNum) + ".tres")
		saveNum = targetSaveNum
		return true
	else:
		saveNum = -1
		return false


#========================================
# 목적: 특정 데이터 파일을 저장하는 메소드
# 매개변수: 없다
# 반환값: bool
#========================================
func saveData():
	if ResourceSaver.save(gameData, SAVE_PATH + "save" + str(saveNum) + ".tres", ResourceSaver.FLAG_CHANGE_PATH) == OK:
		return true
	else:
		return false


#========================================
# 목적: 환경설정 파일이 존재하는지 확인하는 메소드
# 매개변수: 없음
# 반환값: bool
#========================================
func isConfigDataExist()->bool:
	var dirCheck = DirAccess.open(SAVE_PATH)
	if dirCheck.file_exists("GameConfigData.tres"):
		return true
	else:
		return false


#========================================
# 목적: 환경 설정 파일을 로드해내는 메소드
# 매개변수: 없음
# 반환값: 없음
#========================================
func loadConfigData():
	if isConfigDataExist():
		gameConfigData = ResourceLoader.load(SAVE_PATH + "GameConfigData.tres")
	else:
		gameConfigData = GameConfigData.new()
		saveConfigData()


#========================================
# 목적: 새로운 게임 파일을 만드는 메소드
# 매개변수: targetSaveNum: 목표 데이터 숫자, dest: 설정할 운명
# 반환값: GameData
#========================================
func makeNewGameData(targetSaveNum:int, character:GameData.Character):
	saveNum = targetSaveNum
	#gameData = GameData.new(dest)
	gameData = GameData.new()
	gameData.setCharacter(character)
	saveData()


#========================================
# 목적: 데이터를 삭제하는 메소드
# 매개변수: targetSaveNum: 목표 데이터 숫자
# 반환값: 없음
#========================================
func deleteGameData(targetSaveNum):
	var dirCheck = DirAccess.open(SAVE_PATH)
	if dirCheck.file_exists("save" + str(targetSaveNum) + ".tres"):
		dirCheck.remove("save" + str(targetSaveNum) + ".tres")


#========================================
# 목적: 환경 설정 파일을 저장하는 메소드
# 매개변수: 없음
# 반환값: 없음
#========================================
func saveConfigData():
	ResourceSaver.save(gameConfigData, SAVE_PATH + "GameConfigData.tres")
