@tool
class_name ItemDb
extends Resource

@export var items_create_update_queue : Array[PackedItem] :
	set(new_items):
		for new_item in new_items:
			if new_item and new_item.item_id:
				items[new_item.item_id.myUUID_stringified] = new_item
		items_create_update_queue = []

@export_category("DO NOT MODIFY")
# format: UUID_string : item
@export var items : Dictionary
			
func GetPackedItemByString(aUUIDString : String) -> Item:
	return items[aUUIDString]

func GetPackedItemByUUID(aUUID : UUID) -> Item:
	return GetPackedItemByString(aUUID.myUUID_stringified)

func _init():
	pass
