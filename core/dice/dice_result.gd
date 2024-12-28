class_name DiceResult

enum DiceResultState {
    # 大成功
    GreatSuccess,
    # 大失败
    GreatFail,
    # 成功
    Success,
    # 失败
    Fail,
    # 值
    Normal
}

var state: DiceResultState = DiceResultState.Normal

var number: int = 0

func check_ac(ac: int) -> bool:
    var res = false
    match state:
        DiceResultState.GreatSuccess:
            res = true
        DiceResultState.GreatFail:
            res = false
        DiceResultState.Success:
            res = true
        DiceResultState.Fail:
            res = false
        DiceResultState.Normal:
            res = number >= ac
    
    return res