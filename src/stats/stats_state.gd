class_name StatsState

signal health_update(cul_health: int)

var physic_battle_source_state: BattleSourceState = BattleSourceState.new()
var magic_battle_source_state: BattleSourceState = BattleSourceState.new()

var damage_type: Damage.DamageType = Damage.DamageType.BLUNT

# 血量
var health: int = 20

# 血量上限
var max_health: int = 20


func get_battle_source_state() -> BattleSourceState:
	if Damage.is_physic(damage_type):
		return physic_battle_source_state
	return magic_battle_source_state


func update_health(v: int):
	self.health += v
	self.health = mini(self.health, self.max_health)
	health_update.emit()


class BattleSourceState:
	extends RefCounted
	var damage: int = 2
