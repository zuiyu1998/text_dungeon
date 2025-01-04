class_name BattleCalculator

var hit_calculator: HitCalculator = HitCalculator.new()
var damage_calculator: DamageCalculator = DamageCalculator.new()

static func get_armor(options: BattleOptions) -> int:
	var dodge = BattleOptionBuilder.new_battle_option_builder(options, "armor")
	
	var manager = BattleNumberManager.new()
	manager.data = [dodge]

	return manager.get_battle_number()

static func get_damage(options: BattleOptions) -> int:
	var damage = BattleOptionBuilder.new_battle_option_builder(options, "damage")
	
	var manager = BattleNumberManager.new()
	manager.data = [damage]

	return manager.get_battle_number()

static func get_coordinate(options: BattleOptions) -> int:
	var damage = BattleOptionBuilder.new_battle_option_builder(options, "coordinate")
	
	var manager = BattleNumberManager.new()
	manager.data = [damage]

	return manager.get_battle_number()

static func get_thump(options: BattleOptions) -> int:
	var damage = BattleOptionBuilder.new_battle_option_builder(options, "thump")
	
	var manager = BattleNumberManager.new()
	manager.data = [damage]

	return manager.get_battle_number()

static func get_thump_magnification(options: BattleOptions) -> int:
	var damage = BattleOptionBuilder.new_battle_option_builder(options, "thump_magnification")
	
	var manager = BattleNumberManager.new()
	manager.data = [damage]

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
	var thump_dice = Dice.new_dice_from_options(number_builder, active.thump_dice_options)

	calculator.hit_calculator.dodge_hit = hit
	calculator.hit_calculator.dodge = BattleCalculator.get_dodge(unactive)
	calculator.hit_calculator.armor = BattleCalculator.get_armor(unactive)
	calculator.dice = dice
	calculator.hit_calculator.armor_hit = hit

	calculator.damage_calculator.damage = BattleCalculator.get_damage(active)
	calculator.damage_calculator.damage_type = active.damage_type
	calculator.damage_calculator.coordinate = BattleCalculator.get_coordinate(unactive)
	calculator.damage_calculator.thump = BattleCalculator.get_thump(active)
	calculator.damage_calculator.thump_dice = thump_dice
	calculator.damage_calculator.thump_magnification = BattleCalculator.get_thump_magnification(active)
	calculator.damage_calculator.resistance_map = unactive.clone_resistance()

	return calculator

func get_result() -> BattleResult:
	var res = BattleResult.new()
	var hit_res = hit_calculator.get_result()
	
	if hit_res.hit:
		res.damage_result = damage_calculator.get_damage_result()

	res.hit_result = hit_res
	return res
