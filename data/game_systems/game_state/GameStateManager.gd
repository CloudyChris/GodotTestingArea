extends Node

func save(save_path: String):
	var newGameSave : GameSave = GameSave.new()
	newGameSave.inventory = InventoryManager.save()
	
	var error = ResourceSaver.save(newGameSave, save_path)
	if error != OK:
		push_error("An error occurred while saving the item prefab to disk.")

func load_save(save_path: String):
	if ResourceLoader.exists(save_path):
		# TODO: update to multi-threaded at your earliest convenience
		var loadedGameSave : GameSave = ResourceLoader.load(save_path, "GameSave")
		
		if loadedGameSave:
			InventoryManager.load_save(loadedGameSave)
