extends Node

var inventory : Inventory

var max_weight : int # TODO: when implementing stats, make this a function of strenght + a constant base carrying capacity

func _ready():
	pass

func init():
	pass

func add_item(aItem: Item, iSlotIndex: int = -1):
	inventory.add_item(aItem, iSlotIndex)

func move_item():
	pass

func remove_item():
	pass
	
func equip_item(iSlotIndex): # TODO: reconsider this
	pass
