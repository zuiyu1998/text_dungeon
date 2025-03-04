class_name StatsEffectExector extends EffectExector

var _stats: Stats


func apply(context: EffectContext):
	_stats._state.update_health(context.damage)


static func new_effct_exector(stats: Stats) -> EffectExector:
	var effct_exector = StatsEffectExector.new()
	effct_exector._stats = stats
	return effct_exector
