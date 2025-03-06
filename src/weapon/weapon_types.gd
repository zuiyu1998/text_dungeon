class_name WeaponTypes
extends RefCounted

enum WeaponLevel { WHITE = 0 }

const MAX_ENTRY_COUNTS = [1, 2, 3, 5, 8]


func get_max_entry_count() -> int:
	return MAX_ENTRY_COUNTS[self.weapon_level]
