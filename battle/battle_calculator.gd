class_name BattleCalculator

var hit_calculator: HitCalculator = HitCalculator.new()

static func get_armor(options: BattleOptions) -> int:
	var dodge = BattleOptionBuilder.new_battle_option_builder(options, "armor")
	
	var manager = BattleNumberManager.new()
	manager.data = [dodge]

	return manager.get_battle_number()


static func get_dodge(options: BattleOptions) -> int:
	var dodge = BattleOptionBuilder.new_battle_option_builder(options, "dodge")
	
	var manager = BattleNumberManager.new()
	manager.data = [dodge]

	return manager.get_battle_number()

static func get_hit(options: BattleOptions) -> int:
	var hit = BattleOptionBuilder.new_battle_option_builder(options, "hit")
	
	var manager = BattleNumberManager.new()
	manager.data = [hit]

	return manager.get_battle_number()

static func new_battle_calculator(active: BattleOptions, unactive: BattleOptions, number_builder: NumberBuilder) -> BattleCalculator:
	var calculator = BattleCalculator.new()
	var hit = BattleCalculator.get_hit(active)
	
	var dice = Dice.new_dice_from_options(number_builder, active.physical_hit_dice_options)

	calculator.hit_calculator.dodge_hit = hit
	calculator.hit_calculator.dodge = BattleCalculator.get_dodge(unactive)
	calculator.hit_calculator.armor = BattleCalculator.get_armor(unactive)
	calculator.dice = dice
	calculator.hit_calculator.armor_hit = hit

	return calculator

func get_result() -> BattleResult:
	
	var hit_res = hit_calculator.get_result()

	return BattleResult.new_battle_result(hit_res)
