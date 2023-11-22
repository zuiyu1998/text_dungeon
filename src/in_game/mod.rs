use crate::common::PlayerBundle;
use crate::states::GameState;
use bevy::prelude::*;

pub struct InGamePlugin;

impl Plugin for InGamePlugin {
    fn build(&self, app: &mut App) {
        app.add_systems(OnEnter(GameState::Playing), setup_player);
    }
}

pub fn setup_player(mut commands: Commands) {
    commands.spawn(PlayerBundle::default());
}
