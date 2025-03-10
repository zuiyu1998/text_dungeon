class_name WeaponUi
extends TextureRect

var _info: WeaponInfo

@onready var weapon_name: Label = $VBoxContainer/WeaponName


func update_ui(info: WeaponInfo):
	weapon_name.text = info.weapon_name
	_info = info
