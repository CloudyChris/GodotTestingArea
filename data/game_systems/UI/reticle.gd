extends TextureRect

@export_color_no_alpha var cnormal : Color = Color.WHITE
@export_color_no_alpha var cinteract : Color = Color("44bbff")

func _ready():
	pass

func _process(_delta):
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		visible = true
	elif Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
		visible = false
	else:
		push_warning("Mouse mode in unaccounted-for state.")
