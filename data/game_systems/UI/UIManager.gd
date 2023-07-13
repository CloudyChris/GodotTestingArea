extends Node

var player : Player

var can_interact : bool = false

func register_player(aPlayer : Player):
	player = aPlayer
	player.interact_area.body_entered.connect(enable_interact_component)
	player.interact_area.body_exited.connect(disable_interact_component)

func unregister_player():
	player.interact_area.body_entered.disconnect(enable_interact_component)
	player.interact_area.body_exited.disconnect(disable_interact_component)
	player = null
	
func enable_interact_component(aInteractor : Node3D) -> void:
	aInteractor.interact_component.entered_interact_area()

func disable_interact_component(aInteractor : Node3D) -> void:
	aInteractor.interact_component.left_interact_area()
