extends GutTest

func test_hit_calculator():
	var hit_calculator = HitCalculator.new()
	hit_calculator.dodge_hit = 10
	hit_calculator.dodge = 0
	
	var res = hit_calculator.get_result()
	assert_eq(res.hit, true)
	assert_eq(res.dodge_success, false)
	
	hit_calculator.dodge = 11
	hit_calculator.armor_hit = 10
	hit_calculator.armor = 0
	
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
	
