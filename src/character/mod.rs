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

#[derive(Component, Default)]
pub struct CharacterProps;

#[derive(Component, Default)]
pub struct CharacterName(String);

#[derive(Bundle, Default)]
pub struct CharacterBundle {
    name: CharacterName,
    props: CharacterProps,
    into_sequence_instace: IntoSequenceInstance,
}
