extends Node
class_name Deck

enum PATTERN {SPADE = 1, DIAMOND, HEART, CLOVER}
enum RANK {HIGH_CARD, ONE_PAIR, TWO_PAIR}

var onHand = []
var offHand = []


func shuffle():
	randomize()
	onHand.shuffle()


func isEmpty():
	return onHand.is_empty()


func draw():
	return onHand.pop_back()


func refill():
	onHand = offHand
	offHand = []
	shuffle()
