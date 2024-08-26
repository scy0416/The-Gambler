#========================================
# 최초 작성자: 송찬영
# 최초 작성일: 2023.10.09
# 목적: 유물의 정보를 저장할 수 있는 리소스(사용자정의 리소스 생성 목적)
#========================================
extends Resource
class_name Relic

enum Type{START_OF_COMBAT, START_OF_TURN, DURING_MOVE, END_OF_MOVE, DURING_ATTACK, END_OF_ATTACK, GET_BARRIER, START_OF_DAMAGE, END_OF_DAMAGE, END_OF_ACTION, EVENT_BASED}


@export var relic_name:String
@export var id: String
@export var relicType: Type
@export var icon: Texture
@export_multiline var tooltip: String							
@export var price : int                  						          
@export var rarity : int									
@export var button = Button.new()								
@export var bought : bool = false	
@export var description: String				


func initialize_relic(_owner: RelicUI) -> void:
	pass	
	
func activate_relic(_owner:RelicUI) -> void:
	pass
	
func deactivate_relic(_owner: RelicUI) -> void:
	pass	

func get_tooltip() -> String:
	return tooltip
	
	
#func _init(d, p, r):
#	description = d
#	price = p
#	rarity = r
#	button = Button.new()
#	bought = false
	

