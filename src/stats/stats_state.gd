class_name StatsState

signal health_update(cul_health: int)

# 血量
var health: int = 10

# 血量上限
var max_health: int = 10

func update_health(v: int):
	self.health += v
	self.health = mini(self.health, self.max_health)
	health_update.emit()
	pass
