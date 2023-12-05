extends Node

# 나가기 확인 체크 판넬
@onready var quitCheck = $UI/QuitCheck

# 게임을시작하는 버튼에 대한 처리
func StartGame():
	get_tree().change_scene_to_file("res://tmp/SaveSelect/SaveSelect.tscn")

# 옵션창 열기
func OpenOption():
	$UI/OptionContainer.visible = true

# 나가기 버튼 처리
func QuitButton():
	quitCheck.visible = true

# 게임 나가기
func QuitGame():
	get_tree().quit()

# 게임 나가기 취소
func QuitCancel():
	quitCheck.visible = false

func CloseOption():
	$UI/OptionContainer.visible = false
