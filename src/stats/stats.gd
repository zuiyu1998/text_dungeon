class_name Stats
extends Node

signal health_update
signal die

var _base_props: Props = PropConst.get_default_props()

var _props: Props = PropConst.get_default_props()
var _state: StatsState = StatsState.new()


func _ready() -> void:
	_on_bind()


func destroy():
	die.emit()


# 获取状态
func get_die() -> bool:
	return _state.health <= 0


# 获取伤害
func get_damage() -> int:
	return _state.get_battle_source_state().damage


func get_health_progress() -> float:
	var progress = _state.health * 1.0 / _state.max_health
	return progress


func emit_health_update():
	health_update.emit()


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
