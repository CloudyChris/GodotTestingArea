extends BaseState

func enter() -> void:
	player.motion_mode = CharacterBody3D.MOTION_MODE_GROUNDED

func input(event: InputEvent) -> int:
	super.input(event)
	if Input.is_action_just_pressed("jump"):
		return State.Jump
	return State.Null

func physics_process(delta: float) -> int:
	super(delta)
	
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction = (player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	direction = direction.rotated(Vector3.UP, player.head.rotation.y)
	if direction:
		player.velocity.x = direction.x * SPEED
		player.velocity.z = direction.z * SPEED
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, SPEED)
		player.velocity.z = move_toward(player.velocity.z, 0, SPEED)
	
	if not player.is_on_floor():
		return State.Fall
	elif player.is_on_floor():
		if direction:
			return State.Walk
		else:
			return State.Idle
	
	return State.Null
