class_name Enemy
extends Node2D

@onready var body: Sprite2D = $Body
@onready var player_ui_root: Control = $Body/PlayerUiRoot
@onready var health_ui: HealthUi = $Body/PlayerUiRoot/HealthUi
@onready var stats: Stats = $Stats
@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var stats_ui: StatsUi = $CanvasLayer/ColorRect/StatsUi


func get_character() -> Character:
	return EnemyCharacter.new_character(self)


func _input(event: InputEvent) -> void:
	if canvas_layer.visible and event.is_action_pressed("check"):
		canvas_layer.visible = false


func on_show_ui(v: bool):
	canvas_layer.visible = v


func on_interaction():
	print("battle start")
	var player_battle_item = StatsBattleItem.new_stats_battle_item(GLOBAL.player.get_character())
	var enemy_battle_item = StatsBattleItem.new_stats_battle_item(get_character())

	var battle_system = BattleSystem.new_battle_system([player_battle_item, enemy_battle_item])
	battle_system.start_battle()


func _ready() -> void:
	player_ui_root.size = body.texture.get_size()
	var info = stats.get_state_info()
	stats_ui.update_ui(info)
	_on_bind()
	on_health_update()


func on_health_update():
	var progress = stats.get_health_progress()
	health_ui.update_health(progress)


func on_die():
	print("on die")


func _on_bind():
	stats.health_update.connect(on_health_update)
	stats.die.connect(on_die)


class EnemyCharacter:
	extends Character
	var _enemy: Enemy

	static func new_character(enemy: Enemy) -> Character:
		var character = EnemyCharacter.new()
		character._enemy = enemy
		return character

	func get_stats() -> Stats:
		return _enemy.stats
