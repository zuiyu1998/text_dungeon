class_name BattleSystem

var items: Array[BattleItem]
var active_item_index = 0
var unactive_item_index = 1

func get_battle_calculator_result(active: BattleItem, unactive: BattleItem, rand: RandomNumberGenerator) -> BattleResult:
	var battle_calculator = BattleCalculator.new_battle_calculator_from_rand(active.options, unactive.options, rand)
	return battle_calculator.get_result()


func start_battle():
	var rand := RandomNumberGenerator.new()
	var active_item: BattleItem = items[active_item_index]
	var unactive_item: BattleItem = items[unactive_item_index]

	var battle_res = get_battle_calculator_result(active_item, unactive_item, rand)

	print_debug(battle_res.hit_result.hit)
	print_debug(battle_res.damage_result.damage)

	var effct = BattleStatsEffect.new_battle_stats_effect(battle_res)

	unactive_item.stats.apply_effcts([effct])

	pass


func _sort():
	items.sort_custom(func(a: BattleItem, b: BattleItem): return a.first_attack_judgment.first_attack > b.first_attack_judgment.first_attack)


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
