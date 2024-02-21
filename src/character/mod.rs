use crate::battle::IntoSequenceInstance;
use bevy::prelude::*;

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
