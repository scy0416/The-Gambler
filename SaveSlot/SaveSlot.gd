#========================================
# 최초 작성자: 송찬영
# 최초 작성일: 2023.11.03
# 목적: 저장 슬롯
#========================================
extends Panel

# 계속하기 신호
signal continueClicked
# 삭제하기 신호
signal deleteClicked
# 새로하기 신호
signal newGameClicked

# 저장 슬롯 번호
@export var saveNum:int


#========================================
# 목적: 게임의 데이터가 존재하는지 확인하는 함수
# 매개변수: 없음
# 반환값: 없음
#========================================
func checkData():
	if GameManager.isDataExist(saveNum):
		setSaveSlot()
	else:
		setEmptySlot()


#========================================
# 목적: 존재하는 저장 데이터 보이게 설정
# 매개변수: 없음
# 반환값: 없음
#========================================
func setSaveSlot():
	$SaveDataExist.visible = true
	$SaveDataNonexist.visible = false


#========================================
# 목적: 게임 새로하기 패널 활성화
# 매개변수: 없음
# 반환값: 없음
#========================================
func setEmptySlot():
	$SaveDataExist.visible = false
	$SaveDataNonexist.visible = true


#========================================
# 목적: 게임 계속하기 신호 보내는 함수
# 매개변수: 없음
# 반환값: 없음
#========================================
func continueGame():
	GameManager.saveNum = saveNum
	emit_signal("continueClicked")


#========================================
# 목적: 게임 삭제하기 신호 보내는 함수
# 매개변수: 없음
# 반환값: 없음
#========================================
func deleteGame():
	GameManager.saveNum = saveNum
	emit_signal("deleteClicked")


#========================================
# 목적: 게임 새로하기 신호 보내는 함수
# 매개변수: 없음
# 반환값: 없음
#========================================
func newGame():
	GameManager.saveNum = saveNum
	emit_signal("newGameClicked")
