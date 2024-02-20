#![allow(clippy::type_complexity)]

mod audio;
mod editor;
mod loading;
mod menu;
mod state;

use crate::audio::InternalAudioPlugin;
use crate::loading::LoadingPlugin;
use crate::menu::MenuPlugin;
use crate::state::AppStatePlugin;

use bevy::app::App;
use bevy::prelude::*;

#[cfg(feature = "dev")]
use editor::InternalEditorPlugin;

pub struct GamePlugin;

impl Plugin for GamePlugin {
    fn build(&self, app: &mut App) {
        app.add_plugins((
            LoadingPlugin,
            MenuPlugin,
            InternalAudioPlugin,
            AppStatePlugin,
        ));

        #[cfg(feature = "dev")]
        {
            app.add_plugins((InternalEditorPlugin,));
        }
    }
}
