@tool
class_name ItemDb
extends Resource

@export var gen_UUID : bool = false :
	set(bFlag):
		if bFlag and not item_db_id:
			item_db_id = UUID.new()
			gen_UUID = true
		elif not bFlag and not item_db_id:
			gen_UUID = bFlag
		else:
			pass
@export var item_db_id : UUID
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
