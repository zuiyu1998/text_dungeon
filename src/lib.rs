#![allow(clippy::type_complexity)]

mod audio;
mod character;
mod db;
mod editor;
mod loading;
mod map;
mod menu;
mod state;

use crate::audio::InternalAudioPlugin;
use crate::character::CharacterPlugin;
use crate::db::DbPlugin;
use crate::loading::LoadingPlugin;
use crate::map::MapPlugin;
use crate::menu::MenuPlugin;
use crate::state::*;

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
            CharacterPlugin,
            MapPlugin,
            DbPlugin,
        ));

        #[cfg(feature = "dev")]
        {
            app.add_plugins((InternalEditorPlugin,));
        }
    }
}
