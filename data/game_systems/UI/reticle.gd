extends TextureRect

var texture_normal : CompressedTexture2D
var texture_can_interact : CompressedTexture2D

func _ready():
	texture_normal = load("res://data/assets/UI/crosshair.png")
	texture_can_interact = load("res://data/assets/UI/crosshair_interact.png")

func _process(delta):
	if UIManager.can_interact:
		texture = texture_can_interact
	else:
		texture = texture_normal
