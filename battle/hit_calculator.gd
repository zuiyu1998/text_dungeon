
class_name HitCalculator

var dodge: int
var dodge_hit: int

var armor: int
var armor_hit: int


func get_result() -> HitResult:
    var res = HitResult.new()

    if dodge_hit >= dodge:
        res.hit = true
        res.dodge_success = false
    else:
        res.hit = false
        res.dodge_success = true

    if res.hit == false:
        if armor_hit >= armor:
            res.hit = true
            res.armor_success = false
        else:
            res.hit = false
            res.armor_success = true

    return res