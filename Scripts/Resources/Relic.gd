#========================================
# 최초 작성자: 송찬영
# 최초 작성일: 2023.10.09
# 목적: 유물의 정보를 저장할 수 있는 리소스(사용자정의 리소스 생성 목적)
#========================================
extends Resource
class_name Relic

@export var description : String							
@export var price : int                  						          
@export var rarity : int									
@export var button = Button.new()								
@export var bought : bool = false					
			
#func _init(d, p, r):
#	description = d
#	price = p
#	rarity = r
#	button = Button.new()
#	bought = false
	

