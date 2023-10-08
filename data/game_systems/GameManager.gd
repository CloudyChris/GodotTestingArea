extends Node

var game_data_path : String = "res://data/assets/game_data.tres"
var game_data : GameData

func _ready():
	game_data = ResourceLoader.load(game_data_path, "GameData")
