mod battle;
mod damage_battle_converter;
mod sequence;
mod systems;

pub use battle::*;
pub use damage_battle_converter::*;
pub use sequence::*;

use crate::{character::CharacterProps, state::GameState};
use bevy::prelude::*;
use systems::{add_sequenece_marker, select_charcter, start_battle};

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
        app.add_event::<BattleEvent>().add_systems(
            Update,
            (add_sequenece_marker, select_charcter, start_battle)
                .run_if(in_state(GameState::Playing)),
        );
    }
}
