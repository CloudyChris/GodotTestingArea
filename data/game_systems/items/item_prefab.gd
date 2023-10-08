class_name ItemPrefab
extends PhysicsBody3D

@export var item : Item

func pick_up() -> void:
	print(item.item_id.as_string(), " ", item.item_name)
	InventoryManager.add_item(item)
	queue_free()

func interact():
	pick_up()
