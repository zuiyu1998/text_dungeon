class_name Dice

var _options: DiceOption

var _rand: RandomNumberGenerator


func get_range_result() -> DiceResult:
	var res = DiceResult.new()
	var rand_number_builder = RandNumberBuilder.new()
	rand_number_builder.rand = _rand
	rand_number_builder.max_value = _options.max_count
	rand_number_builder.min_value = _options.min_count
	var num = rand_number_builder.build()

	if num == _options.max_count:
		res.state = DiceResult.DiceResultState.GreatSuccess
	elif num == _options.min_count:
		res.state = DiceResult.DiceResultState.GreatFail
	elif (num + _options.max_offset) >= _options.max_count:
		res.state = DiceResult.DiceResultState.Success
	elif (num - _options.min_offset) <= _options.min_count:
		res.state = DiceResult.DiceResultState.Fail
	else:
		res.state = DiceResult.DiceResultState.Normal
	return res

static func new_dice(rand: RandomNumberGenerator, max_count: int = 20, min_count: int = 1, max_offset: int = 0, min_offset: int = 0) -> Dice:
	var dice = Dice.new()
	var options = DiceOption.new()
	options.max_count = max_count
	options.min_count = min_count
	options.max_offset = max_offset
	options.min_offset = min_offset

	dice._rand = rand
	dice._options = options

	return dice

class DiceOption:
	var max_count: int = 20
	var min_count: int = 1

	var max_offset: int = 0
	var min_offset: int = 0
