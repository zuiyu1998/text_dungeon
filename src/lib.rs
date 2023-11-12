#![allow(clippy::type_complexity)]

mod audio;
mod common;
mod menu;
mod splash;
mod states;

use crate::audio::InternalAudioPlugin;
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
            .add_plugins((LoadingPlugin, MenuPlugin, InternalAudioPlugin));

        #[cfg(debug_assertions)]
        {
            app.add_plugins((FrameTimeDiagnosticsPlugin, LogDiagnosticsPlugin::default()));
        }
    }
}
