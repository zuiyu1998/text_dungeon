class_name BattleOptions

var first_attack: int = 0

func get_option(option_name: String) -> int:
    if self[option_name]:
        return self[option_name]
    else:
        return 0

static func from_stats(_stats:Stats) -> BattleOptions:
    var options = BattleOptions.new()
    return options