extends Node2D
class_name Enemy

@onready var body: Sprite2D = $Body
@onready var health_ui: HealthUi = $Body/PlayerUiRoot/HealthUi
@onready var player_ui_root: Control = $Body/PlayerUiRoot

var stats: Stats = Stats.new_stats()

func on_battle():
	var battle_system = BattleSystem.new_battle_system([GLOBAL.player.stats, stats])
	battle_system.start_battle()
	pass

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		on_battle()

func _ready() -> void:
	player_ui_root.size = body.texture.get_size()
	_on_bind()
	on_health_update()

func on_health_update():
	var progress = stats.get_health_progress()
	health_ui.update_health(progress)
	pass

func _on_bind():
	stats.health_update.connect(on_health_update)

func _process(delta: float) -> void:
	pass
