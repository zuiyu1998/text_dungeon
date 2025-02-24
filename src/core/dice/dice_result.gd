class_name DiceResult

enum DiceResultState {
	# 大成功
	GREAT_SUCCESS,
	# 大失败
	GREAT_FAIL,
	# 成功
	SUCCESS,
	# 失败
	FAIL,
	# 值
	NORMAL
}

var state: DiceResultState = DiceResultState.NORMAL

var number: int = 0


func check_ac(base: int, ac: int) -> bool:
	var res = false
	match state:
		DiceResultState.GREAT_SUCCESS:
			res = true
		DiceResultState.GREAT_FAIL:
			res = false
		DiceResultState.SUCCESS:
			res = true
		DiceResultState.FAIL:
			res = false
		DiceResultState.NORMAL:
			res = (number + base) >= ac

	return res
