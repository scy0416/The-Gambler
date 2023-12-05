extends Panel

# 계속하기 신호
signal continueClicked(saveNum)
# 삭제하기 신호
signal deleteClicked(saveNum)
# 새로하기 신호
signal newGameClicked(saveNum)

# 저장슬롯 번호
@export var saveNum:int

# 저장 데이터 번호 텍스트 설정
func _ready():
	$SaveDataExist/SaveNum.text = '데이터%d' % saveNum

func checkData():
	if GameManager.isDataExist(saveNum):
		setSaveSlot()
	else:
		setEmptySlot()

# 저장 데이터가 있는 경우
func setSaveSlot():
	$SaveDataExist/Character.text = "캐릭터:"
	$SaveDataExist.visible = true
	$SaveDataNonexist.visible = false

# 저장 데이터가 없는 경우
func setEmptySlot():
	$SaveDataExist.visible = false
	$SaveDataNonexist.visible = true

# 게임 계속하기
func continueGame():
	GameManager.saveNum = saveNum
	emit_signal("continueClicked", saveNum)

# 저장 파일 삭제하기
func deleteGame():
	GameManager.saveNum = saveNum
	emit_signal("deleteClicked", saveNum)

# 새 게임 시작하기
func newGame():
	GameManager.saveNum = saveNum
	emit_signal("newGameClicked", saveNum)
