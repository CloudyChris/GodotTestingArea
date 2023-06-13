@tool
class_name PackedItem
extends Resource

@export var item_id : int :
	set(new_id):
		item_id = new_id
		item.item_id = new_id
@export var item : Item :
	set(new_item):
		item = new_item
		item.item_id = item_id
@export var item_prefab : PackedScene
