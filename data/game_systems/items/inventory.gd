class_name Inventory
extends Resource

@export var gen_UUID : bool = false :
	set(bFlag):
		if bFlag and not inventory_id:
			inventory_id = UUID.new()
			gen_UUID = true
		
@export var inventory_id : UUID :
	set(aUUID):
		inventory_id = aUUID
		gen_UUID = true

@export var items : Array[InventorySlot] = []

var iWeight : float = 0

func _init():
	inventory_id = UUID.new()
	for i in range(32):
		items.append(InventorySlot.new())

func compute_weight():
	for slot in items:
		if slot.item:
			iWeight += slot.item.computed_item_weight

func find_first_empty_slot(search_start: int = 0) -> int:
	for slot in range(search_start, items.size()):
		if not items[slot].item:
			return slot
	return -1

func find_first_stack(aItem: Item, search_start: int = 0) -> int:
	for slot in range(search_start, items.size()):
		if items[slot].item.item_id == aItem.item_id and items[slot].item.item_modifier.compare_modifier(aItem.item_modifier):
			return slot
	
	return -1

func add_item(aItem: Item, search_start: int = 0) -> void:
	if aItem.bStackable:
		var target_slot : int = find_first_stack(aItem, search_start)
		if target_slot < 0:
			target_slot = find_first_empty_slot(search_start)
			if target_slot < 0:
				for i in range(8):
					items.append(InventorySlot.new())
				add_item(aItem, search_start)
			else:
				items[target_slot].item = aItem.duplicate(true)
		else:
			items[target_slot].item.item_count += aItem.item_count
	else:
		var target_slot = find_first_empty_slot(search_start)
		if target_slot < 0:
			for i in range(8):
				items.append(InventorySlot.new())
			add_item(aItem, search_start)
		else:
			items[target_slot].item = aItem.duplicate(true)
	
	compute_weight()

func add_item_array(aItemArray: Array[Item]):
	for item_to_add in aItemArray:
		add_item(item_to_add)

func move_item(iStartSlot: int, iTargetSlot: int) -> Item:
	var item_to_return : Item = null
	if iStartSlot > items.size() or iTargetSlot > items.size() or iStartSlot < 0 or iTargetSlot < 0:
		push_error("Move item called with slot indices out of bounds")
		return
	if items[iStartSlot].item:
		if items[iTargetSlot].item:
			item_to_return = items[iTargetSlot].item.duplicate(true)
		items[iTargetSlot].item = items[iStartSlot].item.duplicate(true)
		items[iStartSlot].item = null
	return item_to_return

func split_item(iStartSlot: int, iTargetSlot: int, iAmount: int) -> Item:
	var item_to_return : Item = null
	if iStartSlot > items.size() or iTargetSlot > items.size() or iStartSlot < 0 or iTargetSlot < 0:
		push_error("Split item called with slot indices out of bounds")
		return null
	if items[iStartSlot].item:
		if iAmount > items[iStartSlot].item.item_count:
			push_error("Split item called with iAmount bigger than item_count")
			return null
		elif iAmount == items[iStartSlot].item.item_count:
			if items[iTargetSlot].item:
				item_to_return = items[iTargetSlot].item.duplicate(true)
			items[iTargetSlot].item = items[iStartSlot].item.duplicate(true)
			items[iStartSlot].item = null
		else:
			if items[iTargetSlot].item:
				item_to_return = items[iTargetSlot].item.duplicate(true)
			items[iStartSlot].item.item_count -= iAmount
			items[iTargetSlot].item = items[iStartSlot].item.duplicate(true)
			items[iTargetSlot].item.item_count = iAmount
	return item_to_return

func remove_item(iTargetSlot: int, iAmount: int) -> Item:
	var item_to_remove : Item = null
	if items[iTargetSlot].item and iAmount > 0 and iAmount <= items[iTargetSlot].item.item_count:
		item_to_remove = items[iTargetSlot].item.duplicate(true)
		if iAmount == items[iTargetSlot].item.item_count:
			items[iTargetSlot].item = null
		else:
			item_to_remove.item_count = iAmount
			items[iTargetSlot].item.item_count -= iAmount
	else:
		push_error("Remove item called with empty target slot or iAmount bigger than item_count")
		return null
	return item_to_remove
