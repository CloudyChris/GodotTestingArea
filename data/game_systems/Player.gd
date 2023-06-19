class_name Player
extends CharacterBody3D

const EntityType : int = 1

@onready var springArmPivot = $SpringArmPivot
@onready var springArm = $SpringArmPivot/SpringArm
@onready var state_manager = $StateManager
@onready var swim_level = $swim_level

var shouldRotateCamera : bool = false
var captureMode : bool = false

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	state_manager.init(self)
	var itemdb_path : String = "res://data/assets/item_database/test_db.tres"
	var result
	if ResourceLoader.exists(itemdb_path):
		result = ResourceLoader.load(itemdb_path)
		if result:
			for iUUID in result.item_UUIDs:
				print(iUUID, " : ", result.items[result.item_UUIDs[iUUID]].item_name)

func _unhandled_input(event: InputEvent) -> void:
	state_manager.input(event)

func _physics_process(delta: float) -> void:
	state_manager.physics_process(delta)
	move_and_slide()

func is_in_water():
	var query : PhysicsPointQueryParameters3D = PhysicsPointQueryParameters3D.new()
	query.set_position(swim_level.get_global_position())
	query.set_collide_with_bodies(false)
	query.set_collide_with_areas(true)
	query.set_collision_mask(CollisionLayers.WATER)
	var space_state : PhysicsDirectSpaceState3D = get_world_3d().direct_space_state
	var results = space_state.intersect_point(query, 1)
	
	return results.size() != 0
