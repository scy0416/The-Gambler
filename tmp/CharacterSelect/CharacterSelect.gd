extends Control

# 캐릭터 선택 취소 신호
signal character_select_cancel
# 캐릭터 선택했다는 신호
signal character_selected(character)

# 캐릭터 번호
@export var characterNum:int

func cancel():
	emit_signal("character_select_cancel")

func characterSelect():
	emit_signal("character_selected", characterNum)
