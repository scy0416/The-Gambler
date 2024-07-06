extends Node

@export var itemAddress = ["res://Item/Items/TextResources/DiamondRing.tres", "res://Item/Items/TextResources/Potion.tres", "res://Item/Items/TextResources/Sword.tres", 
"res://Item/Items/TextResources/TallShield.tres"]


func getItem(n):
	return load(itemAddress[n])
	


