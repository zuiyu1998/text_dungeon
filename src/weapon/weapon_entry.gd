class_name WeaponEntry
extends Resource

@export var entry_id: int
@export var entry_name: String


func get_effct_builder() -> EffectBuilder:
	var builder = WeaponEntryEffectBuilder.new()
	return builder


class WeaponEntryEffectBuilder:
	extends EffectBuilder

	func build() -> EffectContext:
		var effct = EffectContext.new_effct()
		return effct
