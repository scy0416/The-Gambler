extends GridContainer

var inventory = preload("res://Item/Items/inventory.tres")

func _ready():
	inventory.connect("items_changed", Callable(self, "_on_items_changed"))
	updateInventoryDisplay()

func updateInventoryDisplay():
	for item_index in inventory.items.size():
		updateInventorySlotDisplay(item_index)

func updateInventorySlotDisplay(item_index):
	var inventorySlotDisplay = get_child(item_index)
	var item = inventory.items[item_index]
	inventorySlotDisplay.displayItem(item)
	
	
func _on_items_changed(indexes):
	for item_index in indexes:
		updateInventorySlotDisplay(item_index)


