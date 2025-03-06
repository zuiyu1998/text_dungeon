class_name StatsEffectExector extends EffectExector

var _stats: Stats


func apply(context: EffectContext):
	_stats._state.update_health(context.damage)

	## 武器影响

	_stats._props.physic_battle_source.damage = (
		_stats._base_props.physic_battle_source.damage + context.physic_damage
	)
	_stats._props.magic_battle_source.damage = (
		_stats._base_props.magic_battle_source.damage + context.magic_damage
	)
	if not context.damage_type:
		_stats._props.damage_type = context.damage_type


static func new_effct_exector(stats: Stats) -> EffectExector:
	var effct_exector = StatsEffectExector.new()
	effct_exector._stats = stats
	return effct_exector
