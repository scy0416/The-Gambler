#========================================
# 최초 작성자: 송찬영
# 최초 작성일: 2023.11.05
# 목적: 운명을 선택하는 판낼을 위한 스크립트
#========================================
extends Panel

# 운명 선택을 취소한다는 신호
signal character_select_cancel
# 운명을 선택했다는 신호
signal character_selected(dest)


#========================================
# 목적: 운면 선택을 취소하는 메소드
# 매개변수: 없음
# 반환값: 없음
#========================================
func cancel():
	emit_signal("character_select_cancel")


func characterSelect(value):
	emit_signal("character_selected", value)
