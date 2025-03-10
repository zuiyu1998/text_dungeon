class_name Props

var physic_battle_source: BattleSource = BattleSource.new()
var magic_battle_source: BattleSource = BattleSource.new()
var damage_type: Damage.DamageType = Damage.DamageType.BLUNT

var data: Dictionary = {}
var _effcts: Dictionary = {}


func get_battle_source_state() -> BattleSource:
	if Damage.is_physic(damage_type):
		return physic_battle_source
	return magic_battle_source


func update_prop(prop_name: String, update: int):
	var effcts = _effcts.get(prop_name)
	if effcts:
		for effct in effcts:
			var effct_prop = get_prop(effct.effcted_prop_name)
			if effct_prop:
				effct_prop.update_value(effct.get_effct_value(update))


func get_prop(prop_name: String) -> Prop:
	return data[prop_name]


func set_effct(effct: PropEffect):
	var effcts = _effcts.get(effct.source_prop_name)
	if effcts:
		effcts.push_back(effct)
	else:
		_effcts[effct.source_prop_name] = [effct]


func set_prop(prop: Prop):
	data[prop.get_name()] = prop


func to_dic() -> Dictionary:
	var v = {}

	for prop: Prop in data.values():
		v[prop.get_name()] = prop.to_dic()

	return v


func from_dic(_dic: Dictionary) -> Props:
	var props = Props.new()
	return props


class BattleSource:
	extends RefCounted
	var damage: int = 0
