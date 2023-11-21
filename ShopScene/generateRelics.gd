extends Resource

var normalRelics : Array
var rareRelics : Array
var legendaryRelics : Array
var bossRelics : Array
var x = 1
var rng = RandomNumberGenerator.new()


#목적: 랜덤한 유물을 생성한다. 상점의 기능을 시험하기 위한 임시 스크립트로 이후 삭제할 예정.
func genRelics():
	for i in 30:
		var s = "NORMAL " + str(i)
		var p = rng.randi_range(1, 50)
		var r = Relic.whatRare.NORMAL
		var relic = Relic.new(s, p, r)
		normalRelics.append(relic)
	
	for i in 15:
		var s = "RARE " + str(i)
		var p = rng.randi_range(50, 100)
		var r = Relic.whatRare.RARE
		var relic = Relic.new(s, p, r)
		rareRelics.append(relic)
	
	for i in 8:
		var s = "LEGENDARY " + str(i)
		var p = rng.randi_range(100, 150)
		var r = Relic.whatRare.LEGENDARY
		var relic = Relic.new(s, p, r)
		legendaryRelics.append(relic)	
		
	for i in 4:
		var s = "BOSS " + str(i)
		var p = rng.randi_range(150, 200)
		var r = Relic.whatRare.BOSS
		var relic = Relic.new(s, p, r)
		bossRelics.append(relic)			
	
