@tool
class_name ITileMap
extends Node2D

var tile_id_selected: int

var tile_slot_nodes: Dictionary = {}


func _ready() -> void:
	for child in get_children():
		if child is TileSlot:
			tile_slot_nodes[child.get_tile_id()] = child


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interaction"):
		on_interaction()


func on_interaction():
	if tile_id_selected == null:
		return

	var tile_slot_node: TileSlot = tile_slot_nodes.get(tile_id_selected)

	if tile_slot_node:
		tile_slot_node.on_interaction()


func set_select(tile_id: int):
	tile_id_selected = tile_id
