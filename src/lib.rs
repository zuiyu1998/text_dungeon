#![allow(clippy::type_complexity)]

mod actions;
mod audio;
mod editor;
mod loading;
mod menu;
mod player;
mod state;

use crate::actions::ActionsPlugin;
use crate::audio::InternalAudioPlugin;
use crate::loading::LoadingPlugin;
use crate::menu::MenuPlugin;
use crate::player::PlayerPlugin;
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
            ActionsPlugin,
            InternalAudioPlugin,
            PlayerPlugin,
            AppStatePlugin,
        ));

        #[cfg(feature = "dev")]
        {
            app.add_plugins((InternalEditorPlugin,));
        }
    }
}
