#========================================
# 최초 작성자: 송찬영
# 최초 작성일: 2023.10.09
# 목적: 유물의 정보를 저장할 수 있는 리소스(사용자정의 리소스 생성 목적)
#========================================
extends Resource
class_name Relic

var description : String								#효과 설명
var price : int                  						#가격
enum whatRare{NORMAL, RARE, LEGENDARY, BOSS}			#레어도 종류             
var rarity : int										#레이도
var button : Button										#기능 구현을 위한 버튼
var bought : bool										#구입 여부

func _init(d, p, r):
	description = d
	price = p
	rarity = r
	button = Button.new()
	bought = false
	

