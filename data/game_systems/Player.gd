class_name Player
extends CharacterBody3D

@onready var visuals = $visuals
@onready var collider = $collider
@onready var head = $head
@onready var camera = $head/camera
@onready var state_manager = $StateManager

var shouldRotateCamera : bool = false
var capture_mode : bool = false
var current_roller_divergence : Vector2 = Vector2.ZERO
var current_mcd : float

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	state_manager.init(self)

func _unhandled_input(event: InputEvent) -> void:
	state_manager.input(event)

func _physics_process(delta: float) -> void:
	state_manager.physics_process(delta)
	move_and_slide()
