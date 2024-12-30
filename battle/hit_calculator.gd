class_name HitCalculator

var dodge: int
var dodge_hit: int

var armor: int
var armor_hit: int

var dice: Dice

func get_result() -> HitResult:
	var res = HitResult.new()
	set_dodage(res)

	if res.hit == false:
		set_armor(res)
	return res

func set_dodage(result: HitResult):
	var dice_res = dice.get_dice_result()
	if dice_res.check_ac(dodge_hit, dodge):
		result.hit = true
		result.dodge_success = false

func set_armor(result: HitResult):
   
	var dice_res = dice.get_dice_result()
	if dice_res.check_ac(armor_hit, armor):
		result.hit = true
		result.armor_success = false
