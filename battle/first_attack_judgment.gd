class_name FirstAttackJudgment

var first_attack = 0

static func from_battle_options(options: BattleOptions):
    var judgment = FirstAttackJudgment.new()
    judgment.first_attack = options.first_attack
    return judgment