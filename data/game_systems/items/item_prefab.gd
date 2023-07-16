class_name ItemPrefab
extends PhysicsBody3D

@export var item : Item

func pick_up() -> void:
	queue_free()

func interact():
	pick_up()
