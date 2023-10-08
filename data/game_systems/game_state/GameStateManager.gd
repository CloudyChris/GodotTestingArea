extends Node

var currentGameSave : GameSave = null

func save(save_path: String):
	currentGameSave.inventory = InventoryManager.save()
	
	var error = ResourceSaver.save(currentGameSave, save_path)
	if error != OK:
		push_error("An error occurred while saving the item prefab to disk.")

func load_save(save_path: String):
	if ResourceLoader.exists(save_path):
		currentGameSave = ResourceLoader.load(save_path, "GameSave")
		
		if currentGameSave:
			InventoryManager.load_save(currentGameSave)
