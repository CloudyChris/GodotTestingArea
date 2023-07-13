extends RayCast3D

func _ready():
	pass

func _process(_delta):
	if is_colliding() and Input.is_action_just_pressed("interact"):
		get_collider().interact()
