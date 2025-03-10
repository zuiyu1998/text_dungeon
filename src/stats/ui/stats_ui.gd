class_name StatsUi
extends PanelContainer

@export var stats: Stats
# 武器信息
# 属性信息
#
@onready var physic_damage: PropUi = $MarginContainer/VBoxContainer/GridContainer/PhysicDamage
@onready var magic_damage: PropUi = $MarginContainer/VBoxContainer/GridContainer/MagicDamage
@onready
var weapon_ui: WeaponUi = $MarginContainer/VBoxContainer/VBoxContainer/WeaponContainer/WeaponUi
@onready var v_box_container: VBoxContainer = $MarginContainer/VBoxContainer
@onready var dexterity: PropUi = $MarginContainer/VBoxContainer/GridContainer/Dexterity
@onready var constitution: PropUi = $MarginContainer/VBoxContainer/GridContainer/Constitution
@onready var charisma: PropUi = $MarginContainer/VBoxContainer/GridContainer/Charisma
@onready var intelligence: PropUi = $MarginContainer/VBoxContainer/GridContainer/Intelligence
@onready var wisdom: PropUi = $MarginContainer/VBoxContainer/GridContainer/Wisdom
@onready var strength: PropUi = $MarginContainer/VBoxContainer/GridContainer/Strength
@onready var first_attack: PropUi = $MarginContainer/VBoxContainer/GridContainer/FirstAttack


func update_ui(info: Stats.StatsInfo):
	physic_damage.update_prop("物理伤害", info.physic_damage)
	magic_damage.update_prop("魔法伤害", info.magic_damage)
	weapon_ui.update_ui(info.weapon_info)
	dexterity.update_prop("敏捷", info.props["dexterity"])
	constitution.update_prop("体质", info.props["constitution"])
	charisma.update_prop("魅力", info.props["charisma"])
	intelligence.update_prop("智力", info.props["intelligence"])
	wisdom.update_prop("感知", info.props["wisdom"])
	strength.update_prop("力量", info.props["strength"])
	first_attack.update_prop("先攻", info.props["first_attack"])


func _ready() -> void:
	stats.state_info_update.connect(update_ui)
