use bevy::log::info;

use crate::character::CharacterProps;

use super::get_converter;

pub struct Battle<'a> {
    active: &'a CharacterProps,
    unactive: &'a CharacterProps,
}

impl<'a> Battle<'a> {
    pub fn new(active: &'a CharacterProps, unactive: &'a CharacterProps) -> Self {
        Battle { active, unactive }
    }

    pub fn start(&self) {
        let conventer = get_converter(self.active.conventer_id);

        let damage = conventer.converter_to_damage(self.active.battle_enum);

        info!("damage: {:?}", damage);
    }
}
