class_name BattleOptions

# 先攻
var first_attack: int = 0

# 闪避
var dodge: int = 10

# 护甲
var armor: int = 10

# 物理命中
var physical_hit: int = 0

func get_option(option_name: String) -> int:
    if self[option_name]:
        return self[option_name]
    else:
        return 0

static func from_stats(_stats:Stats) -> BattleOptions:
    var options = BattleOptions.new()
    return options