class_name RangeResult

enum RangeResultState {
	GreatSuccess,
	Success,
	Fail,
	GreatFail,
	Normal,
}

var state: RangeResultState = RangeResultState.Fail
var number: int = 0

func check_success(ac: int) -> bool:
	if is_success():
		return true
	elif is_fail():
		return false
	elif number >= ac:
		return true
	else:
		return false

func is_great_fail() -> bool:
	if state == RangeResultState.GreatFail:
		return true
	else:
		return false

func is_great_success() -> bool:
	if state == RangeResultState.GreatSuccess:
		return true
	else:
		return false

func is_success() -> bool:
	if state == RangeResultState.Success or state == RangeResultState.GreatSuccess:
		return true
	else:
		return false

func is_fail() -> bool:
	if state == RangeResultState.Fail or state == RangeResultState.GreatFail:
		return true
	else:
		return false
