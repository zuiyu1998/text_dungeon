class_name WeaponUi
extends TextureRect

var _info: WeaponInfo

@onready var weapon_name: Label = $VBoxContainer/WeaponName


func update_ui(info: WeaponInfo):
	weapon_name.text = info.weapon_name
	_info = info


func _on_mouse_entered() -> void:
	TOOLTIP.show_weapon(get_global_mouse_position(), _info)


func _on_mouse_exited() -> void:
	TOOLTIP.hide_weapon()
