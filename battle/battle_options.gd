class_name BattleOptions

var first_attack: int = 0

static func from_stats(_stats:Stats) -> BattleOptions:
    var options = BattleOptions.new()
    return options