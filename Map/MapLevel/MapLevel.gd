extends Control
class_name MapLeve

signal card_selected(type, num)

@export var level:int
@export var nextLevel:MapLevel

@onready var map1 = $HBoxContainer/NodeCard1
@onready var map2 = $HBoxContainer/NodeCard2
@onready var map3 = $HBoxContainer/NodeCard3
@onready var map4 = $HBoxContainer/NodeCard4
@onready var map5 = $HBoxContainer/NodeCard5
@onready var map6 = $HBoxContainer/NodeCard6
@onready var map7 = $HBoxContainer/NodeCard7

@onready var mapNodeList = [map1, map2, map3, map4, map5, map6, map7]

func saveState():
	for i in range(1, 1+7):
		GameManager.gameData.savedSceneState["node%d-%d-is_front"%[level, i+1]] = mapNodeList[i-1].is_front
		GameManager.gameData.savedSceneState["node%d-%d-is_activated"%[level, i+1]] = mapNodeList[i-1].is_activated
		GameManager.gameData.savedSceneState["node%d-%d-is_interact_activated"%[level, i+1]] = mapNodeList[i-1].is_interact_activated
		GameManager.gameData.savedSceneState["node%d-%d-type"%[level, i+1]] = mapNodeList[i-1].type

func _ready():
	deactivate_level()

# 맵 생성하는 메소드
func MakeMapNode():
	match level:
		1:
			map1.type = "일반 적"
			map3.type = "일반 적"
			map5.type = "일반 적"
			map7.type = "일반 적"
		14:
			for map in mapNodeList:
				map.type = "휴식"
		15:
			for map in mapNodeList:
				map.type = "보스 전투"
		_:
			for map in mapNodeList:
				var factor = randi_range(1, 100)
				
				if 1 <= factor and factor <= 7: # 휴식
					map.type = "휴식"
				elif 7 < factor and factor <= 27: # 이벤트
					map.type = "이벤트"
				elif 27 < factor and factor <= 32: # 엘리트 적
					map.type = "엘리트 적"
				elif 32 < factor and factor <= 35: # 상점
					map.type = "상점"
				elif 35 < factor and factor <= 100: # 일반 적
					map.type = "일반 적"

# 1번 카드 선택
func card_select1(type):
	if nextLevel and nextLevel.level != 15:
		nextLevel.map1.flip()
		nextLevel.map2.flip()
		nextLevel.map7.flip()
	if nextLevel:
		deactivate_level()
		nextLevel.activate_level()
	if level != 15:
		close_other_cards(1)
	emit_signal("card_selected", type, 1)

# 2번 카드 선택
func card_select2(type):
	if nextLevel and nextLevel.level != 15:
		nextLevel.map1.flip()
		nextLevel.map2.flip()
		nextLevel.map3.flip()
	if nextLevel:
		deactivate_level()
		nextLevel.activate_level()
	if level != 15:
		close_other_cards(2)
	emit_signal("card_selected", type, 2)

# 3번 카드 선택
func card_select3(type):
	if nextLevel and nextLevel.level != 15:
		nextLevel.map2.flip()
		nextLevel.map3.flip()
		nextLevel.map4.flip()
	if nextLevel:
		deactivate_level()
		nextLevel.activate_level()
	if level != 15:
		close_other_cards(3)
	emit_signal("card_selected", type, 3)

# 4번 카드 선택
func card_select4(type):
	if nextLevel and nextLevel.level != 15:
		nextLevel.map3.flip()
		nextLevel.map4.flip()
		nextLevel.map5.flip()
	if nextLevel:
		deactivate_level()
	if level != 15:
		close_other_cards(4)
	emit_signal("card_selected", type, 4)

# 5번 카드 선택
func card_select5(type):
	if nextLevel and nextLevel.level != 15:
		nextLevel.map4.flip()
		nextLevel.map5.flip()
		nextLevel.map6.flip()
	if nextLevel:
		deactivate_level()
	if level != 15:
		close_other_cards(5)
	emit_signal("card_selected", type, 5)

# 6번 카드 선택
func card_select6(type):
	if nextLevel and nextLevel.level != 15:
		nextLevel.map5.flip()
		nextLevel.map6.flip()
		nextLevel.map7.flip()
	if nextLevel:
		deactivate_level()
	if level != 15:
		close_other_cards(6)
	emit_signal("card_selected", type, 6)

# 7번 카드 선택
func card_select7(type):
	if nextLevel and nextLevel.level != 15:
		nextLevel.map1.flip()
		nextLevel.map6.flip()
		nextLevel.map7.flip()
	if nextLevel:
		deactivate_level()
	if level != 15:
		close_other_cards(7)
	emit_signal("card_selected", type, 7)

func close_other_cards(num):
	for i in range(1, 1 + 7):
		if i == num:
			continue
		if mapNodeList[i-1].is_front:
			mapNodeList[i-1].close()

func activate_level():
	for map in mapNodeList:
		map.activate_node()

func deactivate_level():
	for map in mapNodeList:
		map.deactivate_node()

func activate_interact():
	for map in mapNodeList:
		map.activate_interact()

func deactivate_interact():
	for map in mapNodeList:
		map.deactivate_interact()

func update():
	var map_activate = GameManager.gameData.savedSceneState["map_activate"]
	if map_activate:
		activate_level()
	else:
		deactivate_level()
	for i in range(1, 1+7):
		var is_front = GameManager.gameData.savedSceneState["node%d-%d-is_front"%[level, i+1]]
		var is_activated = GameManager.gameData.savedSceneState["node%d-%d-is_activated"%[level, i+1]]
		var is_interact_activated = GameManager.gameData.savedSceneState["node%d-%d-is_interact_activated"%[level, i+1]]
		var type = GameManager.gameData.savedSceneState["node%d-%d-type"%[level, i+1]]
		mapNodeList[i-1].is_front = is_front
		if is_front:
			mapNodeList[i-1].set_front()
		else:
			mapNodeList[i-1].set_back()
		mapNodeList[i-1].is_activated = is_activated
		if is_activated:
			mapNodeList[i-1].activate_node()
		else:
			mapNodeList[i-1].deactivate_node()
		mapNodeList[i-1].is_interact_activated = is_interact_activated
		if is_interact_activated:
			mapNodeList[i-1].activate_interact()
		else:
			mapNodeList[i-1].deactivate_interact()
		mapNodeList[i-1].type = type
