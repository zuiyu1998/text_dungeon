class_name WeaponResource
extends Resource

# 随机伤害值
@export var damage_dice_options: Array[Dictionary] = []

# 伤害数值
@export var damage: int = 0

# 伤害类型
@export var damage_type: Damage.DamageType = Damage.DamageType.BLUNT

# 武器编号
@export var weapon_id: int

# 武器名称
@export var weapon_name: String

# 武器品阶
@export var weapon_level: WeaponTypes.WeaponLevel = WeaponTypes.WeaponLevel.WHITE


func get_weapon() -> Weapon:
	var weapon = Weapon.new()
	weapon.damage = damage
	weapon.damage_type = damage_type
	weapon.weapon_id = weapon_id
	weapon.weapon_name = weapon_name
	weapon.weapon_level = weapon_level

	return weapon
