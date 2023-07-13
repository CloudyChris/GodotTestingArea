extends Node

@export var parent : PhysicsBody3D

func _ready():
	parent = get_parent()
	parent.collision_layer |= 1 << 12
	
	if not parent.has_method("interact"):
		push_error("Interactible doesn't implement interact method")

func entered_interact_area() -> void:
	parent.collision_layer |= 1 << 4

func left_interact_area() -> void:
	parent.collision_layer &= ~(1 << 4)
