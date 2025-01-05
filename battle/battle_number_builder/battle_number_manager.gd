class_name BattleNumberManager

var data: Array[BattleNumberBuilder] = []

func get_battle_number():
	return data.map(func (item): return item.get_number()).reduce(func (a, b): return a + b, 0)
