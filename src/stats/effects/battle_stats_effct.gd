class_name BattleStatsEffect extends EffectBuilder

var _result: BattleResult


static func new_battle_stats_effect(result: BattleResult) -> BattleStatsEffect:
	var effct = BattleStatsEffect.new()
	effct._result = result
	return effct


func build() -> EffectContext:
	var context = EffectContext.new_effct()

	if not _result.is_active and _result.hit_result.hit:
		context.damage = -_result.damage_result.damage
		context.damage_type = _result.damage_result.damage_type

	return context
