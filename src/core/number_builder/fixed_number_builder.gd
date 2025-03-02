class_name FixedNumberBuilder extends NumberBuilder

var value: int = 0


static func new_number_builder(value: int) -> FixedNumberBuilder:
	var number_builder = FixedNumberBuilder.new()
	number_builder.value = value
	return number_builder


func build() -> int:
	return value
