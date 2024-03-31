extends Resource
#기능 확인을 위한 임시 데이터. 추후 수정 예정
class_name tempData

var gameData = GameData.new()

@export var eArray = ["ENEMY", "DUMMY", str(1000), str(10), str(10), str(1), str(1), str(3), "LONG", "DUMMY-WEAK\n ENEMY"]
@export var pArray = ["PLAYER", "HERO", str(gameData.getLife()), str(10), str(1), str(0), str(1), "THE PROTAGONIST\n OF THIS GAME"]
