class_name WeaponPopupPanel
extends PopupPanel

@onready var weapon_name: Label = $VBoxContainer/WeaponName


func show_weapon(mouse_position: Vector2, info: WeaponInfo):
	update_weapon_info(info)
	position = mouse_position
	show()


func update_weapon_info(info: WeaponInfo):
	weapon_name.text = info.weapon_name
