class_name StatsBattleItem extends BattleItem

var _character: Character


static func new_stats_battle_item(character: Character) -> BattleItem:
	var stats_battle_item = StatsBattleItem.new()
	stats_battle_item._character = character
	return stats_battle_item


func get_battle_option() -> BattleOptions:
	var options = BattleOptions.new()
	options.damage = _character.get_stats().get_damage()
	return options


func get_first_attack_judgment() -> FirstAttackJudgment:
	return FirstAttackJudgment.from_battle_options(self.get_battle_option())


func destroy():
	print_debug("[PlayBattleItem] destroy")


func apply_battle_result(res: BattleResult):
	var effect = BattleStatsEffect.new_battle_stats_effect(res)
	_character.get_stats().apply_effcts([effect])


func get_die() -> bool:
	return self._character.get_stats().get_die()
