use crate::character::props::BattleEnum;

#[derive(Debug, Clone, Copy)]
pub enum DamageEnum {
    Slash,
}

pub fn get_converter(id: usize) -> Box<dyn DamageBattleConverter> {
    match id {
        0 => Box::new(DefaultDamageBattleConverter),
        _ => Box::new(DefaultDamageBattleConverter),
    }
}

pub struct DefaultDamageBattleConverter;

impl DamageBattleConverter for DefaultDamageBattleConverter {}

pub trait DamageBattleConverter {
    fn converter_to_damage(&self, battle: BattleEnum) -> DamageEnum {
        match battle {
            BattleEnum::Slash => DamageEnum::Slash,
        }
    }
}
