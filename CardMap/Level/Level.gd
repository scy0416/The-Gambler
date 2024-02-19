extends Control
class_name MapLevel

signal card_selected(type, num)

@export var level:int
@export var nextLevel:MapLevel

@onready var map1 = $HBoxContainer/Card1
@onready var map2 = $HBoxContainer/Card2
@onready var map3 = $HBoxContainer/Card3
@onready var map4 = $HBoxContainer/Card4
@onready var map5 = $HBoxContainer/Card5
@onready var map6 = $HBoxContainer/Card6
@onready var map7 = $HBoxContainer/Card7

@onready var mapNodeList = [map1, map2, map3, map4, map5, map6, map7]

var mapResource = GameManager.gameData.map_resource

var isActivatable:bool

var map


func saveState():
	for i in range(0, 7):
		#mapResource.states[str(level) + str(i)] = mapNodeList[i].current_state
		#mapResource.types[str(level) + str(i)] = mapNodeList[i].type
		GameManager.gameData.map_resource.states[str(level) + str(i)] = mapNodeList[i].current_state
		GameManager.gameData.map_resource.types[str(level) + str(i)] = mapNodeList[i].type


func MakeMapNode():
	match level:
		1:
			map1.type = "일반 적"
			map1.current_state = map1.state.WAIT
			map3.type = "일반 적"
			map3.current_state = map3.state.WAIT
			map5.type = "일반 적"
			map5.current_state = map5.state.WAIT
			map7.type = "일반 적"
			map7.current_state = map7.state.WAIT
		14:
			for map in mapNodeList:
				map.type = "휴식"
				map.current_state = map.state.OPENED
		15:
			for map in mapNodeList:
				map.type = "보스 전투"
				map.current_state = map.state.OPENED
		_:
			for map in mapNodeList:
				var factor = randi_range(1, 100)
				
				if 1 <= factor and factor <= 7: # 휴식
					map.type = "휴식"
					map.current_state = map.state.OPENED
				elif 7 < factor and factor <= 27: # 이벤트
					map.type = "이벤트"
					map.current_state = map.state.CLOSE
				elif 27 < factor and factor <= 32: # 엘리트 적
					map.type = "엘리트 적"
					map.current_state = map.state.CLOSE
				elif 32 < factor and factor <= 35: # 상점
					map.type = "상점"
					map.current_state = map.state.CLOSE
				elif 35 < factor and factor <= 100: # 일반 적
					map.type = "일반 적"
					map.current_state = map.state.CLOSE
	deactivate_interact()


"""func card_select7(type):
	if nextLevel and nextLevel.level != 15:
		nextLevel.map1.flip()
		nextLevel.map6.flip()
		nextLevel.map7.flip()
	if nextLevel:
		deactivate_level()
	if level != 15:
		close_other_cards(7)
	emit_signal("card_selected", type, 7)"""


# 선택에 대한 처리를 하는 함수
func card_select(type, num):
	var next1 = (num - 1 + 7) % 7
	var next2 = num
	var next3 = (num + 1 + 7) % 7
	if nextLevel and nextLevel.level != 15:
		map.deactivate_interact()
		#var next1 = (num - 1 + 7) % 7
		#var next2 = num
		#var next3 = (num + 1 + 7) % 7
		if nextLevel.mapNodeList[next1].current_state != nextLevel.mapNodeList[next1].state.OPENED:
			nextLevel.mapNodeList[next1].flip()
		nextLevel.mapNodeList[next1].current_state = nextLevel.mapNodeList[next1].state.WAIT
		if nextLevel.mapNodeList[next2].current_state != nextLevel.mapNodeList[next2].state.OPENED:
			nextLevel.mapNodeList[next2].flip()
		nextLevel.mapNodeList[next2].current_state = nextLevel.mapNodeList[next2].state.WAIT
		if nextLevel.mapNodeList[next3].current_state != nextLevel.mapNodeList[next3].state.OPENED:
			nextLevel.mapNodeList[next3].flip()
		nextLevel.mapNodeList[next3].current_state = nextLevel.mapNodeList[next3].state.WAIT
	if level != 15:
		close_other_card(num)
	#deactivate_interact()
	#if nextLevel:
		#nextLevel.activate_interact()
		#for i in range(0, 7):
			#if i == next1 or i == next2 or i == next3:
				#continue
			#nextLevel.mapNodeList[i].deactivate_interact()
	await get_tree().create_timer(.5).timeout
	print("맵 선택 완료")
	#GameManager.startStage(mapNodeList[num].type)
	#emit_signal("card_selected", mapNodeList[num].type, num)


# 같은 레벨의 다른 카드들을 닫는 함수
func close_other_card(num):
	for i in range(0, 7):
		if i == num:
			continue
		if mapNodeList[i].current_state == mapNodeList[i].state.CLOSE:
			continue
		mapNodeList[i].current_state = mapNodeList[i].state.CLOSE
		mapNodeList[i].close()


func activate_interact():
	isActivatable = true
	for map in mapNodeList:
		if map.current_state == map.state.WAIT:
			map.activate_interact()


func deactivate_interact():
	isActivatable = false
	for map in mapNodeList:
		map.deactivate_interact()


func update():
	for i in range(0, 7):
		mapNodeList[i].type = mapResource.types[str(level) + str(i)]
		mapNodeList[i].current_state = mapResource.states[str(level) + str(i)]
