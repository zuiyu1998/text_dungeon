class_name PropResource
extends Resource

@export var prop_name: String

@export var value: float

@export var max_value: float

@export var min_value: float

@export var max_limit: float

@export var min_limit: float

@export var effcts: Array[PropEffect] = []


func into_prop() -> Prop:
	var prop = Prop.new()
	prop._prop_name = prop_name
	prop._value = value
	prop._max_value = max_value
	prop._min_value = min_value
	prop._max_limit = max_limit
	prop._min_limit = min_limit
	return prop
