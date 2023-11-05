#========================================
# 최초 작성자: 송찬영
# 최초 작성일: 2023.11.05
# 목적: 맵의 각 레벨을 처리하는 스크립트
#========================================
extends Panel
class_name MapLevel

@export var level:int
@export var nextLevel:MapLevel

@onready var map1 = $MapNode/Map1
@onready var map2 = $MapNode/Map2
@onready var map3 = $MapNode/Map3
@onready var map4 = $MapNode/Map4
@onready var map5 = $MapNode/Map5
@onready var map6 = $MapNode/Map6
@onready var map7 = $MapNode/Map7


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
			map1.get_child(0).text = "일반 적"
			map3.get_child(0).text = "일반 적"
			map5.get_child(0).text = "일반 적"
			map7.get_child(0).text = "일반 적"
		14:
			map1.get_child(0).text = "휴식"
			map2.get_child(0).text = "휴식"
			map3.get_child(0).text = "휴식"
			map4.get_child(0).text = "휴식"
			map5.get_child(0).text = "휴식"
			map6.get_child(0).text = "휴식"
			map7.get_child(0).text = "휴식"
		15:
			map4.get_child(0).text = "보스"
		_:
			map1.get_child(0).text = "랜덤"
			map2.get_child(0).text = "랜덤"
			map3.get_child(0).text = "랜덤"
			map4.get_child(0).text = "랜덤"
			map5.get_child(0).text = "랜덤"
			map6.get_child(0).text = "랜덤"
			map7.get_child(0).text = "랜덤"
