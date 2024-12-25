class_name Prop

var _prop_name: String

var _value: float = 0.0

var _max_value: float = 0.0

var _min_value: float = 0.0

var _max_limit: float = 0.0

var _min_limit: float = 0.0

static func new_prop(prop_name: String, value: float, max_value: float = 100, min_value: float = -100, max_limit: float = 1000, min_limit: float = -1000) -> Prop:
	var prop = Prop.new()
	prop._value = value
	prop._max_value = max_value
	prop._min_value = min_value
	prop._max_limit = max_limit
	prop._min_limit = min_limit
	prop._prop_name = prop_name
	return prop

func get_name() -> String:
	return _prop_name

func set_value(v: float):
	_value = v

func get_value() -> int:
	var max_tmp = minf(_max_limit, _max_value)
	var min_tmp = maxf(_min_limit, _min_value)

	var value_tmp = floorf(clampf(_value, min_tmp, max_tmp))
	return int(value_tmp)
