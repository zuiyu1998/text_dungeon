class_name Dice extends RangeBuilder

var _options: DiceOption

var _rand: RandomNumberGenerator


func get_range_result() -> RangeResult:
	var res = RangeResult.new()
	var num = _rand.randf_range(_options.min_count, _options.max_count)

	res.number = num

	if num == _options.max_count:
		res.state = RangeResult.RangeResultState.GreatSuccess
	elif num == _options.min_count:
		res.state = RangeResult.RangeResultState.GreatFail
	elif (num + _options.max_offset) >= _options.max_count:
		res.state = RangeResult.RangeResultState.Success
	elif (num - _options.min_offset) <= _options.min_count:
		res.state = RangeResult.RangeResultState.Fail
	else:
		res.state = RangeResult.RangeResultState.Normal
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
