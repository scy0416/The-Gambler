extends Node

enum handType{Top, One, Two, Triple, Straight, Flush}
var rng = RandomNumberGenerator.new()
var playerX : int
var playerY : int
var sumNumber : int
var enemyHP = 1000.0
var playerHP = 50.0
var playerShield = 0.0
var cardArray : Array
var buttons : Array
var clickedButton : Button
var checkChangeScene = false

@onready var gameSizeX = 560
@onready var gameSizeY = 550
@onready var centerCardOval = Vector2(100 + gameSizeX * 0.5, 50 + gameSizeY * 1.25)
@onready var HorRad = gameSizeX * 0.45
@onready var VerRad = gameSizeY * 0.4
var angle = deg_to_rad(90) + 0.7
var ovalAngle = Vector2()

const CardBase = preload("res://Card/CardBase.tscn")
const cardDataBase = preload("res://Card/CardDatabase.gd")
const changeScene = preload("res://Card/changeScene.tscn")
var cardSelected = []
@onready var deckSize = cardDataBase.CardList.size()
var myHands : Array
# Called when the node enters the scene tree for the first time.
func _ready():
	$Player/Buttons/ChooseButton.pressed.connect(self.choose)
	$Player/Buttons/DrawButton.pressed.connect(self.draw)
	$Player/Buttons/AttackButton.pressed.connect(self.attack)
	playerX = $Player/Sprite2D.position.x
	playerY = $Player/Sprite2D.position.y

	

func _process(delta):
	$Enemy/EnemyHP/ELabel.text = "HP: " + str(enemyHP)	
	$UIs/PlayerHP/PLabel.text = "HP: " + str(playerHP)
	$UIs/PShield.text = "Shield: " + str(playerShield)	
	$Enemy/EnemyHP.value = enemyHP
	$UIs/PlayerHP.value = playerHP		
	
	if(myHands.size() >= 5):
		$Player/Buttons/DrawButton.disabled = true
	if(myHands.size() < 5):
		$Player/Buttons/DrawButton.disabled = false
		
func _input(event):
	if event is InputEventKey and event.pressed and checkChangeScene == false:
		if event.keycode == KEY_LEFT or event.keycode == KEY_A:
			$Player.set_position($Player.get_position() + Vector2(-10,0))	
			if(myHands.size() >= 5):
				viewChangeScene()
			if(myHands.size() < 5):
				draw()
		if event.keycode == KEY_RIGHT or event.keycode == KEY_D:
			$Player.set_position($Player.get_position() + Vector2(10,0))
			if(myHands.size() >= 5):
				viewChangeScene()
			if(myHands.size() < 5):
				draw()	
		if event.keycode == KEY_UP or event.keycode == KEY_W:
			$Player.set_position($Player.get_position() + Vector2(0,-10))
			if(myHands.size() >= 5):
				viewChangeScene()	
			if(myHands.size() < 5):
				draw()
		if event.keycode == KEY_DOWN or event.keycode == KEY_S:
			$Player.set_position($Player.get_position() + Vector2(0, 10))
			if(myHands.size() >= 5):
				viewChangeScene()	
			if(myHands.size() < 5):
				draw()			
			
										
func choose(): 	
	$Player/Buttons/DrawButton.visible = true
	$Player/Buttons/AttackButton.visible = true
	

func draw():
	var new_card = CardBase.instantiate()
	cardSelected = rng.randi_range(0, deckSize - 1)
	new_card.cardName = cardDataBase.CardList[cardSelected]
	new_card.set_size(Vector2(90, 163))
	ovalAngle = Vector2(HorRad * cos(angle), -VerRad * sin(angle))
	new_card.set_position(centerCardOval + ovalAngle - new_card.get_size()/2)
	new_card.rotation = deg_to_rad(90) - angle
	new_card.connect("mouse_entered", modulEnter.bind(new_card))
	new_card.connect("mouse_exited", modulExit.bind(new_card))
	#new_card.connect("pressed", change.bind(new_card))
	
	var cardIndex = cardDataBase[new_card.cardName]
	var cardInfo = cardDataBase.DATA[cardIndex]
	
	var type = cardInfo[2]
	var number = cardInfo[1]
	
	$Card.add_child(new_card)
	myHands.append(new_card)	
	sumNumber = 0
	
	for i in myHands:
		sumNumber += findNumber(i.cardName)
	angle -= 0.3
	if(checkChangeScene == false):
		match type:
			0:
				enemyHP = enemyHP - sumNumber * 1.5
			1:
				viewChangeScene()
			2:
				playerHP += number
			3: 
				enemyHP = enemyHP - sumNumber * 1.0
	if(checkChangeScene == true):
		match type:
			0:
				enemyHP = enemyHP - sumNumber * 1.5
			1:
				playerShield += number
			2:
				playerShield += number
			3: 
				enemyHP = enemyHP - sumNumber * 1.0
func change(card):
	goDeck(card)	
	#교체 효과와 드로우 효과가 다르므로 수정 필요 
	draw()
		
func goDeck(card):
	$Card.remove_child(card)
	myHands.erase(card)	
	angle = deg_to_rad(90) + 0.7
	sumNumber -= findNumber(card.cardName)
	for i in myHands:
		ovalAngle = Vector2(HorRad * cos(angle), -VerRad * sin(angle))
		i.set_position(centerCardOval + ovalAngle - i.get_size()/2)
		i.rotation = deg_to_rad(90) - angle		
		angle -= 0.3	
func move():
	pass
	

	
func attack():	
	var numbers = []
	var types = []
	var size = myHands.size()
	var index = 0
	
	for i in myHands:
		numbers.append(findNumber(i.cardName))
		types.append(findType(i.cardName))
	
	var hand = checkHand(numbers, types)
	
	if(hand != null):
		$UIs/Label.text = hand
	
	for i in myHands:
		$Card.remove_child(i)	
	
	for i in size:
		myHands.pop_back()
	angle = deg_to_rad(90) + 0.7	
func checkHand(numbers, types):
	var pairCount = 0
	var tripleCount = 0
	var straightCount = 0
	var flushCount = 0
	var fHCount = 0
	var fourCount = 0
	var stFlush = 0
	
	numbers.sort()
	types.sort()
	
	var index = 0
	var size = numbers.size()
	var temp = 0
	for i in numbers:	
		if(index <= size - 2):
			if(numbers[index + 1] - numbers[index] == 1):
				straightCount += 1
			if(numbers[index] == numbers[index + 1]):
				pairCount += 1
				if(index <= size - 3):
					if(numbers[index] == numbers[index + 2]):
						pairCount -= 1
			if(index <= size - 3):
				if(numbers[index] == numbers[index + 1] and numbers[index + 1] == numbers[index + 2]):
					tripleCount += 1	
			if(index <= size - 4):
				if(numbers[index] == numbers[index + 1] and numbers[index + 1] == numbers[index + 2]
				and numbers[index + 2] == numbers[index + 3]):
					fourCount += 1		
		index += 1	
	index = 0	
	
	for i in types:
		if(index <= size - 2):
			if(types[index] == types[index + 1]):
				flushCount += 1
		index += 1		
		
	if(straightCount == size - 1 and flushCount == size - 1):
		stFlush = 1
		return "STRAIGHT FLUSH"	
	if(fourCount == 1):
		return "FOUR CARD"	
	if(pairCount == 2 and tripleCount == 1):
		return "FULL HOUSE"	
	if(flushCount == size - 1):
		return "FLUSH"	
	if(straightCount == size - 1):
		return "STRAIGHT"	
	if(tripleCount == 1):
		return "TRIPLE"	
	if(pairCount == 2):
		return "TWO PAIR"	
	if(pairCount == 1):
		return "ONE PAIR"						
			
func findNumber(name):
	return cardDataBase.DATA[cardDataBase[name]][1]
func findType(name):
	return cardDataBase.DATA[cardDataBase[name]][2]	
func modulEnter(card):
	card.modulate = Color(0.8, 0.8, 0.8, 1)
func modulExit(card):
	card.modulate = Color(1, 1, 1, 1)
	
func viewChangeScene():
	var changeScene = changeScene.instantiate()
	checkChangeScene = true
	add_child(changeScene)
	$changeScene/Button.connect("pressed", exchange)
	$TileMap.modulate = Color(0.2, 0.2, 0.2, 1)
	$Player.modulate = Color(0.2, 0.2, 0.2, 1)
	$Enemy.modulate = Color(0.2, 0.2, 0.2, 1)
	for i in myHands:
		#i.disconnect("pressed", change)
		i.connect("pressed", changeScenePressed.bind(i))	
		
func changeScenePressed(card):
	clickedButton = card
	var checked = false
	angle = deg_to_rad(90) + 0.7
	
	for i in myHands:
		ovalAngle = Vector2(HorRad * cos(angle), -VerRad * sin(angle))
		i.set_position(centerCardOval + ovalAngle - i.get_size()/2)
		i.rotation = deg_to_rad(90) - angle				
		if(i == card):
			checked = true
			angle += 0.3
		angle -= 0.3
	card.rotation = deg_to_rad(0)
	$changeScene/PanelContainer.visible = false
	card.set_position($changeScene/PanelContainer.get_position())
   
func exchange():
	$changeScene.visible = false
	$TileMap.modulate = Color(1, 1, 1, 1)
	$Player.modulate = Color(1, 1, 1, 1)
	$Enemy.modulate = Color(1, 1, 1, 1)
	for i in myHands:
		i.disconnect("pressed", changeScenePressed.bind(i))
		#i.connect("pressed", change)
	change(clickedButton)
	remove_child($changeScene)		
	checkChangeScene = false
	
