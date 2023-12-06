extends Control

@onready var label = $HBoxContainer/HP
@onready var image = $HBoxContainer/HPImage

func update():
	label.text = "%d/%d" % [GameManager.gameData.life, GameManager.gameData.max_life]
	if GameManager.gameData.life < GameManager.gameData.max_life / 3:
		image.texture = ImageTexture.create_from_image(Image.load_from_file("res://Sprites/HUDSprites/token.png"))
	elif GameManager.gameData.life < GameManager.gameData.max_life / 3 * 2:
		image.texture = ImageTexture.create_from_image(Image.load_from_file("res://Sprites/HUDSprites/tokens.png"))
	else:
		image.texture = ImageTexture.create_from_image(Image.load_from_file("res://Sprites/HUDSprites/tokens_stack.png"))
