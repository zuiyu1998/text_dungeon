use bevy::{prelude::*, utils::HashMap};

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
}

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

#[derive(Component)]
pub struct CharacterProps {
    //先攻id
    pub initiative_id: usize,
    pub props: HashMap<PropEnum, PropValue>,
}

impl CharacterProps {
    pub fn get_prop(&self, key: &PropEnum) -> Option<&PropValue> {
        self.props.get(key)
    }

    pub fn get_mut_prop(&mut self, key: &PropEnum) -> Option<&mut PropValue> {
        self.props.get_mut(key)
    }
}

impl Default for CharacterProps {
    fn default() -> Self {
        let mut map: HashMap<PropEnum, PropValue> = HashMap::default();

        map.insert(PropEnum::Initiative, PropValue::default());

        Self {
            initiative_id: 0,
            props: map,
        }
    }
}

pub struct PropsPlugin;

impl Plugin for PropsPlugin {
    fn build(&self, _app: &mut App) {}
}
