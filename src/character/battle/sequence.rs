use super::CharacterProps;
use bevy::prelude::*;

use crate::character::PropEnum;

enum IntoSequenceType {
    Default,
    Unkown,
}

impl From<usize> for IntoSequenceType {
    fn from(value: usize) -> Self {
        match value {
            0 => IntoSequenceType::Default,
            _ => IntoSequenceType::Unkown,
        }
    }
}

pub trait IntoSequence: 'static + Sync + Send {
    fn into_sequece(&self, props: &CharacterProps) -> Sequence;
}

pub fn get_into_sequence(id: usize) -> Box<dyn IntoSequence> {
    let _type: IntoSequenceType = IntoSequenceType::from(id);

    match _type {
        IntoSequenceType::Default => Box::new(DefaultSequence),
        _ => Box::new(DefaultSequence),
    }
}

pub struct DefaultSequence;

impl IntoSequence for DefaultSequence {
    fn into_sequece(&self, props: &CharacterProps) -> Sequence {
        let value = props.get_prop(&PropEnum::Initiative).unwrap().get_value() as u8;

        Sequence {
            value,
            state: SequenceState::None,
        }
    }
}

#[derive(Component)]
pub struct Sequence {
    pub value: u8,
    pub state: SequenceState,
}

#[derive(Debug)]
pub struct SequenceEntity {
    pub entity: Entity,
    pub value: u8,
}

#[derive(PartialEq, Eq)]
pub enum SequenceState {
    None,
    Active,
}
