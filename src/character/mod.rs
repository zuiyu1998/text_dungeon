mod battle;

use bevy::prelude::*;

pub use battle::*;

pub struct CharacterPlugin;

impl Plugin for CharacterPlugin {
    fn build(&self, app: &mut App) {
        app.add_plugins((BattlePlugin,));
    }
}

#[derive(Component)]
pub struct Character;

#[derive(Component)]
pub struct CharacterProps;

#[derive(Component)]
pub struct CharacterName(String);

#[derive(Bundle)]
pub struct CharacterBundle {
    name: CharacterName,
    props: CharacterProps,
    into_sequence_instace: IntoSequenceInstance,
}
