extends RayCast3D

func _ready():
	pass

func _process(_delta):
	if is_colliding():
		UIManager.can_interact = true
		if Input.is_action_just_pressed("interact"):
			get_collider().interact()
	else:
		UIManager.can_interact = false
