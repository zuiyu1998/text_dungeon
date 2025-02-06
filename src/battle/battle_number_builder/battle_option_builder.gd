class_name  BattleOptionBuilder extends BattleNumberBuilder

var _prop_name: String
var _options: BattleOptions

static func new_battle_option_builder(options: BattleOptions, prop_name: String) -> BattleOptionBuilder:
	var builder = BattleOptionBuilder.new()
	builder._options = options
	builder._prop_name = prop_name
	return builder

func get_number() -> int:
	return _options[_prop_name]
