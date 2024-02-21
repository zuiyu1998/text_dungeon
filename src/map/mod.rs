use crate::{
    character::{BattleEvent, CharacterBundle},
    GameState,
};
use bevy::prelude::*;

pub struct MapPlugin;

#[derive(Component)]
pub struct Player;

#[derive(Component)]
pub struct Test1;

impl Plugin for MapPlugin {
    fn build(&self, app: &mut App) {
        app.add_systems(OnEnter(GameState::Playing), (spwan_playe, spawn_enemy));
        app.add_systems(Update, test_attack.run_if(in_state(GameState::Playing)));
    }
}

fn spwan_playe(mut commands: Commands) {
    commands.spawn((CharacterBundle::default(), Player));
}

fn spawn_enemy(mut commands: Commands) {
    commands.spawn((CharacterBundle::default(), Test1));
}

fn test_attack(
    player: Query<Entity, With<Player>>,
    test1: Query<Entity, With<Test1>>,
    input: Res<Input<MouseButton>>,
    mut battle_ew: EventWriter<BattleEvent>,
) {
    let player = player.single();
    let test1 = test1.single();

    if input.just_pressed(MouseButton::Left) {
        battle_ew.send(BattleEvent(vec![player, test1]));
    }
}
