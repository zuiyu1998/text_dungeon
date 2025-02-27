# 接口类
class_name BattleItem
extends RefCounted


func get_battle_option() -> BattleOptions:
	return


func get_first_attack_judgment() -> FirstAttackJudgment:
	return FirstAttackJudgment.from_battle_options(self.get_battle_option())


func destroy():
	pass


func apply_battle_result(_res: BattleResult):
	pass


func get_die() -> bool:
	return false
