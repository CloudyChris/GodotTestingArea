@tool
class_name PackedItem
extends Resource

@export var item_id : UUID
@export var item : Item :
	set(new_item):
		item = new_item
		if item:
			item_id = item.item_id
			if item_prefab:
				var tmp_item_prefab : ItemPrefab = item_prefab.instantiate()
				tmp_item_prefab.item = item.duplicate(true)
				tmp_item_prefab.item.set_local_to_scene(true)
				var result = item_prefab.pack(tmp_item_prefab)
				if result == OK:
					var error = ResourceSaver.save(item_prefab, item_prefab.resource_path)
					if error != OK:
						push_error("An error occurred while saving the item prefab to disk.")

@export var item_prefab : PackedScene :
	set(new_prefab):
		item_prefab = new_prefab
		if item and item_prefab:
			var tmp_item_prefab = item_prefab.instantiate()
			tmp_item_prefab.item = item.duplicate(true)
			tmp_item_prefab.item.set_local_to_scene(true)
			var result = item_prefab.pack(tmp_item_prefab)
			if result == OK:
				var error = ResourceSaver.save(item_prefab, item_prefab.resource_path)
				if error != OK:
					push_error("An error occurred while saving the item prefab to disk.")

func _init():
	pass
