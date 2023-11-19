#========================================
# 최초 작성자: 송찬영
# 최초 작성일: 2023.11.05
# 목적: 맵의 각 레벨을 처리하는 스크립트
#========================================
extends Control
class_name MapLevel

@export var level:int
@export var nextLevel:MapLevel

@onready var map1 = $MapNodeContainer/MapNode
@onready var map2 = $MapNodeContainer/MapNode2
@onready var map3 = $MapNodeContainer/MapNode3
@onready var map4 = $MapNodeContainer/MapNode4
@onready var map5 = $MapNodeContainer/MapNode5
@onready var map6 = $MapNodeContainer/MapNode6
@onready var map7 = $MapNodeContainer/MapNode7

@onready var mapNodeList = [map1, map2, map3, map4, map5, map6, map7]


func _ready():
	MakeMapNode()


#========================================
# 목적: 이 레벨의 맵 노드들을 만드는 메소드
# 매개변수: 없음
# 반환값: 없음
#========================================
func MakeMapNode():
	pass
	# 1은 일반적 4개, 14는 휴식방, 15는 보스방 하나
	match level:
		1:
			map1.get_child(0).get_child(0).text = "일반 적"
			map3.get_child(0).get_child(0).text = "일반 적"
			map5.get_child(0).get_child(0).text = "일반 적"
			map7.get_child(0).get_child(0).text = "일반 적"
		14:
			map1.get_child(0).get_child(0).text = "휴식"
			map2.get_child(0).get_child(0).text = "휴식"
			map3.get_child(0).get_child(0).text = "휴식"
			map4.get_child(0).get_child(0).text = "휴식"
			map5.get_child(0).get_child(0).text = "휴식"
			map6.get_child(0).get_child(0).text = "휴식"
			map7.get_child(0).get_child(0).text = "휴식"
		15:
			map4.get_child(0).get_child(0).text = "보스"
		_:
			for node in mapNodeList:
				var factor = randi_range(1, 100)
				
				if 1 <= factor and factor <= 7: # 휴식
					node.get_child(0).get_child(0).text = "휴식"
				elif 7 < factor and factor <= 27: # 이벤트
					node.get_child(0).get_child(0).text = "이벤트 방"
				elif 27 < factor and factor <= 32: # 엘리트 적
					node.get_child(0).get_child(0).text = "엘리트 적"
				elif 32 < factor and factor <= 35: # 상점
					node.get_child(0).get_child(0).text = "상점"
				elif 35 < factor and factor <= 100: # 일반 적
					node.get_child(0).get_child(0).text = "일반 적"
