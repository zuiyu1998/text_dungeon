class_name Player
extends Node

@onready var stats: Stats = $Stats
@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var stats_ui: StatsUi = $CanvasLayer/ColorRect/StatsUi


func _ready() -> void:
	stats_ui.update_ui(stats.get_state_info())


func get_character() -> Character:
	return PlayerCharacter.new_character(self)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("backpack"):
		canvas_layer.visible = !canvas_layer.visible


class PlayerCharacter:
	extends Character
	var _player: Player

	static func new_character(player: Player) -> Character:
		var character = PlayerCharacter.new()
		character._player = player
		return character

	func get_stats() -> Stats:
		return _player.stats
