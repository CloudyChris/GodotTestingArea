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

@export var item_id : int
@export var item_name : String = ""
@export var inventory_icon : CompressedTexture2D
@export var item_type : Array[ItemType] = []

@export var stackable : bool = false
# max stack 0 means infinite
@export var max_stack : int = 0
