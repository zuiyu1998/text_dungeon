use bevy::{prelude::*, utils::HashMap};

use crate::db::{CharacterPropValuesAsset, CharacterPropsDb, CharacterPropsModel};

#[derive(Default, Debug)]

pub enum BattleEnum {
    #[default]
    Splash,
}

#[derive(Debug, Hash, Clone, Copy, PartialEq, Eq)]
pub enum PropEnum {
    Initiative,
    Power,
    Agile,
    Constitution,
    Intelligence,
    Charm,
    Perception,
    Dodge,
    Burden,
    PysicalHit,
    MagicHit,
    Armor,
    Parrying,
    Thump,
    Defense,
    ThumpRate,
    ThumpRateDefault,
    HealthMax,
    Unknow,
}

impl From<&str> for PropEnum {
    fn from(value: &str) -> Self {
        match value {
            "HealthMax" => PropEnum::HealthMax,
            "ThumpRateDefault" => PropEnum::ThumpRateDefault,
            "ThumpRate" => PropEnum::ThumpRate,
            "Defense" => PropEnum::Defense,
            "Thump" => PropEnum::Thump,
            "Parrying" => PropEnum::Parrying,
            "Armor" => PropEnum::Armor,
            "MagicHit" => PropEnum::MagicHit,
            "Initiative" => PropEnum::Initiative,
            "PysicalHit" => PropEnum::PysicalHit,
            "Power" => PropEnum::Power,
            "Agile" => PropEnum::Agile,
            "Constitution" => PropEnum::Constitution,
            "Intelligence" => PropEnum::Intelligence,
            "Charm" => PropEnum::Charm,
            "Perception" => PropEnum::Perception,
            "Dodge" => PropEnum::Dodge,
            "Burden" => PropEnum::Burden,
            _ => PropEnum::Unknow,
        }
    }
}

#[derive(Debug)]
pub struct PropValue {
    max: f32,
    value: f32,
}

impl PropValue {
    pub fn get_value(&self) -> usize {
        let tmp = self.value.clamp(0.0, self.max);

        tmp as usize
    }

    pub fn set_value(&mut self, new: f32) {
        self.value = new;
    }
}

impl Default for PropValue {
    fn default() -> Self {
        Self {
            max: 100.0,
            value: 10.0,
        }
    }
}

#[derive(Default, Debug)]
pub struct CharacterPropsMeta {
    pub id: usize,
}

#[derive(Component, Default, Debug)]
pub struct CharacterProps {
    //先攻id
    pub initiative_id: usize,
    pub props: HashMap<PropEnum, PropValue>,
    pub meta: CharacterPropsMeta,
    pub battle_enum: BattleEnum,
}

impl CharacterProps {
    pub fn from_db(&mut self, db: &CharacterPropsDb) {
        let (model, prop_values_asset) = db.get_id(self.meta.id);
        self.update_by_assets(prop_values_asset, model);
    }

    pub fn get_prop(&self, key: &PropEnum) -> Option<&PropValue> {
        self.props.get(key)
    }

    pub fn get_mut_prop(&mut self, key: &PropEnum) -> Option<&mut PropValue> {
        self.props.get_mut(key)
    }

    fn update_by_assets(
        &mut self,
        prop_values_asset: &CharacterPropValuesAsset,
        model: &CharacterPropsModel,
    ) {
        self.props = prop_values_asset
            .0
            .iter()
            .map(|model| {
                (
                    PropEnum::from(model.prop_enum.as_str()),
                    PropValue {
                        max: model.max,
                        value: model.value,
                    },
                )
            })
            .collect::<HashMap<PropEnum, PropValue>>();

        self.initiative_id = model.initiative_id;
    }
}

pub struct PropsPlugin;

impl Plugin for PropsPlugin {
    fn build(&self, _app: &mut App) {}
}
