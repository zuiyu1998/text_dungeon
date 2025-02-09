class_name Stats

signal health_update

var _base_props: Props

var _props: Props 
var _state: StatsState = StatsState.new()

# 获取伤害
func get_damage() -> int:
	return 2

static func new_stats():
	var new_v = Stats.new()
	var props = PropConst.get_default_props()
	new_v._base_props = props
	new_v._props = PropConst.get_default_props()
	new_v._props.from_dic(props.to_dic())

	new_v._on_bind()
	
	return new_v

func get_health_progress() -> float:
	var progress = _state.health * 1.0 / _state.max_health
	return progress
	
func emit_health_update():
	health_update.emit()
	pass

func _on_bind():
	_state.health_update.connect(emit_health_update)

func _get_context() -> StatsContext:
	var context := StatsContext.new()
	var props := Props.new()
	props.from_dic(_base_props.to_dic())

	context.props = props
	context.state = _state
	return context

func _merge_context(context: StatsContext):
	self._props = context.props

func apply_effcts(effcts: Array[StatsEffect]):
	var context = _get_context()
	for effct in effcts:
		effct.update(context)
	_merge_context(context)
	
