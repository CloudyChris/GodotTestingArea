class_name ItemModifier
extends Resource

enum ModifierType {
	name, # whether an item can be named, and if it's named, the name given
	damage, # damage modifier (one type of damage per mod)
	durability, # decreased durability, increased durability, unbreakable
	weight, # heavier, lighter, weightless
	unique, # makes item unstackable (it's basically a flag)
	soulbound # cannot be lost or traded (it's basically a flag)
}

@export var modifier_type : ModifierType
