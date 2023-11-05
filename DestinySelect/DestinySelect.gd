#========================================
# 최초 작성자: 송찬영
# 최초 작성일: 2023.11.05
# 목적: 운명을 선택하는 판낼을 위한 스크립트
#========================================
extends Panel

# 운명 선택을 취소한다는 신호
signal destiny_select_cancel
# 운명을 선택했다는 신호
signal destiny_selected(dest)


#========================================
# 목적: 운면 선택을 취소하는 메소드
# 매개변수: 없음
# 반환값: 없음
#========================================
func cancel():
	emit_signal("destiny_select_cancel")


#========================================
# 목적: 죽음 운명 선택
# 매개변수: 없음
# 반환값: 없음
#========================================
func deathSelect():
	emit_signal("destiny_selected", GameData.Destiny.DEATH)


#========================================
# 목적: 행운 운명을 선택
# 매개변수: 없음
# 반환값: 없음
#========================================
func luckSelect():
	emit_signal("destiny_selected", GameData.Destiny.LUCK)


#========================================
# 목적: 헌신 운명을 선택
# 매개변수: 없음
# 반환값: 없음
#========================================
func devotionSelect():
	emit_signal("destiny_selected", GameData.Destiny.DEVOTION)


#========================================
# 목적: 부 운명 선택
# 매개변수: 없음
# 반환값: 없음
#========================================
func wealthSelect():
	emit_signal("destiny_selected", GameData.Destiny.WEALTH)
