extends Control
class_name MapLevelCard

@export var level:int
@export var nextLevel:MapLevelCard

@onready var map1 = $NodeContainer/FlippableCard
@onready var map2 = $NodeContainer/FlippableCard2
@onready var map3 = $NodeContainer/FlippableCard3
@onready var map4 = $NodeContainer/FlippableCard4
@onready var map5 = $NodeContainer/FlippableCard5
@onready var map6 = $NodeContainer/FlippableCard6
@onready var map7 = $NodeContainer/FlippableCard7

@onready var mapNodeList = [map1, map2, map3, map4, map5, map6, map7]

func _ready():
	pass
	#MakeMapNode()
#("일반 적", "엘리트 적", "보스 전투", "이벤트", "휴식", "상점")
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
