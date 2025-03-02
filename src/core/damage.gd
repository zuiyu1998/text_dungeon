class_name Damage

enum DamageType {
	# 穿刺
	PUNCTURE,
	# 钝击
	BLUNT,
	# 火
	FIRE
}


static func is_physic(damage_type: DamageType) -> bool:
	return damage_type in [DamageType.PUNCTURE, DamageType.BLUNT]


static func is_magic(damage_type: DamageType) -> bool:
	return damage_type in [DamageType.FIRE]
