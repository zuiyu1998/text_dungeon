use super::{BattleActive, BattleEvent, BattleUnactive, CharacterProps, InCombat};
use bevy::prelude::*;

use crate::GameState;

pub struct SequencePlugin;

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
    fn into_sequece(&self, _props: &CharacterProps) -> Sequence {
        Sequence {
            value: 0,
            state: SequenceState::None,
        }
    }
}

#[derive(Component)]
pub struct Sequence {
    value: u8,
    state: SequenceState,
}

#[derive(Debug)]
pub struct SequenceEntity {
    entity: Entity,
    value: u8,
}

#[derive(PartialEq, Eq)]
enum SequenceState {
    None,
    Active,
}

impl Plugin for SequencePlugin {
    fn build(&self, app: &mut App) {
        app.add_systems(
            Update,
            (add_sequenece_marker, select_charcter).run_if(in_state(GameState::Playing)),
        );
    }
}

//对character添加先手
fn add_sequenece_marker(
    mut commands: Commands,
    mut battle_ew: EventReader<BattleEvent>,
    character_q: Query<(&CharacterProps,), Without<Sequence>>,
) {
    for e in battle_ew.read() {
        for entity in e.0.iter() {
            if let Ok((props,)) = character_q.get(*entity) {
                let sequence = get_into_sequence(props.initiative_id).into_sequece(props);
                commands.entity(*entity).insert(sequence);
            }
        }
    }
}

//判定当前帧谁行动
fn select_charcter(
    mut commands: Commands,
    mut character_q: Query<(Entity, &mut Sequence), Without<InCombat>>,
) {
    let mut sequences = vec![];

    for (entity, sequence) in character_q.iter() {
        if sequence.state == SequenceState::None {
            sequences.push(SequenceEntity {
                entity,
                value: sequence.value,
            });
        }
    }

    if sequences.is_empty() {
        return;
    }

    sequences.sort_by(|a, b| a.value.cmp(&b.value));

    info!("{:?}", sequences);

    let (first, other) = sequences.split_first().unwrap();

    let mut sequence = character_q
        .get_component_mut::<Sequence>(first.entity)
        .unwrap();

    sequence.state = SequenceState::Active;

    commands
        .entity(first.entity)
        .insert((BattleActive, InCombat));

    for sequence in other.iter() {
        commands
            .entity(sequence.entity)
            .insert((BattleUnactive(first.entity), InCombat));
    }
}
