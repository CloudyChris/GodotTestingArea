class_name ItemModifier
extends Resource

@export var mod_name : String = ""

@export var mod_physical_damage : float = 0
@export var mod_bleed_chance : float = 0 # % change to apply bleed status effect (health dot)
@export var mod_sick_change : float = 0 # % chance to apply sick status effect (heal reduction)
@export var mod_shock_chance : float = 0 # % chance to apply shock status effect (interrupt/ministun + dot)
@export var mod_fire_damage : float = 0
@export var mod_cold_damage : float = 0
@export var mod_electric_damage : float = 0
@export var mod_light_damage : float = 0
@export var mod_dark_damage : float = 0

@export var mod_durability : float = 0 # +/- % max durability
@export var mod_durability_recovery : float = 0 # +/- % durability / minute

@export var mod_weight : float = 1.0 # % of weight

@export var mod_unique : bool = false # if true, item is not stackable
@export var mod_soulbound : bool = false # if true, item is not tradable, cannot be stolen or lost

func compare_modifier(aModToCompare: ItemModifier) -> bool:
	if mod_name != aModToCompare.mod_name:
		return false
	if mod_physical_damage != aModToCompare.mod_physical_damage:
		return false
	if mod_bleed_chance != aModToCompare.mod_bleed_chance:
		return false
	if mod_sick_change != aModToCompare.mod_sick_change:
		return false
	if mod_shock_chance != aModToCompare.mod_shock_chance:
		return false
	if mod_fire_damage != aModToCompare.mod_fire_damage:
		return false
	if mod_cold_damage != aModToCompare.mod_cold_damage:
		return false
	if mod_electric_damage != aModToCompare.mod_electric_damage:
		return false
	if mod_light_damage != aModToCompare.mod_light_damage:
		return false
	if mod_dark_damage != aModToCompare.mod_dark_damage:
		return false
	if mod_durability != aModToCompare.mod_durability:
		return false
	if mod_durability_recovery != aModToCompare.mod_durability_recovery:
		return false
	if mod_weight != aModToCompare.mod_weight:
		return false
	if mod_unique != aModToCompare.mod_unique:
		return false
	if mod_soulbound != aModToCompare.mod_soulbound:
		return false
	
	return true
