extends Node

var isPressed : bool
@onready var vBox = $UI/ScrollContainer/VBoxContainer
@onready var Scroll = $UI/ScrollContainer


func _ready():
	Scroll.set_deferred("scroll_vertical", 2408)

	
#기능: 마우스 드래그를 통해 화면을 움직이게 한다.
func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT: #클릭 여부를 체크
		if not isPressed and event.pressed:  #클릭 시 '누름' 상태가 아닐 경우 
			isPressed = true
		if isPressed and not event.pressed:  #클릭 해제시 '누름' 상태일 경우
			isPressed = false	
			
	var isOverlaped = checkOverLabed(event.get_position().x)		
	if event is InputEventMouseMotion and isPressed and !isOverlaped:  #드래그 여부를 체크
		vBox.set_position(Vector2(vBox.position.x, vBox.position.y + event.get_relative().y))
		if(vBox.position.y < -2408):    #맵 하향선 미만
			vBox.set_position(Vector2(vBox.position.x, -2408))
		if(vBox.position.y > 0):        #맵 상향선 초과
			vBox.set_position(Vector2(vBox.position.x, 0))  
		Scroll.set_v_scroll(Scroll.scroll_vertical - event.get_relative().y)
		
		
#플레이어가 드래그를 시작한 위치가 스크롤 바와 겹쳤는지 체크
func checkOverLabed(x):
	return (x >= Scroll.get_v_scroll_bar().position.x)
