extends Panel

signal continueClicked
signal deleteClicked
signal newGameClicked

@export var saveNum:int


func checkData():
	if GameManager.isDataExist(saveNum):
		setSaveSlot()
	else:
		setEmptySlot()


func setSaveSlot():
	$SaveDataExist.visible = true
	$SaveDataNonexist.visible = false


func setEmptySlot():
	$SaveDataExist.visible = false
	$SaveDataNonexist.visible = true


func continueGame():
	GameManager.saveNum = saveNum
	emit_signal("continueClicked")


func deleteGame():
	GameManager.saveNum = saveNum
	emit_signal("deleteClicked")


func newGame():
	GameManager.saveNum = saveNum
	emit_signal("newGameClicked")
