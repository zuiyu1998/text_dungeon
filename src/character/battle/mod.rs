mod sequence;

use crate::character::CharacterProps;
use bevy::prelude::*;

pub use sequence::*;

#[derive(Event)]
pub struct BattleEvent(pub Vec<Entity>);

#[derive(Component)]
pub struct InCombat;

#[derive(Component)]
pub struct BattleActive;

#[derive(Component)]
pub struct BattleUnactive(pub Entity);

pub struct BattlePlugin;

impl Plugin for BattlePlugin {
    fn build(&self, app: &mut App) {
        app.add_plugins((SequencePlugin,))
            .add_event::<BattleEvent>();
    }
}
