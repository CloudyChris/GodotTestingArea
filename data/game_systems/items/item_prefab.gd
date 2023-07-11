class_name ItemPrefab
extends PhysicsBody3D

@export var item_id : UUID

func pick_up() -> UUID:
	queue_free()
	return item_id
