class_name GameSave
extends Resource

@export var inventory : Inventory :
	set(new_inventory):
		if inventory:
			inventory.overwrite_from_inventory(new_inventory)
		else:
			inventory.overwrite_inventory(new_inventory)
	
