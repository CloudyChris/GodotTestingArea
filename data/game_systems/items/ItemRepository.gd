extends Node

var items : Dictionary

func _ready():
	for item_db in GameManager.game_data.item_db_list.item_db_list:
		items.merge(item_db.items, true)
