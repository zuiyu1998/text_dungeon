class_name RandNumberBuilder extends NumberBuilder

var rand: RandomNumberGenerator
var max_value: int = 20
var min_value: int = 1

func build() -> int:
	return rand.randi_range(min_value, max_value)
