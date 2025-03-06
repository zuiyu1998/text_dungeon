class_name WeaponConsts
extends RefCounted

const FIST: WeaponResource = preload("res://src/weapon/resources/fist.tres")


static func get_default_weapon() -> Weapon:
	return FIST.get_weapon()
