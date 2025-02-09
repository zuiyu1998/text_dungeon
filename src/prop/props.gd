class_name Props

var _data: Dictionary = {}

var _effcts: Dictionary = {}

func update_prop(prop_name: String, update: int):
	var effcts = _effcts.get(prop_name)
	if effcts:
		for effct in effcts:
			var effct_prop = get_prop(effct.effcted_prop_name)
			if effct_prop:
				effct_prop.update_value(effct.get_effct_value(update))

func get_prop(prop_name: String) -> Prop:
	return _data[prop_name]

func set_effct(effct: PropEffect):
	var effcts = _effcts.get(effct.source_prop_name)
	if effcts:
		effcts.push_back(effct)
	else:
		_effcts[effct.source_prop_name] = [effct]

func set_prop(prop: Prop):
	_data[prop.get_name()] = prop

func to_dic() -> Dictionary:
	var v = {}
	
	for prop: Prop in _data.values():
		v[prop.get_name()] = prop.to_dic()
	
	return v

func from_dic(_dic: Dictionary) -> Props:
	var props = Props.new()
	return props
