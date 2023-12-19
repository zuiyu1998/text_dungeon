#![allow(clippy::type_complexity)]

mod audio;
mod battle;
mod common;
mod dice;
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

#[cfg(feature = "dev")]
mod dev;

use bevy::prelude::*;

pub struct GamePlugin;

impl Plugin for GamePlugin {
    fn build(&self, app: &mut App) {
        app.add_state::<AppState>()
            .add_state::<GameState>()
            .add_plugins((LoadingPlugin, MenuPlugin, InternalAudioPlugin, InGamePlugin));

        #[cfg(feature = "dev")]
        {
            use crate::dev::DevPlugin;
            app.add_plugins((DevPlugin,));
        }
    }
}
