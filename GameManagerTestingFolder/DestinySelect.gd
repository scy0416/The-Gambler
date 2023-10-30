extends Panel

signal destiny_select_cancel
signal destiny_selected(dest)


func cancel():
	emit_signal("destiny_select_cancel")


func deathSelect():
	emit_signal("destiny_selected", GameData.Destiny.DEATH)


func luckSelect():
	emit_signal("destiny_selected", GameData.Destiny.LUCK)


func devotionSelect():
	emit_signal("destiny_selected", GameData.Destiny.DEVOTION)


func wealthSelect():
	emit_signal("destiny_selected", GameData.Destiny.WEALTH)
