@tool
class_name ItemDb
extends Resource

# no suitable solution to guard against duplicates
# maybe we could do that in C++
# the issue is the difference in the items array is too complex to check for every time
# may attempt an in-engine solution saving a copy of items and checking for uuids
@export var items : Array[Item] :
	set(new_items):
		items = new_items
		for i in range(items.size()):
			if items[i] and items[i].item_id:
				item_UUIDs[items[i].item_id.as_string()] = i

@export_category("DO NOT MODIFY")
# format: UUID_string : items index
# exported for debugging reasons
# keys that point to nothing get deleted
@export var item_UUIDs : Dictionary :
	set(new_items):
		item_UUIDs = new_items
		for item in item_UUIDs.keys():
			if items[item_UUIDs[item]].item_id.as_string() != item:
				item_UUIDs.erase(item)
			
func GetItemByString(aUUIDString : String):
	return items[item_UUIDs[aUUIDString]]

func GetItemByUUID(aUUID : UUID):
	return GetItemByString(aUUID.as_string())
