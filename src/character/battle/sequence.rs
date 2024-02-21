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
        Sequence(0)
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
pub struct Sequence(u8);

impl Plugin for SequencePlugin {
    fn build(&self, app: &mut App) {
        app.add_systems(
            Update,
            (add_sequenece_marker,).run_if(in_state(GameState::Playing)),
        );
    }
}

//对character添加先手标记
fn add_sequenece_marker(
    mut commands: Commands,
    mut battle_ew: EventReader<BattleEvent>,
    character_q: Query<(&CharacterProps, &IntoSequenceInstance)>,
) {
    for e in battle_ew.read() {
        for entity in e.0.iter() {
            let (props, into_sequence) = character_q.get(*entity).unwrap();

            let sequnce = into_sequence.0.into_sequece(props);

            commands.entity(*entity).insert(sequnce);
        }
    }
}
