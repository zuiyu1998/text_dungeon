extends GutTest

func test_dice():
	var rand = RandomNumberGenerator.new()
	var dice := Dice.new_dice(rand)
	var res = dice.get_range_result()
	
	if res.check_success(10):
		if res.is_success():
			assert_eq(res.number, 20)
		else:
			assert_eq(res.number >= 10, true)
	else:
		if res.is_fail():
			assert_eq(res.number, 1)
		else:
			assert_eq(res.number < 10, true)
			
