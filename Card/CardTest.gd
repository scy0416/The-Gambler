extends Node

enum handType{Top, One, Two, Triple, Straight, Flush}
var rng = RandomNumberGenerator.new()
var playerX : int
var playerY : int
var sumNumber : int
var enemyHP = 1000.0
var playerHP = 50.0
var playerAttack = 10.0
var playerShield = 0.0
var enemyDefence = 10.0
var cardArray : Array
var buttons : Array
var clickedButton : Button
var damage = 0.0
var checkChangeScene = false
var cemetryCards : Array
var deckCards : Array

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
var deckScript = preload("res://Card/Deck.gd").new()

var cardSelected = []
@onready var deckSize = cardDataBase.CardList.size()
var myHands : Array
# Called when the node enters the scene tree for the first time.
func _ready():
	deckScript.genDeck()
	$DeckButton.pressed.connect(self.showDeck)
	$CemetryButton.pressed.connect(self.showCemetry)
	playerX = $Player/Sprite2D.position.x
	playerY = $Player/Sprite2D.position.y
	$Player/TextureRect.texture = load(str("res://Card//Resource/" + deckScript.deck.back() + ".png"))
	
	var index = 0
	
	for i in deckScript.deck:
		var new_card = CardBase.instantiate()
		new_card.set_position(Vector2(200 + 100 * (index % 7), 80 + 180 * (index / 7)))
		new_card.cardName = i
		$Deck.add_child(new_card)
		deckCards.push_back(new_card)
		index += 1
		

func _process(delta):
	$Enemy/EnemyHP/ELabel.text = "HP: " + str(enemyHP)	
	$UIs/PlayerHP/PLabel.text = "HP: " + str(playerHP)
	$UIs/PShield.text = "Shield: " + str(playerShield)	
	$Enemy/EnemyHP.value = enemyHP
	$UIs/PlayerHP.value = playerHP		
					
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
		if event.keycode == KEY_Z:	
			attack()									
	

func draw():
	if(deckCards.is_empty()):
		cemetryToDeck()
	var new_card = deckCards.back()
	#cardSelected = rng.randi_range(0, deckSize - 1)
	#new_card.cardName = cardDataBase.CardList[cardSelected]
	deckCards.pop_back()
	ovalAngle = Vector2(HorRad * cos(angle), -VerRad * sin(angle))
	new_card.set_position(centerCardOval + ovalAngle - new_card.get_size()/2)
	new_card.rotation = deg_to_rad(90) - angle
	#new_card.connect("pressed", change.bind(new_card))
	
	var cardIndex = cardDataBase[new_card.cardName]
	var cardInfo = cardDataBase.DATA[cardIndex]
	
	var type = cardInfo[2]
	var number = cardInfo[1]
	
	$Deck.remove_child($Deck.get_child($Deck.get_children().size() - 1))
	$Card.add_child(new_card)
	myHands.append(new_card)		
	if(!deckCards.is_empty()):
		$Player/TextureRect.texture = deckCards.back().get_button_icon()	
	
		
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
	$Cemetry.add_child(card)
	cemetryCards.push_back(card)
	
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

	for i in myHands:
		$Card.remove_child(i)	
		$Cemetry.add_child(i)
		cemetryCards.push_back(i)
	
	for i in size:
		myHands.pop_back()
	angle = deg_to_rad(90) + 0.7	
	 	
	
	if(hand != null):
		$UIs/Label.text = hand
		enemyHP -= damage
		match hand:
			"TRIPLE": pass
			"STRAIGHT": pass
			"FLUSH": pass	
			"FULL HOUSE": 
				draw()
				draw()
				draw()
				draw()
				draw()
			"FOUR CARD": pass	
			"STRAIGHT FLUSH": pass	
	
func checkHand(numbers, types):
	var pairCount = 0
	var pSum = 0
	var tripleCount = 0
	var tSum = 0
	var straightCount = 0
	var flushCount = 0
	var fHCount = 0
	var fourCount = 0
	var fSum = 0
	var stFlush = 0
	var allSum = 0
	var max = numbers.max()
	damage = 0
	
	numbers.sort()
	types.sort()
	
	var index = 0
	var size = numbers.size()
	for i in numbers:	
		allSum += numbers[index]
		if(index <= size - 2):
			if(numbers[index + 1] - numbers[index] == 1):
				straightCount += 1
			if(numbers[index] == numbers[index + 1]):
				pairCount += 1
				pSum += numbers[index]
				pSum += numbers[index + 1]
				if(index <= size - 3):
					if(numbers[index] == numbers[index + 2]):
						pairCount -= 1
						pSum -= numbers[index] * 2
						pSum -= numbers[index + 1] * 2
			if(index <= size - 3):
				if(numbers[index] == numbers[index + 1] and numbers[index + 1] == numbers[index + 2]):
					tripleCount += 1	
					tSum += numbers[index]
					tSum += numbers[index + 1]
					tSum += numbers[index + 2]
			if(index <= size - 4):
				if(numbers[index] == numbers[index + 1] and numbers[index + 1] == numbers[index + 2]
				and numbers[index + 2] == numbers[index + 3]):
					fourCount += 1		
					fSum += numbers[index]
					fSum += numbers[index + 1]
					fSum += numbers[index + 2]
					fSum += numbers[index + 3]
		index += 1	
	index = 0	
	
	for i in types:
		if(index <= size - 2):
			if(types[index] == types[index + 1]):
				flushCount += 1
		index += 1		
	if(size >= 5):	
		if(straightCount == size - 1 and flushCount == size - 1):
			stFlush = 1
			damage = 3.0 * ((allSum + playerAttack) - enemyDefence)
			enemyDefence *= 0.5
			return "STRAIGHT FLUSH"	
	if(fourCount == 1):
		damage = 4.0 *((allSum + playerAttack) - enemyDefence)
		return "FOUR CARD"	
	if(pairCount == 2 and tripleCount == 1):
		damage = 1.5 *((tSum + pSum + playerAttack) - enemyDefence)
		return "FULL HOUSE"	
	if(size >= 5):	
		if(flushCount == size - 1):
			damage = 1.8 *((allSum + playerAttack) - enemyDefence)
			return "FLUSH"	
	if(size >= 5):		
		if(straightCount == size - 1):
			damage = 1.8 *((allSum + playerAttack) - enemyDefence)
			return "STRAIGHT"	
	if(tripleCount == 1):
		damage = 1.8 * ((tSum + playerAttack) - enemyDefence)
		return "TRIPLE"	
	if(pairCount == 2):
		damage = 1.8 *((pSum + playerAttack) - enemyDefence)
		return "TWO PAIR"	
	if(pairCount == 1):
		damage = 1.0 *((pSum + playerAttack) - enemyDefence)
		return "ONE PAIR"	
	
	if(size >= 1):	
		damage = 1.0 *((max + playerAttack) - enemyDefence)							
		return "TOP"		
	
func findNumber(name):
	return cardDataBase.DATA[cardDataBase[name]][1]
func findType(name):
	return cardDataBase.DATA[cardDataBase[name]][2]	
	
	
func viewChangeScene():
	var changeScene = changeScene.instantiate()
	checkChangeScene = true
	add_child(changeScene)
	$changeScene/Button.connect("pressed", exchange)
	$changeScene/Button.disabled = true
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
	$changeScene/Button.disabled = false
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
	
func showDeck():
	$Cemetry.visible = false
	if($Deck.visible == false):
		$Deck.visible = true
		for i in self.get_children():
			if(i != $Deck and i != $DeckButton and i != $Cemetry and i != $CemetryButton):
				i.modulate = Color(0.2, 0.2, 0.2, 1)
	else:
		$Deck.visible = false	
		for i in self.get_children():
			i.modulate = Color(1, 1, 1, 1)
			
func showCemetry():
	$Deck.visible = false
	var index = 0
	
	for i in cemetryCards:
		i.set_position(Vector2(200 + 100 * (index % 7), 80 + 180 * (index / 7)))
		i.rotation = deg_to_rad(0)	
		index += 1
		
	if($Cemetry.visible == false):
		$Cemetry.visible = true
		for i in self.get_children():
			if(i != $Deck and i != $DeckButton and i != $Cemetry and i != $CemetryButton):
				i.modulate = Color(0.2, 0.2, 0.2, 1)
	else:
		$Cemetry.visible = false	
		for i in self.get_children():
			i.modulate = Color(1, 1, 1, 1)		
	
func cemetryToDeck():
	cemetryCards.shuffle()
	for i in cemetryCards.size():
		deckCards.push_back(cemetryCards[i])
	var label = $Cemetry/Label.duplicate()
	for i in $Cemetry.get_children():
		$Cemetry.remove_child(i)
	$Cemetry.add_child(label)
	cemetryCards.clear()
	
	var index = 0
	for i in deckCards:
		i.set_position(Vector2(200 + 100 * (index % 7), 80 + 180 * (index / 7)))
		i.rotation = deg_to_rad(0)	
		$Deck.add_child(i)
		index += 1

