class_name DamageCalculator

var damage_type: Damage.DamageType = Damage.DamageType.Puncture

var damage: int = 0

# 协调
var coordinate: int = 10

# 重击
var thump: int = 0

# 重击骰子
var thump_dice: Dice

# 重击倍率
var thump_magnification: int = 150

# 穿刺抗性
var resistance_map: Dictionary = {Damage.DamageType.Puncture: 100}


func get_damage_result() -> DamageResult:
	var damage_result := DamageResult.new()

	var tmp_damage = damage

	var dice_res = thump_dice.get_dice_result()

	damage_result.base_damage = damage

	if dice_res.check_ac(thump, coordinate):
		damage_result.is_thump = true
		damage_result.thump_damage = floori(
			(thump_magnification / 100.0) * damage_result.base_damage
		)
		tmp_damage = damage_result.thump_damage

	var resistance = 100

	if resistance_map.has(damage_type):
		resistance = resistance_map[damage_type]

	var resistance_value = abs(100 - resistance)
	var negative = -1 if 100 - resistance < 0 else 1

	var tmp_resistance_damage = floori((resistance_value / 100.0) * tmp_damage)

	tmp_damage = tmp_damage + tmp_resistance_damage * negative

	damage_result.resistance_damage = tmp_damage

	damage_result.damage = tmp_damage

	return damage_result
