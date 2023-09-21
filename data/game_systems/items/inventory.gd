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

@export var items : Array[PackedItem] = []

func _init():
	inventory_id = UUID.new()

func replace(aUUID:UUID, aPackedItemArray:Array[PackedItem]):
	inventory_id = aUUID
	items = aPackedItemArray

func create(aUUID:UUID, aPackedItemArray:Array[PackedItem]):
	var new_inventory : Inventory
	new_inventory.inventory_id = aUUID
	new_inventory.items = aPackedItemArray
	return new_inventory
	
func create_new():
	var new_inventory : Inventory = Inventory.new()
	return new_inventory

func update_from_inventory(anInventory:Inventory):
	items.append_array(anInventory.items)

func overwrite_from_inventory(anInventory:Inventory):
	items = anInventory.items

func overwrite_inventory(anInventory:Inventory):
	inventory_id = anInventory.inventory_id
	items = anInventory.items

func update_from_array(aPackedItemArray:Array[PackedItem]):
	items.append_array(aPackedItemArray)

func overwrite_from_array(aPackedItemArray:Array[PackedItem]):
	items = aPackedItemArray


