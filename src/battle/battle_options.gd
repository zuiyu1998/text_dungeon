class_name BattleOptions

# 先攻
var first_attack: int = 0

# 闪避
var dodge: int = 10

# 护甲
var armor: int = 10

# 物理命中
var physical_hit: int = 0

# 物理命中骰子
var physical_hit_dice_options: Dice.DiceOption = Dice.DiceOption.new()

# 伤害来源
var damage_source: DamageSource = DamageSource.new()

# 协调
var coordinate: int = 10

# 重击
var thump: int = 0

var thump_magnification: int = 150

# 物理命中骰子
var thump_dice_options: Dice.DiceOption = Dice.DiceOption.new()

# 抗性
var resistance_map: Dictionary = {Damage.DamageType.PUNCTURE: 100}


func clone_resistance() -> Dictionary:
	return resistance_map.duplicate(true)


func get_option(option_name: String) -> int:
	if self[option_name]:
		return self[option_name]
	return 0


# 伤害来源
class DamageSource:
	extends RefCounted
	# 基础伤害数值
	var damage: int = 0

	# 伤害类型
	var damage_type: Damage.DamageType = Damage.DamageType.PUNCTURE

	# 随机伤害
	var damage_dices: Array[Dice] = []
