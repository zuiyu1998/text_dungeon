class_name PropConst

const ZERO_NAME: Array[String] = []

const DEFAULT_PROPS = {
	"power": preload("res://src/stats/prop/resource/power.tres")
}

static func get_default_props() -> Props:
	var props = Props.new()

	for prop_res: PropResource in DEFAULT_PROPS.values():
		props.set_prop(prop_res.into_prop())	
	
	return props
