extends Node3D

@export var parent : PhysicsBody3D
@export var parent_shape : Shape3D

@onready var collider = $collider

func _ready():
	parent = get_parent()
	# consider dynamically adding collision shapes (the node) to the tree for each parent shape
	var parent_shapes = parent.get_shape_owners()
	if parent_shapes.size() == 0:
		push_warning("Parent doesn't have a collision shape set")
	else:
		parent_shape = parent.shape_owner_get_shape(parent_shapes[0], 0)
		#lines below are for debug purposes, although scaling the collision for the interaction by a bit (scale *= 1.1 or something) could be beneficial. Testing required
		print("Got shape")
		scale *= 2
	
	collider.set_shape(parent_shape)

func _process(delta):
	pass

func entered_interact_area() -> void:
	self.collision_layer = (1 << 12) | (1 << 4)

func left_interact_area() -> void:
	self.collision_layer = 1 << 12
