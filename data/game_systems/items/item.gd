class_name Item
extends Resource

enum ItemType {
	Equipment, # can be equipped (gear: weapons, tools, armor, clothes, bracers, amulets, jewlery)
	Ingredient, # used in crafting (i.e: ore, bars, wood, basic versions of gear)
	Consumable, # can be consumed (i.e: potion, scroll, bandage)
	Usable, # can be used (i.e: torch, repair kit, puzzle piece)
	QuestItem, # quest item
	Trophy, # grant passive bonuses and remind you of the stuff you went through to get them
	Loot, # a special item that drops from defeated enemies that looks like a bag. It has a special interaction color (gold)
	Unknown # sometimes you're too dum dum to know what something is or what it's useful for
}

@export var gen_UUID : bool = false :
	set(bFlag):
		if bFlag and not item_id:
			item_id = UUID.new()
			gen_UUID = true
		elif not bFlag and not item_id:
			gen_UUID = bFlag
		else:
			pass

@export var item_id : UUID
@export var item_name : String = ""
@export var inventory_icon : CompressedTexture2D
@export var item_type : Array[ItemType] = []
@export var item_weight : float = 0.1 :
	set(new_item_weight):
		item_weight = new_item_weight
		computed_item_weight = compute_weight()

@export var computed_item_weight : float = 0.1

@export var bModifiable : bool = true
@export var item_modifier : ItemModifier = ItemModifier.new()

@export var bStackable : bool = false
@export var item_count : int = 1

func _init():
	pass

func compute_weight():
	if bModifiable:
		if item_modifier:
			return item_weight * item_modifier.mod_weight
		else:
			return item_weight
	else:
		return item_weight
