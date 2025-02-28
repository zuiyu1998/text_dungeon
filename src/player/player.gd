class_name Player
extends Node

@onready var stats: Stats = $Stats


func get_character() -> Character:
	return PlayerCharacter.new_character(self)


class PlayerCharacter:
	extends Character
	var _player: Player

	static func new_character(player: Player) -> Character:
		var character = PlayerCharacter.new()
		character._player = player
		return character

	func get_stats() -> Stats:
		return _player.stats
