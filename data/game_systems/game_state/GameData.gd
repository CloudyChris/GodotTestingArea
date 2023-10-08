@tool
class_name GameData
extends Resource

@export var gen_UUID : bool = false :
	set(bFlag):
		if bFlag and not game_data_id:
			game_data_id = UUID.new()
			gen_UUID = true
		elif not bFlag and not game_data_id:
			gen_UUID = bFlag
		else:
			pass
@export var game_data_id : UUID
@export var item_db_list : ItemDbList
@export var profile_list : Array[GameProfile] = []

func _init():
	pass
