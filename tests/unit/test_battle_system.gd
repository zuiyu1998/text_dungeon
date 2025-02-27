extends GutTest


func test_battle_calculator():
	var first_options = BattleOptions.new()
	first_options.damage = 10

	var second_options = BattleOptions.new()

	second_options.resistance_map[first_options.damage_type] = 150

	var physical_hit_number_builder = FixedNumberBuilder.new_number_builder(11)
	var thump_number_builder = FixedNumberBuilder.new_number_builder(11)

	var battle_calculator = BattleCalculator.new_battle_calculator(
		first_options, second_options, physical_hit_number_builder, thump_number_builder
	)

	var battle_res = battle_calculator.get_result()

	assert_eq(battle_res.hit_result.hit, true)
	assert_eq(battle_res.damage_result.is_thump, true)
	assert_eq(battle_res.damage_result.thump_damage, 15)
	assert_eq(battle_res.damage_result.resistance_damage, 8)
	assert_eq(battle_res.damage_result.damage, 8)


func test_damage_calculator():
	var number_builder = FixedNumberBuilder.new_number_builder(11)
	var options = Dice.DiceOption.new()
	var dice = Dice.new_dice_from_options(number_builder, options)

	var damage_calculator = DamageCalculator.new()
	damage_calculator.damage = 10
	damage_calculator.thump_dice = dice

	damage_calculator.resistance_map[damage_calculator.damage_type] = 150
	var res = damage_calculator.get_damage_result()

	assert_eq(res.is_thump, true)
	assert_eq(res.thump_damage, 15)
	assert_eq(res.resistance_damage, 8)


func test_hit_calculator():
	var number_builder = FixedNumberBuilder.new_number_builder(10)
	var options = Dice.DiceOption.new()
	var dice = Dice.new_dice_from_options(number_builder, options)

	var hit_calculator = HitCalculator.new()
	hit_calculator.dice = dice

	hit_calculator.dodge_hit = 0
	hit_calculator.dodge = 10

	var res = hit_calculator.get_result()
	assert_eq(res.hit, true)
	assert_eq(res.dodge_success, false)

	hit_calculator.dodge = 11
	hit_calculator.armor_hit = 0
	hit_calculator.armor = 10

	res = hit_calculator.get_result()
	assert_eq(res.hit, true)
	assert_eq(res.armor_success, false)

	hit_calculator.armor = 11

	res = hit_calculator.get_result()
	assert_eq(res.hit, false)
	assert_eq(res.dodge_success, true)
	assert_eq(res.armor_success, true)


class TestBattleItem:
	extends BattleItem
	var options = BattleOptions.new()
	var count = 0

	func get_battle_option() -> BattleOptions:
		return options

	func get_first_attack_judgment() -> FirstAttackJudgment:
		return FirstAttackJudgment.from_battle_options(self.get_battle_option())

	func destroy():
		print("TestBattleItem destroy.")

	func apply_battle_result(_res: BattleResult):
		count += 1
		print("TestBattleItem apply_battle_result.")

	func get_die() -> bool:
		print("TestBattleItem get_die true.")
		return true


func test_battle_system():
	var first_item = TestBattleItem.new()
	first_item.options.first_attack = 10

	var second_item = TestBattleItem.new()
	second_item.options.first_attack = 2

	var battle_system = BattleSystem.new_battle_system([first_item, second_item])
	battle_system.start_battle()

	assert_eq(first_item.count, 1)
	assert_eq(second_item.count, 1)
