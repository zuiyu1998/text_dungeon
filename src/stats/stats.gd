class_name Stats
extends Node

signal health_update
signal die

var _base_props: Props = PropConst.get_default_props()

var _props: Props = PropConst.get_default_props()
var _state: StatsState = StatsState.new()


func get_effct_exector() -> EffectExector:
	return StatsEffectExector.new_effct_exector(self)


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
