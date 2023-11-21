extends Node

var gameData = GameData.new()
var rng = RandomNumberGenerator.new()
var genRelics = preload("res://ShopScene/generateRelics.gd").new()

#중복 체크를 위한 배열들
var normalChecked : Array
var rareChecked : Array
var legendaryChecked : Array

var normalCount : int
var rareCount : int
var legendaryCount: int


func _ready():
	genRelics.genRelics()
	initializeChecked()
	$goShop.pressed.connect(self.goShop)
	$shop/rerollB.pressed.connect(self.rerollRelics)
	drawScene()
	

#목적: 골드를 프레임 단위로 업데이트한다.	
func _process(_delta):
	$shop/shopGold.text = "GOLD: " + str(gameData.getGold())
	$inven/invenGold.text = "GOLD: " + str(gameData.getGold())
	$invenB.pressed.connect(self.viewInven)	

#목적: inventory에서 shop으로 이동한다.	
func goShop():
	$shop.visible = true
	$inven.visible = false
	
#목적: 화면을 그린다.	
# 정승화, 2023.11.21, 인벤, goshop 버튼 draw부분 삭제, ready부분으로 이동
func drawScene():
	drawRelics()
	
	
#목적: checked 배열들을 초기화한다. 
#checked 배열의 목적은 한 상점에 중복된 유물이 나오게 하지 않게 하는 것이다.
func initializeChecked():
	normalChecked.resize(genRelics.normalRelics.size())
	normalChecked.fill(0)
	rareChecked.resize(genRelics.rareRelics.size())
	rareChecked.fill(0)
	legendaryChecked.resize(genRelics.legendaryRelics.size())
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
	for i in 8:
		var rarity = rng.randf_range(0, 1)
		rarity = weightedRarity(rarity)
		
		
		if(gameData.getRelics().size()
			>= genRelics.normalRelics.size() + genRelics.rareRelics.size() + genRelics.legendaryRelics.size()):
				break;
				
		while(rarity == Relic.whatRare.NORMAL and normalCount >= genRelics.normalRelics.size()):
			rarity = rng.randf_range(0, 1)
			rarity = weightedRarity(rarity)
			
		while(rarity == Relic.whatRare.RARE and rareCount >= genRelics.rareRelics.size()):
			rarity = rng.randf_range(0, 1)
			rarity = weightedRarity(rarity)
			
		while(rarity == Relic.whatRare.LEGENDARY and legendaryCount >= genRelics.legendaryRelics.size()):
			rarity = rng.randf_range(0, 1)
			rarity = weightedRarity(rarity)
			
		var foundRelic = findRelic(rarity)
		var button = Button.new()
		var relicGold = foundRelic.price
		foundRelic.button.text = str(relicGold) + "\n" + foundRelic.description
		foundRelic.button.connect("pressed", buyRelic.bind(foundRelic))
		$shop/relicContainer.add_child(foundRelic.button)
				
	
	
#목적: 레어도에 따른 가중치 부여. 
func weightedRarity(r):
	if(r < 0.65):
		return Relic.whatRare.NORMAL
	elif(r < 0.90):
		return Relic.whatRare.RARE		
	else:
		return Relic.whatRare.LEGENDARY


#목적: rarity에 맞는 유물을 랜덤하게 찾는다. 이 때 상점에 이미 있는 유물, 혹은 이미 구입된 유물은 제외된다.
func findRelic(r):
	match r:
		Relic.whatRare.NORMAL: 
			var i = rng.randi_range(0, genRelics.normalRelics.size() - 1)
			while normalChecked[i] == 1 or genRelics.normalRelics[i].bought == true:
				i = rng.randi_range(0, genRelics.normalRelics.size() - 1)
			normalChecked[i] = 1	
			return genRelics.normalRelics[i]
		Relic.whatRare.RARE: 
			var i = rng.randi_range(0, genRelics.rareRelics.size() - 1)
			while rareChecked[i] == 1 or genRelics.rareRelics[i].bought == true:
				i = rng.randi_range(0, genRelics.rareRelics.size() - 1)
			rareChecked[i] = 1	
			return genRelics.rareRelics[i]
		Relic.whatRare.LEGENDARY: 
			var i = rng.randi_range(0, genRelics.legendaryRelics.size() - 1)
			while legendaryChecked[i] == 1 or genRelics.legendaryRelics[i].bought == true:
				i = rng.randi_range(0, genRelics.legendaryRelics.size() - 1)
			legendaryChecked[i] = 1	
			return genRelics.legendaryRelics[i]
	

#목적: 유물을 구입한다. 
func buyRelic(relic):	
	if gameData.getGold() >= relic.price:
		relic.bought = true
		gameData.appendRelic(relic)
		gameData.setGold(gameData.getGold() - relic.price)
		relic.button.disconnect("pressed", buyRelic.bind(relic))
		relic.button.connect("pressed", sellRelic.bind(relic))
		$shop/relicContainer.remove_child(relic.button)
		$inven/invenContainer.add_child(relic.button)
		if(relic.rarity == Relic.whatRare.NORMAL):
			normalCount += 1
		if(relic.rarity == Relic.whatRare.RARE):
			rareCount += 1
		if(relic.rarity == Relic.whatRare.LEGENDARY):
			rareCount += 1		
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
	legendaryChecked.fill(0)
	for i in $shop/relicContainer.get_children():
		i.disconnect("pressed", buyRelic.bind(Relic))
		$shop/relicContainer.remove_child(i)
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
