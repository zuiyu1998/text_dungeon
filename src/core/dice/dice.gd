class_name Dice

var _options: DiceOption

var _number_builder: NumberBuilder


func get_dice_result() -> DiceResult:
	var res = DiceResult.new()
	var num = _number_builder.build()
	res.number = num

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


static func new_dice_from_options(number_builder: NumberBuilder, options: DiceOption) -> Dice:
	var dice = Dice.new()
	dice._options = options
	dice._number_builder = number_builder

	return dice


static func new_dice(
	number_builder: NumberBuilder,
	max_count: int = 20,
	min_count: int = 1,
	max_offset: int = 0,
	min_offset: int = 0
) -> Dice:
	var options = DiceOption.new()
	options.max_count = max_count
	options.min_count = min_count
	options.max_offset = max_offset
	options.min_offset = min_offset

	return new_dice_from_options(number_builder, options)


class DiceOption:
	var max_count: int = 20
	var min_count: int = 1

	var max_offset: int = 0
	var min_offset: int = 0
