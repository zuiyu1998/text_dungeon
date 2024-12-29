class_name BattleNumberManager

var data: Array[BattleNumberBuilder] = []

func sum(a: BattleNumberBuilder, b: BattleNumberBuilder):
    return a.get_number() + b.get_number()

func get_battle_number():
   return data.reduce(sum,0)