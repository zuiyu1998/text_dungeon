class_name Global
extends Node

signal player_die

@onready var player: Player = $Player


func on_player_die():
	print("on_player_die")
	player_die.emit()
