class_name EffectContext
extends RefCounted

## 战斗相关
# 伤害数值
var damage: int = 0
# 伤害类型
var damage_type: Damage.DamageType

## 武器相关
# 物理伤害
var physic_damage: int = 0
# 魔法伤害
var magic_damage: int = 0
# 造成伤害的类型
var battle_damage_type: Damage.DamageType
# 随机伤害
var damage_dice_options: Array[Dice.DiceOption] = []

## 属性相关
var props: Dictionary = {}


func merge(context: EffectContext):
	# 战斗相关
	damage += context.damage
	if not context.damage_type:
		damage_type = context.damage_type
	# 武器相关
	physic_damage += context.physic_damage
	magic_damage += context.magic_damage
	damage_dice_options.append_array(context.damage_dice_options)


static func new_effct() -> EffectContext:
	var context = EffectContext.new()
	return context
