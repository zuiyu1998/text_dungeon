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

# 伤害数值
var damage: int = 0

# 伤害类型
var damage_type: Damage.DamageType = Damage.DamageType.Puncture

# 协调
var coordinate: int = 10

# 重击
var thump: int = 0

# 物理命中骰子
var thump_dice_options: Dice.DiceOption = Dice.DiceOption.new()

# 抗性
var resistance_map: Dictionary = {
	Damage.DamageType.Puncture: 100
}

func clone_resistance() -> Dictionary:
	return resistance_map.duplicate(true)

func get_option(option_name: String) -> int:
	if self[option_name]:
		return self[option_name]
	else:
		return 0

static func from_stats(_stats:Stats) -> BattleOptions:
	var options = BattleOptions.new()
	return options
