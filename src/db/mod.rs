mod character_props;

use bevy::prelude::*;

pub use character_props::*;

pub struct CharacterPropsModel {
    initiative_id: usize,
}

pub struct DbPlugin;

impl Plugin for DbPlugin {
    fn build(&self, app: &mut App) {
        app.init_asset_loader::<CharacterPropValuesAssetLoader>();
    }
}
