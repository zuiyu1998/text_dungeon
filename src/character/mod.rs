mod battle;
mod props;

use bevy::prelude::*;

pub use battle::*;
pub use props::*;

pub struct CharacterPlugin;

impl Plugin for CharacterPlugin {
    fn build(&self, app: &mut App) {
        app.add_plugins((BattlePlugin, PropsPlugin));
    }
}

#[derive(Component)]
pub struct Character;

#[derive(Component, Default)]
pub struct CharacterName(String);

#[derive(Bundle, Default)]
pub struct CharacterBundle {
    pub name: CharacterName,
    pub props: CharacterProps,
}
