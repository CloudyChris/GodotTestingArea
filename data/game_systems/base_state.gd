class_name BaseState
extends Node

enum State {
	Null,
	Idle,
	Walk,
	Jump,
	Fall,
	Swim
}

@export var animation_name : String

@export var CAMERA_SENSITIVITY : float = 0.005
@export var MAX_CAMERA_DISTANCE : float = 10
@export var CAMERA_ZOOM_SENSITIVITY : float = 0.25

const MAX_CAMERA_ANGLE : float = -PI/2
const MIN_CAMERA_ANGLE : float = PI/3

var player: Player

func enter() -> void:
	#player.animations.play(animation_name)
	pass

func exit() -> void:
	pass
	
func input(event: InputEvent) -> int:
	# TODO: replace when adding pause functionality
	if Input.is_action_just_pressed("escape"):
		get_tree().quit()
	
	if Input.is_action_just_released("toggle_mouse_capture"):
		player.captureMode = not player.captureMode
		player.shouldRotateCamera = false
		if player.captureMode:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	if not player.captureMode:
		if Input.is_action_just_pressed("right_click"):
			player.shouldRotateCamera = true
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		
		if Input.is_action_just_released("right_click"):
			player.shouldRotateCamera = false
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	if (player.captureMode or player.shouldRotateCamera) and (event is InputEventMouseMotion):
		
		player.springArmPivot.rotate_y(-event.relative.x * CAMERA_SENSITIVITY)
		player.springArm.rotate_x(-event.relative.y * CAMERA_SENSITIVITY)
		player.springArm.rotation.x = clamp(player.springArm.rotation.x, MAX_CAMERA_ANGLE, MIN_CAMERA_ANGLE)
	
	if Input.is_action_just_released("zoom_in"):
		player.springArm.set_length(clamp(player.springArm.spring_length-CAMERA_ZOOM_SENSITIVITY, 0, MAX_CAMERA_DISTANCE))
	if Input.is_action_just_released("zoom_out"):
		player.springArm.set_length(clamp(player.springArm.spring_length+CAMERA_ZOOM_SENSITIVITY, 0, MAX_CAMERA_DISTANCE))
	return State.Null

func physics_process(delta: float) -> int:
	return State.Null
