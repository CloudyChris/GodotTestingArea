@tool
class_name ItemDb
extends Resource

@export var items : Array[PackedItem] :
	set(new_array):
		items = new_array
		for i in range(items.size()):
			if items[i]:
				items[i].item_id = i
