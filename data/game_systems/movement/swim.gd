extends BaseState

@export var SPEED : float = 3.0
@export var TERMINAL_VELOCITY : float = 20.0
@export var DIVE_THRESHOLD : float = 0.2

func enter() -> void:
	#super.enter()
	player.velocity.y = 0

func input(event: InputEvent) -> int:
	super.input(event)
	return State.Null

func physics_process(delta: float) -> int:
	super(delta)
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction = (player.transform.basis * Vector3(input_dir.x, input_dir.y, input_dir.y)).normalized()
	direction = direction.rotated(Vector3.UP, player.springArmPivot.rotation.y)
	direction.y = direction.y * (-1) * player.springArm.rotation.x
	
	if abs(direction.y) < DIVE_THRESHOLD:
		direction.y = 0
	
	if direction:
		player.velocity.x = direction.x * SPEED
		player.velocity.z = direction.z * SPEED
		player.velocity.y = direction.y * SPEED
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, SPEED)
		player.velocity.z = move_toward(player.velocity.z, 0, SPEED)
		player.velocity.y = move_toward(player.velocity.y, 0, SPEED)
	
	if Input.is_action_pressed("jump"):
		player.velocity.y = SPEED
	
	if not player.is_in_water():
		if player.is_on_floor():
			if direction:
				if get_parent().is_walking:
					return State.Walk
				else:
					return State.Run
			else:
				return State.Idle
		else:
			return State.Fall
		
	return State.Null
