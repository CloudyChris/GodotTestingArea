extends BaseState

func input(event: InputEvent) -> int:
	super.input(event)
	if Input.is_action_just_pressed("jump"):
		return State.Jump
	if Input.get_vector("move_left", "move_right", "move_forward", "move_backward"):
		return State.Walk
	return State.Null

func physics_process(_delta: float) -> int:	
	super(_delta)
	if not player.is_on_floor():
		return State.Fall
	return State.Null
