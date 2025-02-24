class_name BattleStatsEffect extends StatsEffect

var _result: BattleResult

var _is_active: bool = false


static func new_battle_stats_effect(result: BattleResult, is_active = false) -> BattleStatsEffect:
	var effct = BattleStatsEffect.new()
	effct._is_active = is_active
	effct._result = result
	return effct


func set_active(active: bool):
	_is_active = active


func update(context: StatsContext):
	# 对伤害进行计算

	if not _is_active:
		if _result.hit_result.hit:
			context.state.update_health(-_result.damage_result.damage)
