extends BaseState

func enter() -> void:
	player.motion_mode = CharacterBody3D.MOTION_MODE_GROUNDED

func physics_process(delta: float) -> int:
	var super_state = super(delta)
	if super_state != State.Null && super_state != State.Fall:
		return super_state
	
	player.velocity.y -= GRAVITY * delta
	player.velocity.y = clamp(player.velocity.y, -TERMINAL_VELOCITY, TERMINAL_VELOCITY)

	return State.Null
