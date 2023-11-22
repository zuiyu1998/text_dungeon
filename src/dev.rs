use bevy::prelude::*;
use bevy_editor_pls::prelude::*;

pub struct DevPlugin;

impl Plugin for DevPlugin {
    fn build(&self, app: &mut App) {
        app.add_plugins((EditorPlugin::default(),));
    }
}
