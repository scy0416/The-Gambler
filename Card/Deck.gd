extends Resource

var deck : Array
var cardDataBase = preload("res://Card/CardDatabase.gd")
# Called when the node enters the scene tree for the first time.
func genDeck():
	var listSize = cardDataBase.CardList.size()
	for i in listSize:
		deck.push_back(cardDataBase.CardList[i])
	
	deck.shuffle()	
