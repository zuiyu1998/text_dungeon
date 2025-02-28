class_name BattleStatsEffect extends StatsEffect

var _result: BattleResult


static func new_battle_stats_effect(result: BattleResult) -> BattleStatsEffect:
	var effct = BattleStatsEffect.new()
	effct._result = result
	return effct


func update(context: StatsContext):
	# 对伤害进行计算

	if not _result.is_active and _result.hit_result.hit:
		context.state.update_health(-_result.damage_result.damage)
