extends Node

var inventory : Inventory = Inventory.new()

var base_max_weight : float = 100
var max_weight : float = base_max_weight

func save():
	return inventory.duplicate(true)

func load_save(save_file):
	inventory = save_file.inventory.duplicate(true)

func add_item(aItem: Item, search_start: int = 0) -> void:
	inventory.add_item(aItem, search_start)

func add_item_array(aItemArray: Array[Item]):
	inventory.add_item_array(aItemArray)
	
