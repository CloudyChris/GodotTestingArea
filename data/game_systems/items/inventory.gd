class_name Inventory
extends Resource

@export var gen_UUID : bool = false :
	set(bFlag):
		if bFlag and not inventory_id:
			inventory_id = UUID.new()
			gen_UUID = true
		
@export var inventory_id : UUID
@export var items : Array[PackedItem] = []

func update_from_inventory(anInventory:Inventory):
	items = anInventory.items

func overwrite_from_inventory(anInventory:Inventory):
	inventory_id = anInventory.inventory_id
	items = anInventory.items

func update_from_array(aPackedItemArray:Array[PackedItem]):
	items = aPackedItemArray

func overwrite_manually(aUUID:UUID, aPackedItemArray:Array[PackedItem]):
	inventory_id = aUUID
	items = aPackedItemArray
