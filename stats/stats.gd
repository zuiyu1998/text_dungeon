class_name Stats

var _base_props: Props

var _props: Props

var _state: StatsState


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
	
