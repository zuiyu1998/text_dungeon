extends CanvasLayer

@onready var health: TextureProgressBar = $Health

func on_health_update():
	var progress = GLOBAL.player.stats.get_health_progress()
	print(progress)
	health.value = progress
	pass

func _ready() -> void:
	on_health_update()
	GLOBAL.player.stats.health_update.connect(on_health_update)
