extends BaseState

@export var JUMP_VELOCITY : float = 4.5

func enter() -> void:
	player.motion_mode = CharacterBody3D.MOTION_MODE_GROUNDED
	player.velocity.y += JUMP_VELOCITY

func physics_process(delta: float) -> int:
	var super_state = super(delta)
	if super_state != State.Null:
		return super_state

	return State.Fall
