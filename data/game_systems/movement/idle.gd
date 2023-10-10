extends BaseState

func enter() -> void:
	#super.enter()
	player.motion_mode = CharacterBody3D.MOTION_MODE_GROUNDED

func input(event: InputEvent) -> int:
	super.input(event)
	if Input.is_action_just_pressed("jump"):
		return State.Jump
	if Input.get_vector("move_left", "move_right", "move_forward", "move_backward"):
		if player.is_in_water():
			return State.Swim
		if get_parent().is_walking:
			return State.Walk
		else:
			return State.Run
	return State.Null

func physics_process(_delta: float) -> int:	
	super(_delta)
	
	if player.is_in_water():
		return State.Swim

	if not player.is_on_floor():
		return State.Fall
	else:
		return State.Idle
	return State.Null
