@tool
class_name ItemDb
extends Resource

# do not modify this array by hand
@export var items_add_slot : PackedItem :
	set(new_item):
		if new_item and new_item.item_id:
			items[new_item.item_id.myUUID_stringified] = new_item
			print("Item \"" + new_item.item.item_name + "\" with UUID \"" + new_item.item_id.myUUID_stringified + "\" was successfully added to Item Database")
		items_add_slot = null

@export var items : Dictionary
			
func GetPackedItemByString(aUUIDString : String) -> Item:
	return items[aUUIDString]

func GetPackedItemByUUID(aUUID : UUID) -> Item:
	return GetPackedItemByString(aUUID.myUUID_stringified)

func _init():
	pass
