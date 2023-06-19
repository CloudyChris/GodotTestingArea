@tool
class_name Item
extends Resource

enum ItemType {
	Equipment, # can be equipped (gear: weapons, tools, armor, clothes, bracers, amulets, jewlery)
	Ingredient, # used in crafting (i.e: ore, bars, wood, basic versions of gear)
	Consumable, # can be consumed (i.e: potion, scroll, bandage)
	Usable, # can be used (i.e: torch, repair kit, puzzle piece)
	QuestItem, # quest item
	Trophy, # grant passive bonuses and remind you of the stuff you went through to get them
	Unknown # sometimes you're too dum dum to know what something is or what it's useful for
}

@export var gen_UUID : bool = false :
	set(bFlag):
		if bFlag and not item_id:
			item_id = UUID.new()
			if item_prefab:
				var tmp_item_prefab = item_prefab.instantiate()
				tmp_item_prefab.item_id = item_id
				var result = item_prefab.pack(tmp_item_prefab)
				if result == OK:
					var error = ResourceSaver.save(item_prefab, item_prefab.resource_path)
					if error != OK:
						push_error("An error occurred while saving the item prefab to disk.")
			gen_UUID = true
		
@export var item_id : UUID
@export var item_name : String = ""
@export var inventory_icon : CompressedTexture2D
@export var item_type : Array[ItemType] = []
@export var item_prefab : PackedScene :
	set(new_prefab):
		item_prefab = new_prefab
		var tmp_item_prefab = item_prefab.instantiate()
		tmp_item_prefab.item_id = item_id
		var result = item_prefab.pack(tmp_item_prefab)
		if result == OK:
			var error = ResourceSaver.save(item_prefab, item_prefab.resource_path)
			if error != OK:
				push_error("An error occurred while saving the item prefab to disk.")
@export var stackable : bool = false
# max stack 0 means infinite
@export var max_stack : int = 0
