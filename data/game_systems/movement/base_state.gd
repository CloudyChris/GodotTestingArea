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
@export var MAX_CAMERA_DISTANCE : float = 5.0
@export var CAMERA_ZOOM_SENSITIVITY : float = 1.5

const MAX_CAMERA_ANGLE : float = -PI/2
const MIN_CAMERA_ANGLE : float = PI/2

var player: Player

var MAX_LATERAL_CAMERA_OFFSHOOT : float = 1.0
var MAX_VERTICAL_CAMERA_OFFSHOOT : float = 2.0

var CAMERA_OFFSHOOT_LR : float = MAX_LATERAL_CAMERA_OFFSHOOT/MAX_CAMERA_DISTANCE
var CAMERA_OFFSHOOT_VR : float = MAX_VERTICAL_CAMERA_OFFSHOOT/MAX_CAMERA_DISTANCE

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
		player.visuals.rotation.y = player.springArmPivot.rotation.y
		player.collider.rotation.y = player.springArmPivot.rotation.y
		player.interact_area.rotation.y = player.springArmPivot.rotation.y
		player.springArm.rotate_x(-event.relative.y * CAMERA_SENSITIVITY)
		player.springArm.rotation.x = clamp(player.springArm.rotation.x, MAX_CAMERA_ANGLE, MIN_CAMERA_ANGLE)
	
	if Input.is_action_just_released("zoom_in"):
		player.current_mcd = floor(clamp(player.springArm.spring_length-CAMERA_ZOOM_SENSITIVITY, 0, MAX_CAMERA_DISTANCE))
	if Input.is_action_just_released("zoom_out"):
		player.current_mcd = floor(clamp(player.springArm.spring_length+CAMERA_ZOOM_SENSITIVITY, 0, MAX_CAMERA_DISTANCE))
	return State.Null

func physics_process(_delta: float) -> int:
	var lerp_mcd = player.springArm.get_length()
	if player.springArm.get_hit_length() != player.springArm.get_length():
		player.current_mcd = floor(player.springArm.get_hit_length())
	player.springArm.set_length(lerp(lerp_mcd, player.current_mcd, .1))
	var current_spring_length : float = player.springArm.get_length()
	player.roller.position.x = current_spring_length * CAMERA_OFFSHOOT_LR
	player.roller.position.y = current_spring_length * CAMERA_OFFSHOOT_VR

	return State.Null
