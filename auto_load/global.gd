extends Node
class_name Global

@onready var player: Player = $Player

func _ready() -> void:
	player.stats._state.update_health(-5)
