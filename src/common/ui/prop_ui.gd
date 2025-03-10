class_name PropUi
extends HBoxContainer

@onready var prop_label: Label = $PropLabel
@onready var prop_value: Label = $PropValue


func update_prop(label: String, value: int):
	prop_label.text = label
	prop_value.text = str(value)
