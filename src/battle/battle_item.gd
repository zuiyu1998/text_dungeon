# 接口类
class_name BattleItem
extends RefCounted


func get_battle_option() -> BattleOptions:
	printerr("[BattleItem] get_battle_option not initialization")
	return


func get_first_attack_judgment() -> FirstAttackJudgment:
	return FirstAttackJudgment.from_battle_options(self.get_battle_option())


func destroy():
	printerr("[BattleItem] destroy not initialization")


func apply_battle_result(_res: BattleResult):
	printerr("[BattleItem] apply_battle_result not initialization")


func get_die() -> bool:
	printerr("[BattleItem] get_die not initialization")
	return false
