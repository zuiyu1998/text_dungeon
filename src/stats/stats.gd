class_name Stats

signal health_update

var _base_props: Props

var _props: Props = PropConst.get_default_props()
var _state: StatsState = StatsState.new()


static func new_stats():
	var new_stats = Stats.new()
	var props = Props.new()
	new_stats._base_props = props
	new_stats._base_props = Props.from_dic(props.to_dic())
	
	new_stats._on_bind()
	
	return new_stats

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
	
