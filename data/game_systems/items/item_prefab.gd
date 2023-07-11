class_name ItemPrefab
extends PhysicsBody3D

@export var item_id : UUID

func pick_up() -> UUID:
	queue_free()
	return item_id

func _mouse_enter():
	if Input.get_mouse_mode() != Input.MOUSE_MODE_CAPTURED:
		print("entered")

func _mouse_exit():
	if Input.get_mouse_mode() != Input.MOUSE_MODE_CAPTURED:
		print("exited")
