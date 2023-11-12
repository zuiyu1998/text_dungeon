use bevy::{ecs::system::SystemParam, prelude::*};

#[derive(Clone, Eq, PartialEq, Debug, Hash, Copy)]
pub enum NavigationState {
    InGame,
}

impl NavigationState {
    pub fn get_states(&self) -> (AppState, GameState) {
        match self {
            NavigationState::InGame => (AppState::InGame, GameState::Player),
        }
    }
}

#[derive(SystemParam)]
pub struct Navigation<'w> {
    app_state: ResMut<'w, NextState<AppState>>,
    game_state: ResMut<'w, NextState<GameState>>,
}

impl<'w> Navigation<'w> {
    pub fn next(&mut self, next: NavigationState) {
        let (next_app_state, next_game_state) = next.get_states();

        self.app_state.set(next_app_state);
        self.game_state.set(next_game_state);
    }
}

#[derive(States, Default, Clone, Eq, PartialEq, Debug, Hash)]
pub enum AppState {
    // During the loading State the LoadingPlugin will load our assets
    #[default]
    Splash,
    InGame,
    MainMenu,
}

#[derive(States, Default, Clone, Eq, PartialEq, Debug, Hash)]
pub enum GameState {
    #[default]
    None,
    Player,
    InGameMenu,
}
