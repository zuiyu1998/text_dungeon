#![allow(clippy::type_complexity)]

mod audio;
mod common;
mod in_game;
mod menu;
mod props;
mod splash;
mod states;

use crate::audio::InternalAudioPlugin;
use crate::in_game::InGamePlugin;
use crate::menu::MenuPlugin;
use crate::splash::LoadingPlugin;
use states::*;

use bevy::app::App;
#[cfg(debug_assertions)]
use bevy::diagnostic::{FrameTimeDiagnosticsPlugin, LogDiagnosticsPlugin};
use bevy::prelude::*;

pub struct GamePlugin;

impl Plugin for GamePlugin {
    fn build(&self, app: &mut App) {
        app.add_state::<AppState>()
            .add_state::<GameState>()
            .add_plugins((LoadingPlugin, MenuPlugin, InternalAudioPlugin, InGamePlugin));

        #[cfg(debug_assertions)]
        {
            app.add_plugins((FrameTimeDiagnosticsPlugin, LogDiagnosticsPlugin::default()));
        }
    }
}
