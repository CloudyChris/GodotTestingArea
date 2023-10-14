extends Area3D


func _ready():
	body_entered.connect(enable_interact_component)
	body_exited.connect(disable_interact_component)

func enable_interact_component(aInteractor : Node3D) -> void:
	aInteractor.interact_component.entered_interact_area()

func disable_interact_component(aInteractor : Node3D) -> void:
	aInteractor.interact_component.left_interact_area()

func _process(delta):
	pass
