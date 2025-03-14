@tool
class_name ITileSlot
extends Area2D

@export var tile_map: ITileMap

var tile_interface: Node2D


func _ready() -> void:
	# refactor 如何精准的获取tile_interface
	tile_interface = get_child(1)


func on_show_ui(v: bool):
	if not tile_interface:
		return
	if tile_interface.has_method("on_show_ui"):
		tile_interface.on_show_ui(v)


func on_interaction():
	if not tile_interface:
		return
	if tile_interface.has_method("on_interaction"):
		tile_interface.on_interaction()


func get_tile_id() -> int:
	return get_instance_id()


func _input_event(_viewport: Viewport, _event: InputEvent, _shape_idx: int) -> void:
	if not tile_map:
		return

	tile_map.set_select(get_tile_id())
