class_name PropEffect
extends Resource

@export var source_prop_name: String
@export var effct: float = 1.0
@export var effcted_prop_name: String


func get_effct_value(update: int) -> float:
	return update * effct
