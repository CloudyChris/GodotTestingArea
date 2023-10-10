extends TextureRect

@export_color_no_alpha var cnormal : Color = Color.WHITE
@export_color_no_alpha var cinteract : Color = Color("44bbff")

func _ready():
	pass

func _process(_delta):
	if UIManager.can_interact:
		modulate = cinteract
	else:
		modulate = cnormal
