class_name EffectContext
extends RefCounted

# 伤害数值
var damage: int = 0
# 伤害类型
var damage_type: Damage.DamageType = Damage.DamageType.BLUNT


static func new_effct() -> EffectContext:
	var context = EffectContext.new()
	return context
