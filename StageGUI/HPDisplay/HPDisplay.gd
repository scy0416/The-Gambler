extends CenterContainer

@onready var label = $HBoxContainer/TokenAmount
@onready var image = $HBoxContainer/TokenImage

var token1 = Image.new()
var token2 = Image.new()
var token3 = Image.new()
var token1_texture = ImageTexture.new()
var token2_texture = ImageTexture.new()
var token3_texture = ImageTexture.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	token1 = token1.load_from_file("res://Sprites/token.png")
	token2 = token2.load_from_file("res://Sprites/tokens.png")
	token3 = token3.load_from_file("res://Sprites/tokens_stack.png")
	token1.resize(90, 90)
	token2.resize(90, 90)
	token3.resize(90, 90)
	token1_texture = ImageTexture.create_from_image(token1)
	token2_texture = ImageTexture.create_from_image(token2)
	token3_texture = ImageTexture.create_from_image(token3)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if GameManager.gameData.life < GameManager.gameData.max_life / 3:
		image.texture = token1_texture
	elif GameManager.gameData.life < GameManager.gameData.max_life / 3 * 2:
		image.texture = token2_texture
	else:
		image.texture = token3_texture
