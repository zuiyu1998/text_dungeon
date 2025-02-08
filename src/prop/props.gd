class_name Props

var _data: Dictionary = {}

func get_prop(prop_name: String) -> Prop:
	return _data[prop_name]

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
