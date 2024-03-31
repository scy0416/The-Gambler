extends CenterContainer

@onready var itemTextureRext = $ItemTextureRect
@export var itemNow:Items

func displayItem(item):
	if item is Items:
		itemTextureRext.texture = item.texture
		itemNow = item
	else:
		itemTextureRext.texture = load("res://Item/Items/Sprites/EmptyInventorySlot.png")


