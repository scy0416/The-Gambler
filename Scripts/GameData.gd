#========================================
# 최초 작성자: 송찬영
# 최초 작성일: 2023.10.10
# 목적: 게임 매니저에서 관리할 게임의 전체적인 데이터
#========================================
extends Resource
class_name GameData

# 데이터의 변화를 알리는 신호
signal data_changed

# 운명 열거형(죽음/행운/헌신/부)
enum Destiny {DEATH, LUCK, DEVOTION, WEALTH}
# 세이브 파일 번호
#@export var saveNum:int
# 생명
@export var life:int = 100
# 돈
@export var gold:int = 100
# 운명
@export var destiny:Destiny
# 유물
@export var relics:Array
# 아이템
@export var items:Array

'''
func _init(dest:Destiny):
	life = 100
	gold = 100
	destiny = dest
'''

#========================================
# 목적: life의 값을 초기화하는 메소드
# 매개변수: value: life를 초기화 하고자 하는 값
# 반환값: 없음
#========================================
func setLife(value:int):
	life = value
	emit_signal("data_changed")


#========================================
# 목적: life의 값 반환하는 메소드
# 매개변수: 없음
# 반환값: int
#========================================
func getLife()->int:
	return life


#========================================
# 목적: gold의 값을 초기화하는 메소드
# 매개변수: value: gold를 초기화 하고자 하는 값
# 반환값: 없음
#========================================
func setGold(value:int):
	gold = value
	emit_signal("data_changed")


#========================================
# 목적: gold의 값 반환하는 메소드
# 매개변수: 없음
# 반환값: int
#========================================
func getGold()->int:
	return gold


#========================================
# 목적: destiny의 값을 초기화하는 메소드
# 매개변수: value: destiny를 초기화 하고자 하는 값
# 반환값: 없음
#========================================
func setDestiny(value:Destiny):
	destiny = value
	emit_signal("data_changed")


#========================================
# 목적: destiny의 값 반환하는 메소드
# 매개변수: 없음
# 반환값: Destiny
#========================================
func getDestiny()->Destiny:
	return destiny


#========================================
# 목적: 유물을 추가하는 메소드
# 매개변수: relic: 추가하고자 하는 유물
# 반환값: 없음
#========================================
func appendRelic(relic:Relic):
	relics.append(relic)
	emit_signal("data_changed")


#========================================
# 목적: 유물을 삭제하는 메소드
# 매개변수: target: 삭제하고자 하는 유물
# 반환값: 없음
#========================================
func deleteRelic(target:Relic):
	if target in relics:
		printerr("없는 유물을 삭제하려고 하는 중")
		return
	relics.erase(target)
	emit_signal("data_changed")


#========================================
# 목적: 유물을 반환하는 메소드
# 매개변수: 없음
# 반환값: Array
#========================================
func getRelics()->Array:
	return relics


#========================================
# 목적: 아이템을 추가하는 메소드
# 매개변수: relic: 추가하고자 하는 유물
# 반환값: 없음
#========================================
func appendItem(item:Relic):
	items.append(item)
	emit_signal("data_changed")


#========================================
# 목적: 아이템을 삭제하는 메소드
# 매개변수: target: 삭제하고자 하는 유물
# 반환값: 없음
#========================================
func deleteItem(target:Item):
	if target in items:
		printerr("없는 아이템을 삭제하려고 하는 중")
		return
	items.erase(target)
	emit_signal("data_changed")


#========================================
# 목적: 아이템을 반환하는 메소드
# 매개변수: 없음
# 반환값: Array
#========================================
func getItems()->Array:
	return items
