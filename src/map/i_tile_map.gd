@tool
class_name ITileMap
extends Node2D

var tile_id_selected: int
var tile_slot_nodes: Dictionary = {}
var check = false


func _ready() -> void:
	for child in get_children():
		if child is ITileSlot:
			tile_slot_nodes[child.get_tile_id()] = child


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interaction"):
		on_interaction()
	if event.is_action_pressed("check"):
		on_check()


func on_check():
	if tile_id_selected == null:
		return

	var tile_slot_node: ITileSlot = tile_slot_nodes.get(tile_id_selected)

	if tile_slot_node:
		check = !check
		tile_slot_node.on_show_ui(check)


func on_interaction():
	if tile_id_selected == null:
		return

	var tile_slot_node: ITileSlot = tile_slot_nodes.get(tile_id_selected)

	if tile_slot_node:
		tile_slot_node.on_interaction()


func set_select(tile_id: int):
	tile_id_selected = tile_id
