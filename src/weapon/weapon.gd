class_name Weapon
extends Node

# 随机伤害值
var damage_dice_options: Array[Dice.DiceOption] = []

# 伤害数值
var damage: int = 0

# 伤害类型
var damage_type: Damage.DamageType = Damage.DamageType.BLUNT

# 武器编号
var weapon_id: int

# 武器名称
var weapon_name: String

# 武器品阶
var weapon_level: WeaponTypes.WeaponLevel = WeaponTypes.WeaponLevel.WHITE

# 词条
var entrys: Array[WeaponEntry] = []


func get_info() -> WeaponInfo:
	var info = WeaponInfo.new()
	info.weapon_id = weapon_id
	info.weapon_name = weapon_name
	return info


func get_weapon_effct() -> WeaponEffctBuilder:
	var builder = WeaponEffctBuilder.new()
	builder.damage = damage
	builder.damage_type = damage_type
	builder.damage_dice_options = damage_dice_options
	return builder


func get_effcts() -> Array[EffectBuilder]:
	var weapon_effect = get_weapon_effct()
	var entry_effcts = entrys.map(func(entry): return entry.get_effct_builder())

	var temp: Array[EffectBuilder] = [weapon_effect]
	temp.append_array(entry_effcts)

	return temp


class WeaponEffctBuilder:
	extends EffectBuilder
	# 随机伤害值
	var damage_dice_options: Array[Dice.DiceOption] = []

	# 伤害数值
	var damage: int = 0

	# 伤害类型
	var damage_type: Damage.DamageType = Damage.DamageType.BLUNT

	func build() -> EffectContext:
		var context = EffectContext.new_effct()
		context.damage_dice_options = damage_dice_options
		if Damage.is_physic(damage_type):
			context.physic_damage = damage
		else:
			context.magic_damage = damage
		context.damage_type = damage_type
		return context
