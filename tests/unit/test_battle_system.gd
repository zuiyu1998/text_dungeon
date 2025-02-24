extends GutTest


func test_battle_effct():
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

	var stats = Stats.new()

	stats._base_props = Props.new()
	stats._props = Props.new()
	stats._state = StatsState.new()
	stats._state.max_health = 10
	stats._state.health = 10

	var effct = BattleStatsEffect.new_battle_stats_effect(battle_res)

	stats.apply_effcts([effct])

	assert_eq(stats._state.health, 2)


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


func test_battle_system():
	var battle_system = BattleSystem.new()
	var first_judgment = FirstAttackJudgment.new()
	first_judgment.first_attack = 10
	var first_item = BattleSystem.BattleItem.new()
	first_item.first_attack_judgment = first_judgment

	var second_judgment = FirstAttackJudgment.new()
	second_judgment.first_attack = 2
	var second_item = BattleSystem.BattleItem.new()
	second_item.first_attack_judgment = second_judgment

	battle_system.items.assign([first_item, second_item])
	battle_system._sort()

	assert_eq(battle_system.items[0].first_attack_judgment.first_attack, 10)
