extends Node
class_name Global

signal player_die

@onready var player: Player = $Player

func on_player_die():
	print("on_player_die")
	player_die.emit()

func _ready() -> void:
	player.stats._state.update_health(-5)
	player.stats.die.connect(on_player_die)
