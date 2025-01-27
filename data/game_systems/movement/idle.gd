extends BaseState

func enter() -> void:
	player.motion_mode = CharacterBody3D.MOTION_MODE_GROUNDED

func input(event: InputEvent) -> int:
	return super.input(event)

func physics_process(_delta: float) -> int:	
	return super(_delta)
