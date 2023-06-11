extends Node

@onready var states = {
	BaseState.State.Idle: $idle,
	BaseState.State.Walk: $walk,
	BaseState.State.Jump: $jump,
	BaseState.State.Fall: $fall,
	BaseState.State.Swim: $swim
}

var current_state : BaseState

func change_state(new_state: int) -> void:
	if current_state:
		current_state.exit()
	
	current_state = states[new_state]
	current_state.enter()

func init(player: Player) -> void:
	for child in get_children():
		child.player = player
	
	#maybe move default state to an exported variable
	change_state(BaseState.State.Idle)

func input(event: InputEvent) -> void:
	var new_state = current_state.input(event)
	if new_state != BaseState.State.Null:
		change_state(new_state)

func physics_process(delta: float) -> void:
	var new_state = current_state.physics_process(delta)
	if new_state != BaseState.State.Null:
		change_state(new_state)
