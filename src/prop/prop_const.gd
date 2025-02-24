class_name PropConst

const ZERO_NAME: Array[String] = []

const DEFAULT_PROPS = {
	# 力量
	"strength": preload("res://src/prop/resource/strength.tres"),
	# 智力
	"intelligence": preload("res://src/prop/resource/intelligence.tres"),
	# 感知
	"wisdom": preload("res://src/prop/resource/wisdom.tres"),
	# 敏捷
	"dexterity": preload("res://src/prop/resource/dexterity.tres"),
	# 体质
	"constitution": preload("res://src/prop/resource/constitution.tres"),
	# 魅力
	"charisma": preload("res://src/prop/resource/charisma.tres"),
	# 先攻
	"first_attack": preload("res://src/prop/resource/first_attack/first_attack.tres")
}


static func get_default_props() -> Props:
	var props = Props.new()

	for prop_res: PropResource in DEFAULT_PROPS.values():
		props.set_prop(prop_res.into_prop())

		for effct in prop_res.effcts:
			props.set_effct(effct)

	return props
