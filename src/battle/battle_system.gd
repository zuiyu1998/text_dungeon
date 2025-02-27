class_name BattleSystem

var items: Array[BattleItem]
var active_item_index = 0
var unactive_item_index = 1


func get_battle_calculator_result(
	active: BattleItem, unactive: BattleItem, rand: RandomNumberGenerator
) -> BattleResult:
	var battle_calculator = BattleCalculator.new_battle_calculator_from_rand(
		active.options, unactive.options, rand
	)
	return battle_calculator.get_result()


func _start_current_battle(
	rand: RandomNumberGenerator, active_item: BattleItem, unactive_item: BattleItem
):
	var battle_res = get_battle_calculator_result(active_item, unactive_item, rand)
	unactive_item.apply_battle_result(battle_res)
	active_item.apply_battle_result(battle_res)


func start_battle():
	var rand := RandomNumberGenerator.new()

	var active_item: BattleItem = items[active_item_index]
	var unactive_item: BattleItem = items[unactive_item_index]

	_start_current_battle(rand, active_item, unactive_item)

	if unactive_item.get_die():
		unactive_item.destroy()
		return

	if active_item.get_die():
		active_item.destroy()
		return

	active_item_index = 1
	unactive_item_index = 0

	active_item = items[active_item_index]
	unactive_item = items[unactive_item_index]

	_start_current_battle(rand, active_item, unactive_item)

	if unactive_item.get_die():
		unactive_item.destroy()
		return

	if active_item.get_die():
		active_item.destroy()
		return


func _sort():
	items.sort_custom(
		func(a: BattleItem, b: BattleItem):
			return (
				a.get_first_attack_judgment().first_attack
				> b.get_first_attack_judgment().first_attack
			)
	)


static func new_battle_system(new_battle_items: Array[BattleItem]) -> BattleSystem:
	var battle_system = BattleSystem.new()
	battle_system.items.assign(new_battle_items)
	battle_system._sort()

	return battle_system
