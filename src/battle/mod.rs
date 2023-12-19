use bevy::{log::info, prelude::*};

use crate::dice::Dice;

use super::props::{Props, PropsComponent};

#[derive(PartialEq, Eq, Clone, Copy)]
pub enum BattleAttack {
    Slash,
}

pub struct Battle {
    active_info: BattleInfo,
    unactive_info: BattleInfo,
    logger: BattleLogger,
}

impl Battle {
    pub fn new(active_info: BattleInfo, unactive_info: BattleInfo) -> Self {
        Self {
            active_info,
            unactive_info,
            logger: BattleLogger::new(),
        }
    }

    fn is_hit(&mut self, result: &mut BattleResult) {
        let mut is_hit = false;
        let is_dodage = self.is_dodge();

        if is_dodage {
            is_hit = true;
        } else {
            let is_defense = self.is_defense();

            if is_defense {
                is_hit = true
            }
        }

        result.is_hit = is_hit;
    }

    pub fn battle(&mut self) -> BattleResult {
        let mut result = BattleResult::default();

        result.attack = self.active_info.attack;

        self.is_hit(&mut result);

        self.damage(&mut result);

        self.logger.flush();

        result
    }

    fn is_defense(&mut self) -> bool {
        let dice_result = self.active_info.defense_dice.get_numer();

        let mut is_dodge = false;

        if (dice_result.real + self.active_info.hit) >= self.unactive_info.defense {
            is_dodge = true;
        }

        self.logger.add_action();

        is_dodge
    }

    fn is_dodge(&mut self) -> bool {
        let dice_result = self.active_info.dodge_dice.get_numer();

        let mut is_dodge = false;

        if (dice_result.real + self.active_info.hit) >= self.unactive_info.dodge {
            is_dodge = true;
        }

        self.logger.add_action();

        is_dodge
    }

    fn is_parry(&mut self, base_damage: i32) -> bool {
        let mut is_parry = false;

        if self.active_info.parry >= base_damage {
            is_parry = true;
        }

        self.logger.add_action();

        is_parry
    }

    fn thump_damage(&mut self, result: &mut BattleResult, base_damage: i32) -> i32 {
        let dice_result = self.active_info.thump_dice.get_numer();

        let mut is_thump = false;

        if (dice_result.real + self.active_info.thump) >= self.unactive_info.defense {
            is_thump = true;
        }

        result.is_thump = is_thump;

        base_damage / (200 + self.active_info.thump_coefficient) / 100
    }

    fn resistance_damage(&mut self, base_damage: i32) -> i32 {
        base_damage / (100 + self.active_info.resistance) / 100
    }

    fn damage(&mut self, result: &mut BattleResult) {
        let mut damage = self.base_damage();

        let is_parry = self.is_parry(damage);

        result.is_parry = is_parry;

        if is_parry {
            damage = 0;
        } else {
            damage = self.thump_damage(result, damage);
            damage = self.resistance_damage(damage);
        }

        result.damage = damage;
    }

    fn base_damage(&mut self) -> i32 {
        let mut damage = self.active_info.base_damage;

        self.active_info.base_damage_dices.iter().for_each(|dice| {
            let result = dice.get_numer();

            damage += result.real;

            self.logger.add_action();
        });

        damage
    }
}

//战斗属性
pub struct BattleInfo {
    //攻击类型
    pub attack: BattleAttack,
    //命中
    pub hit: i32,

    //闪避
    pub dodge: i32,
    //闪避骰
    pub dodge_dice: Dice,

    //防御
    pub defense: i32,
    //防御骰
    pub defense_dice: Dice,

    //基础伤害
    pub base_damage: i32,
    pub base_damage_dices: Vec<Dice>,

    //格挡
    pub parry: i32,

    //重击
    pub thump: i32,
    //重击骰
    pub thump_dice: Dice,

    //重击伤害系数
    pub thump_coefficient: i32,

    //抗性
    pub resistance: i32,
}

pub struct BattleResult {
    //是否命中
    pub is_hit: bool,

    //是否闪避
    pub is_dodge: bool,

    //是否防御
    pub is_defense: bool,

    //是否格挡
    pub is_parry: bool,
    //是否重击
    pub is_thump: bool,

    //伤害数值
    pub damage: i32,
    pub attack: BattleAttack,
}

impl Default for BattleResult {
    fn default() -> Self {
        BattleResult {
            is_hit: false,
            is_defense: false,
            is_dodge: false,
            is_parry: false,
            is_thump: false,
            damage: 0,
            attack: BattleAttack::Slash,
        }
    }
}

pub struct BattleLogger {}

impl BattleLogger {
    pub fn new() -> Self {
        BattleLogger {}
    }

    pub fn add_action(&mut self) {}

    pub fn flush(&mut self) {
        info!("logger flush");
    }
}

#[derive(Component, Deref, DerefMut)]
pub struct BattleResultComponent(BattleResult);

pub trait BattleSettlement {
    fn settlement(&mut self, props: &mut Props, result: &BattleResult);
}

pub fn settlement<S: BattleSettlement + Component>(
    mut q: Query<(&mut S, &mut PropsComponent, &BattleResultComponent)>,
) {
    for (mut settlement, mut props, result) in q.iter_mut() {
        settlement.settlement(&mut props, result);
    }
}
