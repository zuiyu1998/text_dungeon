class_name BattleSystem

var items: Array[BattleItem]
var active_item_index = 0
var unactive_item_index = 1

func get_battle_calculator(active: BattleItem, unactive: BattleItem, rand: RandomNumberGenerator) -> BattleCalculator:
	var number_builder = RandNumberBuilder.new_number_builder(rand, active.options.physical_hit_dice_options.max_count, active.options.physical_hit_dice_options.min_count);
	return BattleCalculator.new_battle_calculator(active.options, unactive.options, number_builder)

func start_battle():
	var rand := RandomNumberGenerator.new()
	var active_item: BattleItem = items[active_item_index]
	var unactive_item: BattleItem = items[unactive_item_index]

	var battle_calculator = get_battle_calculator(active_item, unactive_item, rand)
	
	var _battle_res = battle_calculator.get_result()

	pass


func _sort():
	items.sort_custom(func(a: BattleItem, b: BattleItem): return a.first_attack_judgment.first_attack > b.first_attack_judgment.first_attack)


static func new_battle_system(stats: Array[Stats]) -> BattleSystem:
	var battle_system = BattleSystem.new()
	battle_system.items = stats.map(new_battle_item)
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
