extends Node

enum cardType{Clover, Diamond, Heart, Spade}
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


# Called when the node enters the scene tree for the first time.
func _ready():
	$Player/Buttons/ChooseButton.pressed.connect(self.choose)
	$Player/Buttons/DrawButton.pressed.connect(self.draw)
	$Player/Buttons/ChangeButton.pressed.connect(self.change)
	$Player/Buttons/MoveButton.pressed.connect(self.move)
	$Player/Buttons/AttackButton.pressed.connect(self.attack)
	playerX = $Player/Sprite2D.position.x
	playerY = $Player/Sprite2D.position.y
	
	
	$Card/Button1.disabled = true
	$Card/Button2.disabled = true
	$Card/Button3.disabled = true
	$Card/Button4.disabled = true
	$Card/Button5.disabled = true

	$Card/Button1.connect("pressed", changeIcon.bind($Card/Button1, 0))
	$Card/Button2.connect("pressed", changeIcon.bind($Card/Button2, 1))
	$Card/Button3.connect("pressed", changeIcon.bind($Card/Button3, 2))
	$Card/Button4.connect("pressed", changeIcon.bind($Card/Button4, 3))
	$Card/Button5.connect("pressed", changeIcon.bind($Card/Button5, 4))
	
	buttons.append($Card/Button1)
	buttons.append($Card/Button2)
	buttons.append($Card/Button3)
	buttons.append($Card/Button4)
	buttons.append($Card/Button5)

func _process(delta):
	$Enemy/EnemyHP/ELabel.text = "HP: " + str(enemyHP)	
	$Player/PlayerHP/PLabel.text = "HP: " + str(playerHP)
	$Player/PShield.text = "Shield: " + str(playerShield)	
	$Enemy/EnemyHP.value = enemyHP
	$Player/PlayerHP.value = playerHP		
	
	if(cardArray.size() >= 5):
		$Player/Buttons/DrawButton.disabled = true

func choose(): 	
	$Player/Buttons/DrawButton.visible = true
	$Player/Buttons/ChangeButton.visible = true
	$Player/Buttons/MoveButton.visible = true
	$Player/Buttons/AttackButton.visible = true
	

func draw():
	var rand = rng.randi_range(0, 3)
	var card
	var link
	
	match rand:
		cardType.Clover:
			var rand2 = rng.randi_range(1, 5)	
			card = MyCard.new(rand, rand2)
			link = "res://Card/Resource/Clover" + str(rand2) + ".png"
			sumNumber += rand2
			enemyHP = enemyHP - sumNumber * 1.5 * 3
			
		cardType.Diamond:
			var rand2 = rng.randi_range(1, 2)
			link = "res://Card/Resource/Diamond" + str(rand2) + ".jpg"
			sumNumber += rand2
			card = MyCard.new(rand, rand2)
			
		cardType.Heart:
			var rand2 = rng.randi_range(1, 4)	
			card = MyCard.new(rand, rand2)
			link = "res://Card/Resource/Heart" + str(rand2) + ".jpg"
			sumNumber += rand2
			playerHP += rand2	
				
		cardType.Spade:
			var rand2 = rng.randi_range(1, 5)	
			card = MyCard.new(rand, rand2)
			link = "res://Card/Resource/Spade" + str(rand2) + ".jpg"
			sumNumber += rand2
			enemyHP = enemyHP - sumNumber * 1.0
							
			
	match cardArray.size():
		0: $Card/Button1.set_button_icon(load(link))		
		1: $Card/Button2.set_button_icon(load(link))	
		2: $Card/Button3.set_button_icon(load(link))
		3: $Card/Button4.set_button_icon(load(link))
		4: $Card/Button5.set_button_icon(load(link))	
		_: print("no")
	cardArray.append(card)
	
func change():
	var cardNum = cardArray.size()
	for i in cardNum:
		buttons[i].disabled = false

func changeIcon(button, n):
	var rand = rng.randi_range(0, 3)
	var card
	var link
	cardArray.remove_at(n)
	sumNumber = 0
	for i in cardArray:
		sumNumber += i.number
	
	match rand:
		cardType.Clover:
			var rand2 = rng.randi_range(1, 5)	
			card = MyCard.new(rand, rand2)
			link = "res://Card/Resource/Clover" + str(rand2) + ".png"
			sumNumber += rand2
			enemyHP = enemyHP - sumNumber * 1.5
		
		cardType.Diamond:
			var rand2 = rng.randi_range(1, 2)
			link = "res://Card/Resource/Diamond" + str(rand2) + ".jpg"
			card = MyCard.new(rand, rand2)
			sumNumber += rand2
			playerShield += rand2
		
		cardType.Heart:
			var rand2 = rng.randi_range(1, 4)	
			card = MyCard.new(rand, rand2)
			link = "res://Card/Resource/Heart" + str(rand2) + ".jpg"
			sumNumber += rand2
			playerShield += rand2
					
		cardType.Spade:
			var rand2 = rng.randi_range(1, 5)	
			card = MyCard.new(rand, rand2)
			link = "res://Card/Resource/Spade" + str(rand2) + ".jpg"
			sumNumber += rand2
			enemyHP = enemyHP - sumNumber * 1.0
								
			

			
	button.set_button_icon(load(link))	
	cardArray.insert(n, card)
func move():
	pass
	
func attack():	
	var max = 0
	var maxType = -1
	var index = 0
	var temp = 0
	for i in cardArray:
		if(i.number >= max):
			if(i.number > max):
				max = i.number
				maxType = i.type
				temp = index
			else:
				if(i.type > maxType):
					max = i.number
					maxType = i.type
					temp = index
		index += 1
		
	cardArray.remove_at(temp)
	buttons[temp].set_button_icon(load("res://Card/Resource/cardBack.png"))	
	enemyHP = enemyHP - sumNumber * 1.5 * 3	
	print("temp: " + str(temp))		
	print("max: " + str(max))
	print("maxType: " + str(maxType))				
