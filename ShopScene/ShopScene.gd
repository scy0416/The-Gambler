extends Node

var gameData = GameData.new()
var rng = RandomNumberGenerator.new()
var genRelics = GenRelic.new()

#중복 체크를 위한 배열들
var normalChecked : Array
var rareChecked : Array
var legendaryChecked : Array
var epicChecked : Array

var normalCount : int
var rareCount : int
var epicCount : int
var legendaryCount: int

var allSellRelics : int

var drawRelicCount = 8


func _ready():
	initial()
	$goShop.pressed.connect(self.goShop)
	$shop/rerollB.pressed.connect(self.rerollRelics)
	$invenB.pressed.connect(self.viewInven)	
	drawScene()
#목적: 골드를 프레임 단위로 업데이트한다.	
func _process(_delta):
	$shop/shopGold.text = "GOLD: " + str(gameData.getGold())
	$inven/invenGold.text = "GOLD: " + str(gameData.getGold())

#목적: inventory에서 shop으로 이동한다.	
func goShop():
	$shop.visible = true
	$inven.visible = false
	
#목적: 화면을 그린다.	
# 정승화, 2023.11.21, 인벤, goshop 버튼 draw부분 삭제, ready부분으로 이동
func drawScene():
	drawRelics()
	drawItems()

func initial():
	normalChecked.resize(15)
	rareChecked.resize(8)
	epicChecked.resize(9)
	legendaryChecked.resize(6)
	normalChecked.fill(0)
	rareChecked.fill(0)
	epicChecked.fill(0)
	legendaryChecked.fill(0)		

#목적: 리롤 버튼을 화면에 그린다.
# 정승화, 2023.11.21, 해당 기능 이용 안 하도록 변경 
#func drawRerollB():
#	$shop/rerollB.set_anchor(0,130)
#	$shop/rerollB.set_anchor(1,130)
#	$shop/rerollB.set_size(Vector2(50, 50))
	
		
		
#목적: 인벤토리 버튼을 그린다.		
# 정승화, 2023.11.21, 해당 기능 이용 안 하도록 변경
#func drawInvenB():
#	$invenB.set_anchor(0, 130)
#	$invenB.set_size(Vector2(50, 50))
		
		
		
#목적: 유물을 화면에 그린다. 	
func drawRelics():
	for i in drawRelicCount:	
		var rarity = rng.randf_range(0, 1)
		rarity = weightedRarity(rarity)
		var foundRelic = findRelic(rarity)
		
		while(foundRelic == null):
			rarity = rng.randf_range(0, 1)
			rarity = weightedRarity(rarity)
			foundRelic = findRelic(rarity)
			
		var relicGold = foundRelic.price
		foundRelic.button.text = str(relicGold) + "\n" + foundRelic.description
		foundRelic.button.connect("pressed", buyRelic.bind(foundRelic))
		$shop/relicContainer.add_child(foundRelic.button)		
		
		
func drawItems():
	for i in 4:
		var item = ItemManager.getItem(i)
		var button = Button.new()
		button.icon = item.texture;
		print(button.icon)
		
		
		$shop/itemContainer.add_child(button)
		
			
	
#목적: 레어도에 따른 가중치 부여. 
func weightedRarity(r):
	if(r < 0.5):
		return 0
	elif(r < 0.85):
		return 1		
	elif(r < 0.95):
		return 2
	else:
		return 3	


#목적: rarity에 맞는 유물을 랜덤하게 찾는다. 이 때 상점에 이미 있는 유물, 혹은 이미 구입된 유물은 제외된다.
func findRelic(r):
	match r:
		0: 
			var i = rng.randi_range(0, genRelics.normalRelics.size() - 1)
			if(normalChecked[i] == 0 and genRelics.normalRelics[i].bought == false):
				normalChecked[i] = 1
				return genRelics.normalRelics[i]
			else:
				return null
			
		1: 
			var i = rng.randi_range(0, genRelics.rareRelics.size() - 1)
			if(rareChecked[i] == 0 and genRelics.rareRelics[i].bought == false):
				rareChecked[i] = 1
				return genRelics.rareRelics[i]
			else:
				return null	
				
		2: 
			var i = rng.randi_range(0, genRelics.epicRelics.size() - 1)
			if(epicChecked[i] == 0 and genRelics.epicRelics[i].bought == false):
				epicChecked[i] = 1
				return genRelics.epicRelics[i]	
			else:
				return null
		3: 
			var i = rng.randi_range(0, genRelics.legendaryRelics.size() - 1)
			if(legendaryChecked[i] == 0 and genRelics.legendaryRelics[i].bought == false): 
				legendaryChecked[i] = 1	
				return genRelics.legendaryRelics[i]
			else:
				return null	

#목적: 유물을 구입한다. 
func buyRelic(relic):	
	if(gameData.getGold() >= relic.price):
		relic.bought = true
		gameData.appendRelic(relic)
		gameData.setGold(gameData.getGold() - relic.price)
		relic.button.disconnect("pressed", buyRelic.bind(relic))
		relic.button.connect("pressed", sellRelic.bind(relic))
		$shop/relicContainer.remove_child(relic.button)
		$inven/invenContainer.add_child(relic.button)
		if(relic.rarity == 0):
			normalCount += 1
		if(relic.rarity == 1):
			rareCount += 1
		if(relic.rarity == 2):
			epicCount += 1	
		if(relic.rarity == 3):
			legendaryCount += 1		
		if(gameData.getGold() < 10):
			$shop/rerollB.disabled = true
	else:
		relic.button.text = "NOT ENOUGH MONEY"
		

#목적: shop에서 inventory로 이동한다.	
func viewInven():
	$shop.visible = false
	$inven.visible = true
	

#목적: 유물을 리롤한다.	
func rerollRelics():
	gameData.setGold(gameData.getGold() - 10)
	if(gameData.getGold() < 10):
		$shop/rerollB.disabled = true
	normalChecked.fill(0)
	rareChecked.fill(0)
	epicChecked.fill(0)
	legendaryChecked.fill(0)
	for i in $shop/relicContainer.get_children():
		i.disconnect("pressed", buyRelic.bind(Relic))
		$shop/relicContainer.remove_child(i)
	var buyRelicCount = normalCount + rareCount + epicCount + legendaryCount
	var allRelicCount = genRelics.normalRelics.size() + genRelics.rareRelics.size() + genRelics.epicRelics.size() + genRelics.legendaryRelics.size()
	
	if((allRelicCount - buyRelicCount) >= 8): 
		drawRelicCount = 8
	else:
		drawRelicCount = (allRelicCount - buyRelicCount) % 8	
	drawRelics()
		
		
#목적: 유물을 판매한다.		
func sellRelic(relic):
	gameData.setGold(gameData.getGold() + relic.price)	
	relic.bought = false	
	relic.button.disconnect("pressed", sellRelic.bind(relic))
	gameData.deleteRelic(relic)
	$inven/invenContainer.remove_child(relic.button)
	if(gameData.getGold() >= 10):
			$shop/rerollB.disabled = false
