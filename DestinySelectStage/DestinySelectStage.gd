extends StageTemplate


func death_select():
	GameManager.gameData.setDestiny(GameData.Destiny.DEATH)
	emit_signal("stage_done")


func luck_select():
	GameManager.gameData.setDestiny(GameData.Destiny.LUCK)
	emit_signal("stage_done")


func devotion_select():
	GameManager.gameData.setDestiny(GameData.Destiny.DEVOTION)
	emit_signal("stage_done")


func wealth_select():
	GameManager.gameData.setDestiny(GameData.Destiny.WEALTH)
	emit_signal("stage_done")


func disable_buttons():
	$MarginContainer/HBoxContainer/Death.disabled = true
	$MarginContainer/HBoxContainer/Luck.disabled = true
	$MarginContainer/HBoxContainer/Devotion.disabled = true
	$MarginContainer/HBoxContainer/Wealth.disabled = true
