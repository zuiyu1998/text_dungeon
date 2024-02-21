use bevy::{ecs::system::SystemParam, prelude::*};

#[derive(SystemParam)]
pub struct AppStateMachine<'w> {
    app_next_state: ResMut<'w, NextState<AppState>>,
    game_next_state: ResMut<'w, NextState<GameState>>,
    app_flow_state: ResMut<'w, AppFlowState>,
}

impl<'w> AppStateMachine<'w> {
    pub fn transition_state(&mut self, next: AppFlowState) {
        if *self.app_flow_state != next {
            *self.app_flow_state = next;

            let (app_state, game_state) = self.app_flow_state.get_states();

            self.app_next_state.set(app_state);
            self.game_next_state.set(game_state);
        }
    }
}

#[derive(Default, Clone, Eq, PartialEq, Debug, Hash, Resource, Copy)]
pub enum AppFlowState {
    #[default]
    Spalsh,
    Playing,
    Pause,
    MainMenu,
}

impl AppFlowState {
    pub fn get_states(&self) -> (AppState, GameState) {
        match *self {
            AppFlowState::Spalsh => (AppState::Spalsh, GameState::None),
            AppFlowState::MainMenu => (AppState::MainMenu, GameState::None),
            AppFlowState::Playing => (AppState::InGame, GameState::Playing),
            AppFlowState::Pause => (AppState::InGame, GameState::Pause),
        }
    }
}

#[derive(States, Default, Clone, Eq, PartialEq, Debug, Hash)]
pub enum AppState {
    #[default]
    Spalsh,
    InGame,
    MainMenu,
}

#[derive(States, Default, Clone, Eq, PartialEq, Debug, Hash)]
pub enum GameState {
    #[default]
    None,
    Playing,
    Pause,
}

pub struct AppStatePlugin;

impl Plugin for AppStatePlugin {
    fn build(&self, app: &mut App) {
        app.add_state::<AppState>().add_state::<GameState>();

        let app_flow_state = AppFlowState::default();

        let (app_state, game_state) = app_flow_state.get_states();

        app.insert_resource(app_flow_state)
            .insert_resource(State::new(app_state))
            .insert_resource(State::new(game_state));
    }
}
