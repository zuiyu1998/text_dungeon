use crate::{
    character::{BattleEvent, CharacterBundle, CharacterProps, PropEnum},
    db::CharacterPropsDb,
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
        app.add_systems(OnEnter(GameState::Playing), (spwan_player, spawn_enemy));
        app.add_systems(Update, test_attack.run_if(in_state(GameState::Playing)));
    }
}

fn spwan_player(mut commands: Commands, character_db: CharacterPropsDb) {
    let mut props: CharacterProps = Default::default();
    props.from_db(&character_db);

    if let Some(prop) = props.get_mut_prop(&PropEnum::Initiative) {
        prop.set_value(20.0);
    }

    commands.spawn((
        CharacterBundle {
            props,
            ..Default::default()
        },
        Player,
    ));
}

fn spawn_enemy(mut commands: Commands, character_db: CharacterPropsDb) {
    let mut props: CharacterProps = Default::default();
    props.from_db(&character_db);

    commands.spawn((
        CharacterBundle {
            props,
            ..Default::default()
        },
        Test1,
    ));
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
