class_name GameSave
extends Resource

@export var inventory : Inventory = null
	
func new_save():
	inventory = Inventory.new()
