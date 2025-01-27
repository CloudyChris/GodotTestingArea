class_name BaseState
extends Node

enum State {
	Null,
	Downed,
	Dead,
	Idle,
	Walk,
	Run,
	Jump,
	Fall
}

@export var animation_name : String

@export var CAMERA_SENSITIVITY : float = 0.004

@export var SPEED : float = 4.0
@export var TERMINAL_VELOCITY : float = 20.0
@export var GRAVITY : float = 9.8

const MAX_CAMERA_ANGLE : float = -PI/2
const MIN_CAMERA_ANGLE : float = PI/2

const base_fov = 75;
var target_fov = 80;

var player: Player

func enter() -> void:
	pass

func exit() -> void:
	pass
	
func input(event: InputEvent) -> int:
	if Input.is_action_just_pressed("escape"):
		get_tree().quit()
	
	if Input.is_action_just_released("toggle_mouse_capture"):
		player.capture_mode = not player.capture_mode
		player.shouldRotateCamera = player.capture_mode
		if player.capture_mode:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	if not player.capture_mode:
		if Input.is_action_just_pressed("right_click"):
			player.shouldRotateCamera = true
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		
		if Input.is_action_just_released("right_click"):
			player.shouldRotateCamera = false
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	if (player.capture_mode or player.shouldRotateCamera) and (event is InputEventMouseMotion):
		player.head.rotate_y(-event.relative.x * CAMERA_SENSITIVITY)
		player.visuals.rotation.y = player.head.rotation.y
		player.collider.rotation.y = player.head.rotation.y
		player.camera.rotate_x(-event.relative.y * CAMERA_SENSITIVITY)
		player.camera.rotation.x = clamp(player.camera.rotation.x, MAX_CAMERA_ANGLE, MIN_CAMERA_ANGLE)
	
	if player.is_on_floor():
		if Input.is_action_just_pressed("jump"):
			return State.Jump
	
	return State.Null

func physics_process(_delta: float) -> int:
	if player.state_manager.is_walking:
		SPEED = 4.0
		target_fov = 80
	else:
		SPEED = 7.0
		target_fov = 90
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction = (player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	direction = direction.rotated(Vector3.UP, player.head.rotation.y)
	if direction:
		player.velocity.x = move_toward(player.velocity.x, direction.x * SPEED, 1)
		player.velocity.z = move_toward(player.velocity.z, direction.z * SPEED, 1)
		var camera_fov_f = abs(input_dir.y)
		player.camera.fov = move_toward(player.camera.fov, (1.0-camera_fov_f)*base_fov + target_fov*camera_fov_f, 0.5)
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, 1)
		player.velocity.z = move_toward(player.velocity.z, 0, 1)
		player.camera.fov = move_toward(player.camera.fov, base_fov, 0.5)
	
	if not player.is_on_floor():
		return State.Fall
	elif player.is_on_floor():
		if direction:
			return State.Walk
		else:
			return State.Idle
	return State.Null
