class_name Tooltip
extends Node

@onready var weapon_popup_panel: WeaponPopupPanel = $WeaponPopupPanel


func show_weapon(position: Vector2, info: WeaponInfo):
	weapon_popup_panel.show_weapon(position, info)


func hide_weapon():
	weapon_popup_panel.hide()
