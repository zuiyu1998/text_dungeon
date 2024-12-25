extends GutTest

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
	
