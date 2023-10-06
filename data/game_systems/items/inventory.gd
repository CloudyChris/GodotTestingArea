class_name Inventory
extends Resource

@export var gen_UUID : bool = false :
	set(bFlag):
		if bFlag and not inventory_id:
			inventory_id = UUID.new()
			gen_UUID = true
		
@export var inventory_id : UUID :
	set(aUUID):
		inventory_id = aUUID
		gen_UUID = true

@export var items : Array[Item] = []

var weight : int = 0

func _init():
	pass

func assign_new_UUID():
	inventory_id = UUID.new()

func replace(aUUID:UUID, aItemArray:Array[Item]):
	inventory_id = aUUID
	items = aItemArray

func create(aUUID:UUID, aItemArray:Array[Item]):
	var new_inventory : Inventory = Inventory.new()
	new_inventory.inventory_id = aUUID
	new_inventory.items = aItemArray
	return new_inventory
	
func create_new():
	var new_inventory : Inventory = Inventory.new()
	return new_inventory

func update_from_inventory(anInventory:Inventory): # loot all, pretty much
	items.append_array(anInventory.items) # TODO: should change this to a loop to properly stack and place all items
	compute_weight()

func overwrite_from_inventory(anInventory:Inventory):
	items = anInventory.items
	compute_weight()

func overwrite_inventory(anInventory:Inventory):
	inventory_id = anInventory.inventory_id
	items = anInventory.items
	compute_weight()

func update_from_array(aItemArray:Array[Item]): # loot all, pretty much, but with a list of items instead of an inventory (think multiple quest rewards)
	items.append_array(aItemArray) # TODO: should change this to a loop to properly stack and place all items
	compute_weight()

func overwrite_from_array(aItemArray:Array[Item]):
	items = aItemArray

func compute_weight():
	pass

func find_first_empty_slot():
	pass

func add_item(aItem: Item, iSlotIndex: int = -1):
	pass

func move_item():
	pass

func remove_item():
	pass
