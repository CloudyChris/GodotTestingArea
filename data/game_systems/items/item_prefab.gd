class_name ItemPrefab
extends PhysicsBody3D

@export var item_id : UUID

func pick_up() -> void:
	queue_free()

func interact():
	pick_up()
