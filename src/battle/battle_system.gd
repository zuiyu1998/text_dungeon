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

	var effct = BattleStatsEffect.new_battle_stats_effect(battle_res)
	unactive_item.stats.apply_effcts([effct])

	effct.set_active(true)
	active_item.stats.apply_effcts([effct])


func start_battle():
	var rand := RandomNumberGenerator.new()

	var active_item: BattleItem = items[active_item_index]
	var unactive_item: BattleItem = items[unactive_item_index]

	_start_current_battle(rand, active_item, unactive_item)

	if unactive_item.stats.get_die():
		unactive_item.stats.destroy()
		return

	if active_item.stats.get_die():
		active_item.stats.destroy()
		return

	active_item_index = 1
	unactive_item_index = 0

	active_item = items[active_item_index]
	unactive_item = items[unactive_item_index]

	_start_current_battle(rand, active_item, unactive_item)

	if unactive_item.stats.get_die():
		unactive_item.stats.destroy()
		return

	if active_item.stats.get_die():
		active_item.stats.destroy()
		return


func _sort():
	items.sort_custom(
		func(a: BattleItem, b: BattleItem):
			return a.first_attack_judgment.first_attack > b.first_attack_judgment.first_attack
	)


static func new_battle_system(stats: Array[Stats]) -> BattleSystem:
	var battle_system = BattleSystem.new()
	battle_system.items.assign(stats.map(new_battle_item))
	battle_system._sort()

	return battle_system


static func new_battle_item(stats: Stats) -> BattleItem:
	var item = BattleItem.new()
	item.stats = stats
	item.options = BattleOptions.from_stats(stats)
	item.first_attack_judgment = FirstAttackJudgment.from_battle_options(item.options)

	return item


class BattleItem:
	var options: BattleOptions
	var stats: Stats
	var first_attack_judgment: FirstAttackJudgment
