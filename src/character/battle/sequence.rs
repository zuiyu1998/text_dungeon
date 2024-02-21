use super::{BattleEvent, CharacterProps};
use bevy::prelude::*;

use crate::GameState;

pub struct SequencePlugin;

pub trait IntoSequence: 'static + Sync + Send {
    fn into_sequece(&self, props: &CharacterProps) -> Sequence;
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
pub struct IntoSequenceInstance(Box<dyn IntoSequence>);

impl Default for IntoSequenceInstance {
    fn default() -> Self {
        IntoSequenceInstance(Box::new(DefaultSequence))
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
    character_q: Query<(&CharacterProps, &IntoSequenceInstance), Without<Sequence>>,
) {
    for e in battle_ew.read() {
        for entity in e.0.iter() {
            if let Ok((props, into_sequence)) = character_q.get(*entity) {
                let sequnce = into_sequence.0.into_sequece(props);
                commands.entity(*entity).insert(sequnce);
            }
        }
    }
}

//判定当前帧谁行动
fn select_charcter(mut commands: Commands, character_q: Query<(Entity, &mut Sequence)>) {
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
}
