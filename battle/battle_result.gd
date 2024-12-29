class_name BattleResult

var _hit_result: HitResult

static func new_battle_result(hit_result: HitResult) -> BattleResult:
    var res = BattleResult.new()
    res._hit_result = hit_result
    return res

func get_hit_result() -> HitResult:
    return _hit_result