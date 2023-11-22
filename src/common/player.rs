use bevy::prelude::*;

#[derive(Component, Default)]
pub struct Player;

#[derive(Bundle, Default)]
pub struct PlayerBundle {
    player: Player,
}
