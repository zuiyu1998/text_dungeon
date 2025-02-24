class_name RandNumberBuilder extends NumberBuilder

var _rand: RandomNumberGenerator
var _max_value: int = 20
var _min_value: int = 1


static func new_number_builder(
	rand: RandomNumberGenerator, max_value: int = 20, min_value: int = 1
) -> RandNumberBuilder:
	var number_builder = RandNumberBuilder.new()
	number_builder._rand = rand
	number_builder._max_value = max_value
	number_builder._min_value = min_value

	return number_builder


func build() -> int:
	return _rand.randi_range(_max_value, _min_value)
